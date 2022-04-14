library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity xor_comp is
    port ( 
           B0 : in  std_logic_vector(7 downto 0);
           B1 : in  std_logic_vector(7 downto 0);
           B2 : in  std_logic_vector(7 downto 0);
           B3 : in  std_logic_vector(7 downto 0);
           orig_tag : in std_logic_vector(7 downto 0);
           valid_tag : out std_logic
           );
          
end xor_comp;

architecture behavioural of xor_comp is
	  signal xored_result : std_logic_vector(7 downto 0);
begin
    xored_result <= B0 xor B1 xor B2 xor B3; 
    
    xor_result: process (xored_result, orig_tag)
    begin
    if (xored_result = orig_tag) then
       valid_tag <= '1';
    else
       valid_tag <= '0';
    end if;
    end process;
    
end behavioural;