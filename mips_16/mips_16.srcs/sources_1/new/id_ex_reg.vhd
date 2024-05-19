
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity id_ex_reg is
 Port (
  clk : in STD_LOGIC;
  reset : in STD_LOGIC;
  rd1_in : in STD_LOGIC_VECTOR(15 downto 0);
  rd2_in : in STD_LOGIC_VECTOR(15 downto 0);
  pc_in : in STD_LOGIC_VECTOR(15 downto 0);
  ext_in : in STD_LOGIC_VECTOR(15 downto 0);
  alu_op_in : in STD_LOGIC_VECTOR(2 downto 0);
  alu_src_in : in STD_LOGIC;
  reg_dst_in : in STD_LOGIC;
  mem_write_in : in STD_LOGIC;
  branch_in : in STD_LOGIC;
  mem_to_reg_in: in STD_LOGIC;
  reg_write_in : in STD_LOGIC;
  func_in : in STD_LOGIC_VECTOR(2 downto 0);


  rd1_out : out STD_LOGIC_VECTOR(15 downto 0);
  rd2_out : out STD_LOGIC_VECTOR(15 downto 0);
  pc_out : out STD_LOGIC_VECTOR(15 downto 0);
  ext_out : out STD_LOGIC_VECTOR(15 downto 0);
  alu_op_out : out STD_LOGIC_VECTOR(2 downto 0);
  alu_src_out : out STD_LOGIC;
  reg_dst_out : out STD_LOGIC;
  mem_write_out : out STD_LOGIC;
  branch_out : out STD_LOGIC;
  mem_to_reg_out: out STD_LOGIC;
  reg_write_out : out STD_LOGIC;
  func_out : out STD_LOGIC_VECTOR(2 downto 0)

  );
end id_ex_reg;

architecture Behavioral of id_ex_reg is

begin

  process(clk, reset)
  begin
    if reset = '1' then
      rd1_out <= (others => '0');
      rd2_out <= (others => '0');
      pc_out <= (others => '0');
      ext_out <= (others => '0');
      alu_op_out <= (others => '0');
      alu_src_out <= '0';
      reg_dst_out <= '0';
      mem_write_out <= '0';
      branch_out <= '0';
      mem_to_reg_out <= '0';
      reg_write_out <= '0';
      func <= (others => '0');
    elsif rising_edge(clk) then
      rd1_out <= rd1_in;
      rd2_out <= rd2_in;
      pc_out <= pc_in;
      ext_out <= ext_in;
      alu_op_out <= alu_op_in;
      alu_src_out <= alu_src_in;
      reg_dst_out <= reg_dst_in;
      mem_write_out <= mem_write_in;
      branch_out <= branch_in;
      mem_to_reg_out <= mem_to_reg_in;
      reg_write_out <= reg_write_in;
      func_out <= func_in;
    end if;
  end process;

end Behavioral;
