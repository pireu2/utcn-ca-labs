

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity if_id_reg is
Port ( 
  clk : in STD_LOGIC;
  reset : in STD_LOGIC;
  intruction_in : in STD_LOGIC_VECTOR(15 downto 0);
  pc_in : in STD_LOGIC_VECTOR(15 downto 0);
  intruction_out : out STD_LOGIC_VECTOR(15 downto 0);
  pc_out : out STD_LOGIC_VECTOR(15 downto 0)
);
end if_id_reg;

architecture Behavioral of if_id_reg is

begin

process(clk, reset)
begin
  if reset = '1' then
    intruction_out <= (others => '0');
    pc_out <= (others => '0');
  elsif clk'event and clk='1' then
    intruction_out <= intruction_in;
    pc_out <= pc_in;
  end if;
end process;


end Behavioral;
