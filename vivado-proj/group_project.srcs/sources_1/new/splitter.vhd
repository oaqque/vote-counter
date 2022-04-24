library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity splitter is
        port (vote_record   : in std_logic_vector(31 downto 0);
              D3            : out std_logic_vector(7 downto 0);
              D2            : out std_logic_vector(7 downto 0);
              D1            : out std_logic_vector(7 downto 0);
              D0            : out std_logic_vector(7 downto 0));
end splitter;

architecture behavioural of splitter is
begin
    D3 <= vote_record(31 downto 24);
    D2 <= vote_record(23 downto 16);
    D1 <= vote_record(15 downto 8);
    D0 <= vote_record(7 downto 0);
end behavioural;