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
	  signal offset_int : integer := 0;
begin
    offset_int <= conv_integer(offset(2 downto 0)); 
    blk_out <= blk rol offset_int;
end behavioural;
