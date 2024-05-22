
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory_unit is
Port ( 
  clk: in std_logic;
  en: in std_logic;
  mem_write: in std_logic;
  alu_res: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  mem_data: out std_logic_vector(15 downto 0)
);
end memory_unit;

architecture Behavioral of memory_unit is

type memory is array (0 to 15) of std_logic_vector(15 downto 0);
signal mem: memory := (others => (others => '0'));

begin

process(clk)
begin
  if clk'event and clk ='1' then
    if en = '1' then
      if mem_write = '1' then
        mem(conv_integer(alu_res)) <= rd2;
      end if;
    end if;
  end if;
  mem_data <= mem(conv_integer(alu_res));
end process;


end Behavioral;
