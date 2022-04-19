----------------------------------------------------------------------------------
-- pipeline_vote_counter_core.vhd - A specialised pipeline processor implementation
-- 
-- ISA for this processor is delibrately designed like a 2 state state-machine
-- 
-- each instruction is 1-bit wide
-- noop 
--      # no operation
--      # opcode = 0
-- 
-- gen_tag
--      # generate a tag for the record stored in the record register based on the secret stored in the secret register
--      # opcode = 1 
--
-- Architecture Specification
-- width
-- program counter : 1 bit
-- instruction memory : 1 bit
-- dedicated register : 32 bits
-- data memory : 32 bits
-- 
--
-- Copyright (C) 2022 by Shaoqian Zhou, William Ye and Yuval Kansal
-- All Rights Reserved.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pipeline_vote_counter_core is
    port (  clk         : in std_logic;
            reset       : in std_logic;
            send        : in std_logic;
            rec_in         : in std_logic_vector(31 downto 0);
            rec_tag_in     : in std_logic_vector(7 downto 0);
            busy        : out std_logic);
           
end pipeline_vote_counter_core;

architecture Behavioral of pipeline_vote_counter_core is
component program_counter is
    port ( reset    : in  std_logic;
           clk      : in  std_logic;
           En       : in  std_logic;
           addr_out : buffer std_logic);
end component;



component control_unit is
     port ( reset       : in std_logic;
            pc_state    : in  std_logic;
           tag_gen      : out std_logic;
           sec_load     : out std_logic;
           busy         : out std_logic);
end component;

component regn is
    generic ( n : integer := 5 ) ;
	port(	D 		: in std_logic_vector(n-1 downto 0) ;
			reset	: in std_logic;
			clk 	: in std_logic;
			Q 		: out std_logic_vector(n-1 downto 0) ) ;
end component;

component regnld is
    generic ( n : integer := 5 ) ;
	port(	D 			     : in std_logic_vector(n-1 DOWNTO 0) ;
			clk, reset, L	 : in std_logic;			 	   
			Q 			     : out std_logic_vector(n-1 DOWNTO 0) ) ;
end component;

component data_memory is
    port ( reset        : in  std_logic;
           clk          : in  std_logic;
           write_enable : in  std_logic;
           write_data   : in  std_logic_vector(31 downto 0);
           rec_addr_in     : in  std_logic_vector(9 downto 0);
           tot_addr_in     : in  std_logic_vector(9 downto 0);
           sec_data_out     : out std_logic_vector(31 downto 0) );
end component;

component addr_unit is
    port ( rec : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(9 downto 0);
            rec_addr : out std_logic_vector(9 downto 0);
            tot_addr : out std_logic_vector(9 downto 0));  -- 10 bits address space
end component;

component swap is
     port (swap_key      : in std_logic_vector(12 downto 0);
              D3            : in std_logic_vector(7 downto 0);
              D2            : in std_logic_vector(7 downto 0);
              D1            : in std_logic_vector(7 downto 0);
              D0            : in std_logic_vector(7 downto 0);
              A3            : out std_logic_vector(7 downto 0);
              A2            : out std_logic_vector(7 downto 0);
              A1            : out std_logic_vector(7 downto 0);
              A0            : out std_logic_vector(7 downto 0));
end component;



component rol_8b is
    port ( blk : in std_logic_vector(7 downto 0);
    		offset : in std_logic_vector(2 downto 0);
    		blk_out : out std_logic_vector(7 downto 0));
end component;

component xor_tag is
     port (B0 : in  std_logic_vector(7 downto 0);
           B1 : in  std_logic_vector(7 downto 0);
           B2 : in  std_logic_vector(7 downto 0);
           B3 : in  std_logic_vector(7 downto 0);
           our_tag : out std_logic_vector(7 downto 0));
end component;


component comparator is
    port ( our_tag : in std_logic_vector(7 downto 0);
           orig_tag : in std_logic_vector(7 downto 0);
           valid_tag : out std_logic); 
end component;

-- signals
-- SM stage
signal sig_pc_state : std_logic;

    -- control signals
    signal sig_tag_gen_sm : std_logic;
 
    signal sig_sec_load : std_logic;
    
signal sig_sec_sm : std_logic_vector(24 downto 0);
signal sig_rec_sm : std_logic_vector(31 downto 0);
signal sig_tag_sm : std_logic_vector(7 downto 0);

signal sig_sm_swap_in : std_logic_vector(65 downto 0);

-- SWAP stage
signal sig_sm_swap_out : std_logic_vector(65 downto 0);
signal sig_sec_swap : std_logic_vector(24 downto 0);
signal sig_rec_swap : std_logic_vector(31 downto 0);
signal sig_tag_swap : std_logic_vector(7 downto 0);
signal sig_swap_rol_in : std_logic_vector(97 downto 0);

signal sig_a3 : std_logic_vector(7 downto 0);
signal sig_a2 : std_logic_vector(7 downto 0);
signal sig_a1 : std_logic_vector(7 downto 0);
signal sig_a0 : std_logic_vector(7 downto 0);
    
    -- control signals
    signal sig_tag_gen_swap : std_logic;

-- ROL stage
signal sig_swap_rol_out : std_logic_vector(97 downto 0);
signal sig_sec_rol : std_logic_vector(24 downto 0);
signal sig_rec_rol : std_logic_vector(31 downto 0);
signal sig_tag_rol : std_logic_vector(7 downto 0);
signal sig_rol_xor_in : std_logic_vector(72 downto 0);

signal sig_b3 : std_logic_vector(7 downto 0);
signal sig_b2 : std_logic_vector(7 downto 0);
signal sig_b1 : std_logic_vector(7 downto 0);
signal sig_b0 : std_logic_vector(7 downto 0);

    -- control signals
    signal sig_tag_gen_rol : std_logic;

-- XOR stage
signal sig_rol_xor_out : std_logic_vector(72 downto 0);
signal sig_rec_xor : std_logic_vector(31 downto 0);
signal sig_tag_xor : std_logic_vector(7 downto 0);
signal sig_tag_out : std_logic_vector(7 downto 0);
signal sig_cmp_result_xor : std_logic;
signal sig_rec_addr_xor : std_logic_vector(9 downto 0);
signal sig_tot_addr_xor : std_logic_vector(9 downto 0);
signal sig_xor_mem_in : std_logic_vector(53 downto 0);

    -- control signals
    signal sig_tag_gen_xor : std_logic;

-- MEM stage
signal sig_cmp_result_mem : std_logic;
signal sig_tag_gen_mem : std_logic;
signal sig_rec_addr_mem : std_logic_vector(9 downto 0);
signal sig_tot_addr_mem : std_logic_vector(9 downto 0);
signal sig_xor_mem_out : std_logic_vector(53 downto 0);
signal sig_sec_out : std_logic_vector(31 downto 0);
signal sig_write_en : std_logic;



begin

    -- SM stage
    pc_state_machine : program_counter
        port map ( reset => reset,
                    clk => clk,
                    En => send,    
                    addr_out => sig_pc_state);
                    
                    
    ctr_unit : control_unit
        port map ( reset => reset,
                    pc_state => sig_pc_state,
                    tag_gen => sig_tag_gen_sm,
                    sec_load => sig_sec_load,
                    busy => busy);
    
    reg_sec : regnld
        generic map (n => 25)
        port map ( D => sig_sec_out(24 downto 0),
                    clk => clk,
                    reset => '0',
                    L => sig_sec_load,
                    Q => sig_sec_sm);
                    
                    
    reg_rec : regn
        generic map (n => 32)
        port map ( D => rec_in,
                    clk => clk,
                    reset => '0',
                    Q => sig_rec_sm);
                    
    reg_tag : regn
        generic map (n => 8)
        port map ( D => rec_tag_in,
                   clk => clk,
                   reset => '0',
                   Q => sig_tag_sm);
    
    sig_sm_swap_in <= sig_tag_gen_sm & sig_sec_sm & sig_rec_sm & sig_tag_sm;
    
    -- SM/SWAP stage register
    sm_swap_reg : regn
        generic map (n => 66)
        port map ( D => sig_sm_swap_in,
                    clk => clk,
                    reset => '0',
                    Q => sig_sm_swap_out);
    
    sig_tag_gen_swap <= sig_sm_swap_out(65);
    sig_sec_swap <= sig_sm_swap_out(64 downto 40);
    sig_rec_swap <= sig_sm_swap_out(39 downto 8);
    sig_tag_swap <= sig_sm_swap_out(7 downto 0);
    
    -- SWAP stage
    swapper : swap
        port map ( swap_key => sig_sec_swap(12 downto 0),
                    D3 => sig_rec_swap(31 downto 24),
                    D2 => sig_rec_swap(23 downto 16),
                    D1 => sig_rec_swap(15 downto 8),
                    D0 => sig_rec_swap(7 downto 0),
                    A3 => sig_a3(7 downto 0),
                    A2 => sig_a2(7 downto 0),
                    A1 => sig_a1(7 downto 0),
                    A0 => sig_a0(7 downto 0));
                    
    sig_swap_rol_in <= sig_tag_gen_swap & sig_a3 & sig_a2 & sig_a1 & sig_a0 & sig_sec_swap & sig_rec_swap & sig_tag_swap;
    
    -- SWAP/ROL stage register
    swap_rol_reg : regn
        generic map (n => 98)
        port map ( D => sig_swap_rol_in,
                    clk => clk,
                    reset => '0',
                    Q => sig_swap_rol_out);
    
    sig_tag_gen_rol <= sig_swap_rol_out(97);
    sig_sec_rol <= sig_swap_rol_out(64 downto 40);
    sig_rec_rol <= sig_swap_rol_out(39 downto 8);
    sig_tag_rol <= sig_swap_rol_out(7 downto 0);
    

    rotate_0 : rol_8b
        port map ( blk => sig_swap_rol_out(72 downto 65),
                    offset => sig_sec_rol(15 downto 13),
                    blk_out => sig_b0);
    
    rotate_1 : rol_8b
        port map ( blk => sig_swap_rol_out(80 downto 73),
                    offset => sig_sec_rol(18 downto 16),
                    blk_out => sig_b1);
    
    rotate_2 : rol_8b
        port map ( blk => sig_swap_rol_out(88 downto 81),
                    offset => sig_sec_rol(21 downto 19),
                    blk_out => sig_b2);
    
    rotate_3 : rol_8b
        port map ( blk => sig_swap_rol_out(96 downto 89),
                    offset => sig_sec_rol(24 downto 22),
                    blk_out => sig_b3);
    
    
    sig_rol_xor_in <= sig_tag_gen_rol & sig_b3 & sig_b2 & sig_b1 & sig_b0 & sig_rec_rol & sig_tag_rol;
    
    rol_xor_reg : regn
        generic map (n => 73)
        port map ( D => sig_rol_xor_in,
                    clk => clk,
                    reset => '0',
                    Q => sig_rol_xor_out);
    
    sig_tag_gen_xor <= sig_rol_xor_out(72);
    sig_rec_xor <= sig_rol_xor_out(39 downto 8);
    sig_tag_xor <= sig_rol_xor_out(7 downto 0);
    
    tag_gen : xor_tag
        port map ( B0 => sig_rol_xor_out(47 downto 40),
                    B1 => sig_rol_xor_out(55 downto 48),
                    B2 => sig_rol_xor_out(63 downto 56),
                    B3 => sig_rol_xor_out(71 downto 64),
                    our_tag => sig_tag_out);
    
    cmp : comparator
        port map ( our_tag => sig_tag_out,
                    orig_tag => sig_tag_xor,
                    valid_tag => sig_cmp_result_xor);
    
    addr_u : addr_unit
        port map ( rec => sig_rec_xor,
                    offset => "0000000001",
                    rec_addr => sig_rec_addr_xor,
                    tot_addr => sig_tot_addr_xor);
        
        
        
    sig_xor_mem_in <= sig_tag_gen_xor & sig_cmp_result_xor & sig_rec_addr_xor & sig_tot_addr_xor & "000000000" & sig_rec_xor(22 downto 0);
    
    
    xor_mem_reg : regn
        generic map (n => 54)
        port map ( D => sig_xor_mem_in,
                    clk => clk,
                    reset => '0',
                    Q => sig_xor_mem_out);
    
    sig_tag_gen_mem <= sig_xor_mem_out(53);
    sig_cmp_result_mem <= sig_xor_mem_out(52);
    sig_write_en <= sig_tag_gen_mem and sig_cmp_result_mem;
    sig_rec_addr_mem <= sig_xor_mem_out(51 downto 42);
    sig_tot_addr_mem <= sig_xor_mem_out(41 downto 32);
    
    
    data_mem : data_memory
        port map ( reset => reset,
                    clk => clk,
                    write_enable => sig_write_en,
                    write_data => sig_xor_mem_out(31 downto 0),
                    rec_addr_in => sig_rec_addr_mem,
                    tot_addr_in => sig_tot_addr_mem,
                    sec_data_out => sig_sec_out);
    
    


end Behavioral;
