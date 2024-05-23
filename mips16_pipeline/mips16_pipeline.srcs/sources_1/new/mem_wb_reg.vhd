library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mem_wb_reg is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    mem_to_reg_in : in std_logic;
    mem_to_reg_out : out std_logic;
    reg_write_in : in std_logic;
    reg_write_out : out std_logic;
    mem_data_in : in std_logic_vector(15 downto 0);
    mem_data_out : out std_logic_vector(15 downto 0);
    alu_res_in : in std_logic_vector(15 downto 0);
    alu_res_out : out std_logic_vector(15 downto 0);
    w_addr_in : in std_logic_vector(2 downto 0);
    w_addr_out : out std_logic_vector(2 downto 0)
   );
end mem_wb_reg;

architecture Behavioral of mem_wb_reg is

begin


process(clk, reset)
begin
  if clk'event and clk = '1' then
    if reset = '1' then
      mem_to_reg_out <= '0';
      reg_write_out <= '0';
      mem_data_out <= (others => '0');
      alu_res_out <= (others => '0');
      w_addr_out <= (others => '0');
    else
      mem_to_reg_out <= mem_to_reg_in;
      reg_write_out <= reg_write_in;
      mem_data_out <= mem_data_in;
      alu_res_out <= alu_res_in;
      w_addr_out <= w_addr_in;
    end if;
  end if;
end process;

end Behavioral;
