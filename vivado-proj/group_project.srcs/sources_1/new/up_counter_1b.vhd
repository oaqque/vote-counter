----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 11:14:45 PM
-- Design Name: 
-- Module Name: up_counter_1b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_counter_1b is
    port ( reset    : in  std_logic;
               clk      : in  std_logic;
               En       : in  std_logic;
               addr_out : buffer std_logic);
end up_counter_1b;


architecture behavioral of up_counter_1b is
    
begin

    process ( reset, clk )
    begin
       	if (reset = '1') then
           addr_out <= '0'; 
       	elsif (rising_edge(clk)) then
           	if En = '0' then
                addr_out <= '0';
           	else
           		addr_out <= not(addr_out);
           	end if;
       	end if;
    end process;
end behavioral;
