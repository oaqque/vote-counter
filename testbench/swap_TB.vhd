library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package input_array_pkg is
        type input_array is array(integer range <>) of std_logic_vector(15 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.input_array_pkg.all;

entity swap_TB is
end swap_TB;

architecture Behavioral of swap_TB is

    component swap is
    port (swap_key      : in std_logic_vector(12 downto 0);
              D3            : in std_logic_vector(7 downto 0);
              D2            : in std_logic_vector(7 downto 0);
              D1            : in std_logic_vector(7 downto 0);
              D0            : in std_logic_vector(7 downto 0);
              A3            : out std_logic_vector(7 downto 0);
              A2            : out std_logic_vector(7 downto 0);
              A1            : out std_logic_vector(7 downto 0);
              A0            : out std_logic_vector(7 downto 0));
    end component;

    --Inputs
	signal swap_key_in : std_logic_vector(12 downto 0);
	signal D3_in : std_logic_vector(7 downto 0);
	signal D2_in : std_logic_vector(7 downto 0);
	signal D1_in : std_logic_vector(7 downto 0);
	signal D0_in : std_logic_vector(7 downto 0);
    --Outputs
	signal A3_out : std_logic_vector(7 downto 0);
	signal A2_out : std_logic_vector(7 downto 0);
	signal A1_out : std_logic_vector(7 downto 0);
	signal A0_out : std_logic_vector(7 downto 0);

    signal clk: std_logic;
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut:   swap PORT map (
      	swap_key => swap_key_in,
        D3 => D3_in,
        D2 => D2_in,
      	D1 => D1_in,
      	D0 => D0_in,
      	A3 => A3_out,
      	A2 => A2_out,
      	A1 => A1_out,
      	A0 => A0_out
      );

   -- Clodk process defintions
   clk_process  : process is
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;

  stimulus: process is
  begin
    wait for clk_period;
    swap_key_in <= "0110010100001";
    D3_in <= "00000000";
    D2_in <= "00000000";
    D1_in <= "00000000";
    D0_in <= "00000000";
    wait for clk_period;
    swap_key_in <= "0111010101001";
    D3_in <= "10110011";
    D2_in <= "10000101";
    D1_in <= "00000111";
    D0_in <= "01100010";
    wait for clk_period;
    swap_key_in <= "0110010100001";
    D3_in <= "00000000";
    D2_in <= "00000000";
    D1_in <= "00000000";
    D0_in <= "00000000";
    wait for clk_period;
  end process;

end Behavioral;
