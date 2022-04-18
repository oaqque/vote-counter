library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_memory is
    -- GENERIC (N : INTEGER := 32);
    port ( reset        : in  std_logic;
           clk          : in  std_logic;
           rec_addr     : in std_logic_vector(9 downto 0);
           tot_addr     : in std_logic_vector(9 downto 0);
           write_data   : in std_logic_vector(31 downto 0);
           write_enable : in  std_logic;
           secret       : out std_logic_vector(31 downto 0) );
end data_memory;

architecture behavioral of data_memory is

type mem_array is array(0 to 1023) of std_logic_vector(31 downto 0);
signal sig_data_mem : mem_array;

begin
    mem_process: process ( clk,
                           write_enable,
                           write_data,
                           rec_addr,
                           tot_addr ) is
  
    variable var_data_mem : mem_array;
    variable var_addr_rec : integer;
    variable var_addr_tot : integer;
    variable old_total    : std_logic_vector(31 downto 0);
  
    begin
        var_addr_rec := conv_integer(rec_addr);
        var_addr_tot := conv_integer(tot_addr);
        old_total    := var_data_mem(var_addr_tot);
        
        if (reset = '1') then
            -- initial values of the data memory : reset to zero 
            data_write : FOR i IN 0 TO 1023 loop
                var_data_mem(i) := X"0000";
            END loop;
            -- var_data_mem(0)  := X"0005";
            -- var_data_mem(1)  := X"0008";

        elsif (falling_edge(clk) and write_enable = '1') then
            -- memory writes on the falling clock edge
            var_data_mem(var_addr_rec) := write_data;
            var_data_mem(var_addr_tot) := (write_data + old_total);

        end if;
       
        -- continuous read of the secret that is passed back to the 1st stage
        secret <= var_data_mem(0);
 
        -- the following are probe signals (for simulation purpose) 
        sig_data_mem <= var_data_mem;

    end process;
  
end behavioral;