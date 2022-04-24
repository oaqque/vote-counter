----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2022 10:32:40 AM
-- Design Name: 
-- Module Name: addr_unit - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity addr_unit is
	port ( rec : in std_logic_vector(31 downto 0);
    		offset : in std_logic_vector(9 downto 0);
            rec_addr : out std_logic_vector(9 downto 0);
            tot_addr : out std_logic_vector(9 downto 0));  -- 10 bits address space
end addr_unit;

architecture Behavioral of addr_unit is
	signal dist_ID : std_logic_vector(4 downto 0) := (others => '0');
    signal cand_ID : std_logic_vector(3 downto 0) := (others => '0');
    
    

begin
	dist_ID <= rec(31 downto 27);
    cand_ID <= rec(26 downto 23);
	
    --row_addr <= cand_ID * "100001";
    
  --  rec_addr <= row_addr + ("00000" & dist_ID);
  --  tot_addr <=
    
    rec_addr <= offset + cand_ID * "100001" + dist_ID; -- do not need to concatenate dist_ID to 10 bits as it's using addition from unsigned liberary
    tot_addr <= offset + cand_ID * "100001" + 32;
end Behavioral;
