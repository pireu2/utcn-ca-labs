library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity if_id_reg is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    pc_inc_in : in std_logic_vector(15 downto 0);
    pc_inc_out : out std_logic_vector(15 downto 0);
    instruction_in : in std_logic_vector(15 downto 0);
    instruction_out : out std_logic_vector(15 downto 0)
   );
end if_id_reg;

architecture Behavioral of if_id_reg is

begin


process(clk, reset)
begin
  if clk'event and clk = '1' then
    if reset = '1' then
      pc_inc_out <= (others => '0');
      instruction_out <= (others => '0');
    else
      pc_inc_out <= pc_inc_in;
      instruction_out <= instruction_in;
    end if;
  end if;
end process;

end Behavioral;
