library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use std.textio.all;

entity full_TB is
end full_TB;

architecture Behavioral of full_TB is

    component pipeline_vote_counter_core is
      port (clk         : in std_logic;
            reset       : in std_logic;
            send        : in std_logic;
            rec_in      : in std_logic_vector(31 downto 0);
            rec_tag_in  : in std_logic_vector(31 downto 0);
            busy        : out std_logic);
      -- Place port here
    end component;

    --Inputs
    signal send : std_logic;
    signal rec_in : std_logic_vector(31 downto 0);
    signal rec_tag_in : std_logic_vector(31 downto 0);

    --Outputs
    signal busy : std_logic;
    signal reset : std_logic;
    signal clk : std_logic;
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut:  pipeline_vote_counter_core PORT map (
            clk => clk,
            reset => reset,
            send => send,
            rec_in => rec_in,
            rec_tag_in => rec_tag_in,
            busy => busy,
          );

   -- Clock process defintions
   clk_process  : process is
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;

   -- Stimulus read from text file
  stimulus: process(busy) is
    variable TEST_LINE : line;
    variable INPUT_DATA : std_logic_vector(63 downto 0);
  begin
    -- Reset the vote counter
    reset <= '1';
    wait for clk_period;
    reset <= '0';
    wait for clk_period;

    file_open(TEST_DATA, "test_input.txt", read_mode); 
    while not endfile(TEST_DATA) loop
      if busy == '1' then
        wait for clk_period * 10;
      else 
        readline(TEST_DATA, TEST_LINE);
        read(TEST_LINE, INPUT_DATA);
        rec_in <= INPUT_DATA(63 downto 32);
        rec_tag_in <= INPUT_DATA(31 downto 0);
        send <= '1';
        wait for clk_period;
        send <= '0';
      end if;
    end loop;
  end process;

end Behavioral;
