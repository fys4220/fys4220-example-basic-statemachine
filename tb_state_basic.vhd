library ieee;
use ieee.std_logic_1164.all;


entity tb_state_basic is
end entity;


architecture tb of tb_state_basic is

  signal input        : std_logic;
  signal clk          : std_logic := '0';
  signal output_moore : std_logic_vector(1 downto 0);
  signal output_mealy : std_logic_vector(1 downto 0);

  signal   clk_ena    : boolean := false;
  constant clk_period : time    := 20 ns;




begin


  -- Generate clock stimuli signal
  clk <= not clk after clk_period/2 when clk_ena else '0';


  -- When a VHDL file contains multiple architectures, the wanted architecture
  -- can be included in the paranthesis. If not provided, the last architecture
  -- description in the VHDL file will be chosen.
  -- This code below also shows how to make a direct instantiation of the
  -- component to be used. With direct instantiation there is no need to
  -- separately declare the component.
  DUT_MOORE : entity work.state_basic(moore)
    port map(
      input  => input,
      clk    => clk,
      output => output_moore
      );


  -- It is also possible to use both architectures at the same time.
  -- You then need to make sure to add additional stimuli signals if needed.
  -- In this case we use the same input but have a separate output for comparison
  DUT_MEALY : entity work.state_basic(mealy)
    port map(
      input  => input,
      clk    => clk,
      output => output_mealy
      );

  -- Simple sequencer to activate the state machine.
  p_sequence : process
  begin
    input   <= '0';
    clk_ena <= true;

    wait for 200 ns;
    wait until rising_edge(clk);
    input <= '1';
    --wait until rising_edge(clk);
    -- input <= '0';
    wait for 200 ns;

    clk_ena <= false;

    wait;
  end process;

end architecture;
