library ieee;
use ieee.std_logic_1164.all;


entity state_basic is

  port(
    input  : in  std_logic;
    clk    : in  std_logic;
    output : out std_logic_vector(1 downto 0)
    );
end state_basic;


-- A VHDL file can have multiple architecture descriptions, however it is
-- generally recommended to only have one entity and one associated
-- architecture in each VHDL file.


-- First architecture showing a more type state machine
architecture moore of state_basic is

  type   state_type is (S0, S1, S2, S3);
  signal state_moore: state_type;

  -- the attribute syn_encoding can be used to override the synthesisers choice
  -- of encoding for the state machine.
  -- attribute syn_encoding               : string;
  -- attribute syn_encoding of state_type : type is "sequential";


begin

  p_state : process(clk) is
  begin

    if rising_edge(clk) then
      case state_moore is
        when S0 =>
          if input = '1' then
            state_moore <= S1;
          end if;
          output <= "00";

        when S1 =>
          if input = '1' then
            state_moore <= S2;
          end if;
          output <= "01";

        when S2 =>
          if input = '1' then
            state_moore <= S3;
          end if;
          output <= "10";

        when S3 =>
          if input = '1' then
            state_moore <= S0;
          end if;
          output <= "11";

        when others =>
          output <= "00";
          state_moore  <= S0;

      end case;
    end if;
  end process;
end architecture;



-- Second architecture description showing a mealy type state machine

architecture mealy of state_basic is

  type   state_type is (S0, S1, S2, S3);
  signal state_mealy : state_type;


begin

  p_state : process(clk) is
  begin
    if rising_edge(clk) then

      case state_mealy is
        when S0 =>
          output <= "00";

          if input = '1' then
            state_mealy  <= S1;
            output <= "01";
          end if;

        when S1 =>
          output <= "01";
          if input = '1' then
            state_mealy  <= S2;
            output <= "10";
          end if;


        when S2 =>
          output <= "10";
          if input = '1' then
            state_mealy  <= S3;
            output <= "11";
          end if;


        when S3 =>
          output <= "11";
          if input = '1' then
            state_mealy  <= S0;
            output <= "00";
          end if;

        when others =>

          state_mealy  <= S0;
          output <= "00";
      end case;
    end if;
  end process;
end architecture;
