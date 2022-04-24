library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity full_TB is
end full_TB;

architecture Behavioral of full_TB is

    component pipeline_vote_counter_core is
      port (clk         : in std_logic;
            reset       : in std_logic;
            send        : in std_logic;
            rec_in      : in std_logic_vector(31 downto 0);
            rec_tag_in  : in std_logic_vector(7 downto 0);
            busy        : out std_logic);
    end component;

    --Inputs
    signal send : std_logic := '0';
    signal rec_in : std_logic_vector(31 downto 0);
    signal rec_tag_in : std_logic_vector(7 downto 0);
    signal busy : std_logic := '0';
    
    --Outputs
    signal reset : std_logic;
    signal clk : std_logic;
    constant clk_period : time := 10 ns;
    file input_file : text open read_mode is "test_input.txt";
begin

    -- Instantiate the Unit Under Test (UUT)
    uut:  pipeline_vote_counter_core PORT map (
            clk => clk,
            reset => reset,
            send => send,
            rec_in => rec_in,
            rec_tag_in => rec_tag_in,
            busy => busy );

   -- Clock process defintions
   clk_process  : process is
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;

   -- Reset process
   p_reset: process
   begin
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period * 20;
   end process;

   -- Stimulus read from text file
   stimulus: process
        variable v_TEST_LINE : line;
        variable v_REC_DATA : std_logic_vector(31 downto 0);
        variable v_TAG_DATA : std_logic_vector(7 downto 0);
        variable v_SPACE : character;
    begin
        -- wait for reset
        wait for clk_period;
        file_open(input_file, "test_input.txt", read_mode); 
        while not endfile(input_file) loop
            send <= '1';
            readline(input_file, v_TEST_LINE);
            read(v_TEST_LINE, v_REC_DATA);
            read(v_TEST_LINE, v_SPACE);
            read(v_TEST_LINE, V_TAG_DATA);        
            rec_in <= v_REC_DATA;
            rec_tag_in <= v_TAG_DATA;           
            --wait for 1 clock cycle
            wait for clk_period;          
        end loop;
        send <= '0';
        
    end process;
end Behavioral;
