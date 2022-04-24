library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator is
    port ( 
           our_tag : in std_logic_vector(7 downto 0);
           orig_tag : in std_logic_vector(7 downto 0);
           valid_tag : out std_logic
           ); 
end comparator;

architecture behavioural of comparator is
begin
    
    xor_result: process (our_tag, orig_tag)
    begin
    if (our_tag = orig_tag) then
       valid_tag <= '1';
    else
       valid_tag <= '0';
    end if;
    end process;
    
end behavioural;