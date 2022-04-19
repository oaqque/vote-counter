----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2022 08:05:03 PM
-- Design Name: 
-- Module Name: xor_tag - Behavioral
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

entity xor_tag is
    port ( 
           B0 : in  std_logic_vector(7 downto 0);
           B1 : in  std_logic_vector(7 downto 0);
           B2 : in  std_logic_vector(7 downto 0);
           B3 : in  std_logic_vector(7 downto 0);
           our_tag : out std_logic_vector(7 downto 0)
           );
          
end xor_tag;

architecture behavioural of xor_tag is
begin
    our_tag <= (B0 xor B1 xor B2 xor B3); 
end behavioural;