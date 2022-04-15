library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity swap is
        port (swap_key      : in std_logic_vector(12 downto 0);
              D3            : in std_logic_vector(7 downto 0);
              D2            : in std_logic_vector(7 downto 0);
              D1            : in std_logic_vector(7 downto 0);
              D0            : in std_logic_vector(7 downto 0);
              A3            : out std_logic_vector(7 downto 0);
              A2            : out std_logic_vector(7 downto 0);
              A1            : out std_logic_vector(7 downto 0);
              A0            : out std_logic_vector(7 downto 0));
end swap;

architecture behavioural of swap is
begin
    PROCESS(swap_key)
        variable size : integer range 0 to 7 := conv_integer(swap_key(12 downto 10));
        variable p2 : integer range 0 to 7 := conv_integer(swap_key(9 downto 7));
        variable p1 : integer range 0 to 7 := conv_integer(swap_key(6 downto 4));
        variable swp2 : std_logic_vector(size downto 0);
        variable swp1 : std_logic_vector(size downto 0);
    BEGIN
        case swap_key(3 downto 0) is
            when "0000" =>
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
            when "0001" =>
                A3 <= D3;
                A2 <= D2;
                A1 <= D1(7 downto p2 + size) & D0 (size downto p1) & D1(p2 downto 0);
                
end behavioural;
