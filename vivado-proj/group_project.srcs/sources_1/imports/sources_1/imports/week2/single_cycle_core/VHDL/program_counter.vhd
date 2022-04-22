---------------------------------------------------------------------------
-- program_counter.vhd - Program Counter Implementation 
-- 
-- Note : The program counter is simply a register that updates its output 
-- on the rising clock edge.
-- 
--
-- Copyright (C) 2006 by Lih Wen Koh (lwkoh@cse.unsw.edu.au)
-- All Rights Reserved. 
--
-- The single-cycle processor core is provided AS IS, with no warranty of 
-- any kind, express or implied. The user of the program accepts full 
-- responsibility for the application of the program and the use of any 
-- results. This work may be downloaded, compiled, executed, copied, and 
-- modified solely for nonprofit, educational, noncommercial research, and 
-- noncommercial scholarship purposes provided that this notice in its 
-- entirety accompanies all copies. Copies of the modified software can be 
-- delivered to persons who use it solely for nonprofit, educational, 
-- noncommercial research, and noncommercial scholarship purposes provided 
-- that this notice in its entirety accompanies all copies.
--
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity program_counter is
    port ( reset    : in  std_logic;
           clk      : in  std_logic;
           En       : in  std_logic;
           addr_out : buffer std_logic);
end program_counter;

architecture behavioral of program_counter is
    
begin

    process ( reset, clk )
    begin
       	if (reset = '1') then
           addr_out <= '0'; 
       	elsif (falling_edge(clk)) then
           	if En = '0' then
                addr_out <= '0';
           	else
           		addr_out <= '1';
           	end if;
       	end if;
    end process;
end behavioral;
