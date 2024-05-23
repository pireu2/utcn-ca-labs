library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ex_mem_reg is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    mem_to_reg_in : in std_logic;
    mem_to_reg_out : out std_logic;
    reg_write_in : in std_logic;
    reg_write_out : out std_logic;
    mem_write_in : in std_logic;
    mem_write_out : out std_logic;
    branch_in : in std_logic;
    branch_out : out std_logic;
    alu_res_in : in std_logic_vector(15 downto 0);
    alu_res_out : out std_logic_vector(15 downto 0);
    zero_in : in std_logic;
    zero_out : out std_logic;
    branch_addr_in : in std_logic_vector(15 downto 0);
    branch_addr_out : out std_logic_vector(15 downto 0);
    rd2_in : in std_logic_vector(15 downto 0);
    rd2_out : out std_logic_vector(15 downto 0);
    w_addr_in: in std_logic_vector(2 downto 0);
    w_addr_out: out std_logic_vector(2 downto 0)
   );
end ex_mem_reg;

architecture Behavioral of ex_mem_reg is

begin


process(clk, reset)
begin
  if clk'event and clk = '1' then
    if reset = '1' then
      mem_to_reg_out <= '0';
      reg_write_out <= '0';
      mem_write_out <= '0';
      alu_res_out <= (others => '0');
      zero_out <= '0';
      branch_addr_out <= (others => '0');
      w_addr_out <= (others => '0');
    else
      mem_to_reg_out <= mem_to_reg_in;
      reg_write_out <= reg_write_in;
      mem_write_out <= mem_write_in;
      alu_res_out <= alu_res_in;
      zero_out <= zero_in;
      branch_addr_out <= branch_addr_in;
      w_addr_out <= w_addr_in;
    end if;
  end if;
end process;

end Behavioral;
