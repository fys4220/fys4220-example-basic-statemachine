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
-- generally recommended to have only one entity and one associated
-- architecture in each VHDL file


-- First architecture using state machine with one process
architecture behav of state_basic is




  type state_type is (S0, S1, S2, S3);
  -- signal state : std_logic_vector(1 downto 0);  -- "00","01","10","11"
  signal state : state_type;

  -- the attribute syn_encoding can be used to override the synthesisers choice
  -- of encoding for the state machine.
  attribute syn_encoding               : string;
  attribute syn_encoding of state_type : type is "sequential";



begin


  p_state : process(clk) is


  begin

    if rising_edge(clk) then

      case state is
        when S0 =>
          if input = '1' then
            state <= S1;
          end if;
          output <= "00";

        when S1 =>
          if input = '1' then
            state <= S2;
          end if;
          output <= "01";

        when S2 =>
          if input = '1' then
            state <= S3;
          end if;
          output <= "10";

        when S3 =>
          if input = '1' then
            state <= S0;
          end if;
          output <= "11";

        when others =>
          output <= "00";
          state  <= S0;

      end case;



    end if;


  end process;



end architecture;



-- Second architecture description where the state machince with a separate
-- combinational output process.

architecture behav2 of state_basic is




  type state_type is (S0, S1, S2, S3);
  -- signal state : std_logic_vector(1 downto 0);  -- "00","01","10","11"
  signal state : state_type;

  attribute syn_encoding               : string;
  attribute syn_encoding of state_type : type is "sequential";



begin


  p_state : process(clk) is


  begin

    if rising_edge(clk) then

      case state is
        when S0 =>
          if input = '1' then
            state <= S1;
          end if;


        when S1 =>
          if input = '1' then
            state <= S2;
          end if;


        when S2 =>
          if input = '1' then
            state <= S3;
          end if;


        when S3 =>
          if input = '1' then
            state <= S0;
          end if;


        when others =>

          state <= S0;

      end case;
    end if;
  end process;



  p_comb : process(state,input) is

  begin

    case state is

      when S0 =>
        if input = '1' then 
          output <= "01";
        else
          output <= "00";
        end if;
      when S1 =>
        if input = '1' then 
          output <= "10";
        else
          output <= "01";
        end if;
      when S2 =>
        if input = '1' then 
          output <= "11";
        else
          output <= "10";
        end if;
      when S3 =>
        if input = '1' then 
          output <= "00";
        else
          output <= "11";
        end if;
      when others =>
        output <= "00";

    end case;

  end process;



end architecture;





