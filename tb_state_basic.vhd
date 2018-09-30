library ieee;
use ieee.std_logic_1164.all;




entity tb_state_basic is
end entity;



architecture tb of tb_state_basic is


  signal input  : std_logic;
  signal clk    : std_logic := '0';
  signal output : std_logic_vector(1 downto 0);

  signal clk_ena      : boolean := false;
  constant clk_period : time    := 20 ns;




begin



  clk <= not clk after clk_period/2 when clk_ena else '0';


  -- When a VHDL file contains multiple architectures, the wanted architecture
  -- can be included in the paranthesis. If not provided, the last architecture
  -- description in the VHDL file will be chosen.
  -- This code below also shows how to make a direct instantiation of the
  -- component to be used. With direct instantiation there is no need to
  -- separately declare the component. 
  DUT : entity work.state_basic(behav2)
    port map(
      input  => input,
      clk    => clk,
      output => output
      );



  p_sequence : process


  begin
    input <= '0';
    clk_ena <= true;

    wait for 200 ns;

    input <= '1';

    wait for 200 ns;

   clk_ena <= false;
    
    wait;
  end process;




end architecture;
