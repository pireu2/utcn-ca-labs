library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity id_ex_reg is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    pc_inc_in : in std_logic_vector(15 downto 0);
    pc_inc_out : out std_logic_vector(15 downto 0);
    rd1_in : in std_logic_vector(15 downto 0);
    rd1_out : out std_logic_vector(15 downto 0);
    rd2_in : in std_logic_vector(15 downto 0);
    rd2_out : out std_logic_vector(15 downto 0);
    imm_in : in std_logic_vector(15 downto 0);
    imm_out : out std_logic_vector(15 downto 0);
    mem_to_reg_in : in std_logic;
    mem_to_reg_out : out std_logic;
    reg_write_in : in std_logic;
    reg_write_out : out std_logic;
    mem_write_in : in std_logic;
    mem_write_out : out std_logic;
    branch_in : in std_logic;
    branch_out : out std_logic;
    alu_op_in : in std_logic_vector(2 downto 0);
    alu_op_out : out std_logic_vector(2 downto 0);
    alu_src_in : in std_logic;
    alu_src_out : out std_logic;
    reg_dst_in : in std_logic;
    reg_dst_out : out std_logic;
    func_in : in std_logic_vector(2 downto 0);
    func_out : out std_logic_vector(2 downto 0);
    sa_in : in std_logic;
    sa_out : out std_logic;
    w_addr_in_1 : in std_logic_vector(2 downto 0);
    w_addr_out_1 : out std_logic_vector(2 downto 0);
    w_addr_in_2 : in std_logic_vector(2 downto 0);
    w_addr_out_2 : out std_logic_vector(2 downto 0)
   );
end id_ex_reg;

architecture Behavioral of id_ex_reg is

begin


process(clk, reset)
begin
  if clk'event and clk = '1' then
    if reset = '1' then
      pc_inc_out <= (others => '0');
      rd1_out <= (others => '0');
      rd2_out <= (others => '0');
      imm_out <= (others => '0');
      mem_to_reg_out <= '0';
      reg_write_out <= '0';
      mem_write_out <= '0';
      branch_out <= '0';
      alu_op_out <= (others => '0');
      alu_src_out <= '0';
      reg_dst_out <= '0';
      func_out <= (others => '0');
      sa_out <= '0';
      w_addr_out_1 <= (others => '0');
      w_addr_out_2 <= (others => '0');
    else
      pc_inc_out <= pc_inc_in;
      rd1_out <= rd1_in;
      rd2_out <= rd2_in;
      imm_out <= imm_in;
      mem_to_reg_out <= mem_to_reg_in;
      reg_write_out <= reg_write_in;
      mem_write_out <= mem_write_in;
      branch_out <= branch_in;
      alu_op_out <= alu_op_in;
      alu_src_out <= alu_src_in;
      reg_dst_out <= reg_dst_in;
      func_out <= func_in;
      sa_out <= sa_in;
      w_addr_out_1 <= w_addr_in_1;
      w_addr_out_2 <= w_addr_in_2;
    end if;
  end if;
end process;

end Behavioral;
