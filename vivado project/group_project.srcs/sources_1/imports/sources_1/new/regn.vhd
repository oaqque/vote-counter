----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 10:14:38 PM
-- Design Name: 
-- Module Name: regn - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regn is
	generic ( n : integer := 5 ) ;
	port(	D 			: in 		STD_LOGIC_VECTOR(n-1 DOWNTO 0) ;
			reset	    : in		STD_LOGIC;
			clk 	    : in 		STD_LOGIC ;
			Q 			: out 	    STD_LOGIC_VECTOR(n-1 DOWNTO 0) ) ;
end regn ;

architecture Behavior of regn is
begin
	process ( reset, clk ) is 
	begin
		
		if (reset = '1') then
			Q <= (others => '0');
		elsif (rising_edge(clk)) then
			Q <= D;
		end if ;
	end process ;
end Behavior ;
