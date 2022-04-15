library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

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
    PROCESS(swap_key, D3, D2 , D1, D0)
        variable size : integer range 0 to 7 := conv_integer(swap_key(12 downto 10));
        variable p2 : integer range 0 to 7 := conv_integer(swap_key(9 downto 7));
        variable p1 : integer range 0 to 7 := conv_integer(swap_key(6 downto 4));
        
        variable swp2_buf : std_logic_vector(7 downto 0);
        variable swp1_buf : std_logic_vector(7 downto 0);
        variable tmp : std_logic;
    BEGIN
        case swap_key(3 downto 0) is
            when "0000" =>
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
            when "0001" =>
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D1), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= D3;
                A2 <= D2;
                A1 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
            when "0010" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D2), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= D3;
                A2 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A1 <= D1;
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
            when "0011" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D3), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A2 <= D2;
                A1 <= D1;
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
            when "0100" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D1), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= D3;
                A2 <= D2;
                A1 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
            when "0101" => 
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
            when "0111" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D1), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D3), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A2 <= D2;
                A1 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A0 <= D0;
            when "1000" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D2), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= D3;
                A2 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A1 <= D1;
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
            when "1001" =>
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D2), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D1), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= D3;
                A2 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A1 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A0 <= D0;
            when "1010" => 
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
            when "1011" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D2), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D3), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A2 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A1 <= D1;
                A0 <= D0;
            when "1100" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D3), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D0), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A2 <= D2;
                A1 <= D1;
                A0 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
            when "1101" => 
                swp2_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D3), p2));
                swp1_buf := std_logic_vector(ROTATE_RIGHT(unsigned(D1), p1));
                
                for i in 0 to 7 loop
                    if (i < size) then
                        tmp := swp2_buf(i);
                        swp2_buf(i) := swp1_buf(i);
                        swp1_buf(i) := tmp;
                    end if;
                end loop;
                
                A3 <= std_logic_vector(ROTATE_LEFT(unsigned(swp2_buf), p2));
                A2 <= D2;
                A1 <= std_logic_vector(ROTATE_LEFT(unsigned(swp1_buf), p1));
                A0 <= D0;
            when "1111" => 
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
            when others =>
                A3 <= D3;
                A2 <= D2;
                A1 <= D1;
                A0 <= D0;
        end case;
    END PROCESS;
end behavioural;
