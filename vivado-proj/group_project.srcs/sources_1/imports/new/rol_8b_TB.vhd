----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2022 08:20:39 PM
-- Design Name: 
-- Module Name: rol_8b_TB - Behavioral
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
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity rol_8b_TB is
end rol_8b_TB;


architecture Behavioral of rol_8b_TB is
 
    
    component rol_8b
        port ( blk : in std_logic_vector(7 downto 0);
    		offset : in std_logic_vector(2 downto 0);
    		blk_out : out std_logic_vector(7 downto 0));
    end component;
    
    --signal n : integer := 4;
    --Input signals
    signal A : std_logic_vector(7 downto 0) := "00000000";
    signal O : std_logic_vector(2 downto 0) := "000";
    
    --Output signal
    signal R : std_logic_vector(7 downto 0);
    
    signal clk : std_logic;
    constant clk_period : time := 10 ns;
begin
   
 
    uut: rol_8b
       
        port map (blk => A, offset => O, blk_out => R);
   
        
    --Clock process defijavascript:void(0)nitions
    clk_process  : process is
    begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
    end process;
    
    -- random inputs in the range of 0-50
    stimulus: process is
        variable seed1 : positive := 1;
        variable seed2 : positive := 1;
        variable x : real;
        variable y : real;

    begin
        seed1 := seed1 + 1;
        seed2 := seed2 + 1;
        wait until rising_edge(clk);
        uniform(seed1, seed2, x);
        uniform(seed1, seed2, y);
        
        
       
        A(7 downto 0) <= conv_std_logic_vector(integer(floor(x * 2.0**8 - 1.0)), 8);
        O(2 downto 0) <= conv_std_logic_vector(integer(floor(y * 2.0**3 - 1.0)), 3);
          
    end process;

end Behavioral;