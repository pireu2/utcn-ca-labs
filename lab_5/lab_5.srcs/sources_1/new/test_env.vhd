library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity test_env is
Port ( 
  clk: in std_logic;
  btn: in std_logic_vector(4 downto 0);
  sw: in std_logic_vector(15 downto 0);
  led: in std_logic_vector(15 downto 0);
  an: out std_logic_vector(7 downto 0);
  cat: out std_logic_vector(6 downto 0)
);
end test_env;

architecture Behavioral of test_env is

signal mpg_btn: std_logic_vector(4 downto 0);

begin


mpg1: entity work.mpg port map(
  clk => clk,
  input => btn(0),
  enable => mpg_btn(0)
);

mpg2: entity work.mpg port map(
  clk => clk,
  input => btn(1),
  enable => mpg_btn(1)
);

mpg3: entity work.mpg port map(
  clk => clk,
  input => btn(2),
  enable => mpg_btn(2)
);

mpg4: entity work.mpg port map(
  clk => clk,
  input => btn(3),
  enable => mpg_btn(3)
);

mpg5: entity work.mpg port map(
  clk => clk,
  input => btn(4),
  enable => mpg_btn(4)
);



instruction_fetch: entity work.instruction_fetch port map(
  
);

instruction_decode: entity work.instruction_decode port map(

);

main_control: entity work.main_control port map(

);

memory_unit: entity work.memory_unit port map(

);

instruction_execute: entity work.instruction_execute port map(

);



end Behavioral;
