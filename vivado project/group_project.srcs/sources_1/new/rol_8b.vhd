----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2022 06:14:52 PM
-- Design Name: 
-- Module Name: rol_8b - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rol_8b is
	  port ( blk : in std_logic_vector(7 downto 0);
    		offset : in std_logic_vector(2 downto 0);
    		blk_out : out std_logic_vector(7 downto 0));
end rol_8b;

architecture behavioural of rol_8b is
	  signal modulo : integer := 0;
begin

    modulo <= conv_integer(offset) mod 8;
    blk_out <= blk(7 - modulo downto 0) & blk(7 downto 8 - modulo);
end behavioural;
