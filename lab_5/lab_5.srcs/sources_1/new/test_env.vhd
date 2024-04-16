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

--instruction fetch signals
signal enable : std_logic := '0';
signal pc_reset : std_logic := '0';
signal instruction: std_logic_vector(15 downto 0);
signal pc_out: std_logic_vector(15 downto 0);
signal jmp_addr: std_logic_vector(15 downto 0);
signal pc_src: std_logic;

--main control signal
signal reg_dst : std_logic;
signal ext_op : std_logic;
signal alu_src : std_logic;
signal branch : std_logic;
signal jump : std_logic;
signal alu_op : std_logic_vector(2 downto 0);
signal mem_write : std_logic;
signal mem_to_reg : std_logic;
signal reg_write : std_logic;

--instruction decode signals
signal wd : std_logic_vector(15 downto 0);
signal rd1 : std_logic_vector(15 downto 0);
signal rd2 : std_logic_vector(15 downto 0);
signal ext_imm : std_logic_vector(15 downto 0);
signal func : std_logic_vector(2 downto 0);
signal sa : std_logic;

--alu signals
signal alu_res: std_logic_vector(15 downto 0);
signal branch_addr: std_logic_vector(15 downto 0);
signal zero: std_logic;

signal mem_data: std_logic_vector(15 downto 0);

--ssd signals
signal digits : std_logic_vector(31 downto 0);

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

enable <= sw(0);
pc_reset <= sw(1);
pc_src <= zero and branch;

process(sw)
begin
  case sw(7 downto 5) is
    when "000" => digits <= x"0000" & instruction;
    when "001" => digits <= x"0000" & pc_out;
    when "010" => digits <= x"0000" & rd1;
    when "011" => digits <= x"0000" & rd2;
    when "100" => digits <= x"0000" & ext_imm;
    when "101" => digits <= x"0000" & alu_res;
    when "110" => digits <= x"0000" & mem_data;
    when "111" => digits <= x"0000" & wd;
    when others => digits <= x"00000000"; 
  end case;
end process;

process(mem_to_reg, mem_data, wd, alu_res)
begin
  if mem_to_reg = '1' then
    wd <= mem_data;
  else
    wd <= alu_res;
  end if;
end process;

ssd: entity work.ssd port map(
  clk => clk,
  digits => digits,
  an => an,
  cat => cat
);

instruction_fetch: entity work.instruction_fetch port map(
  clk => mpg_btn(0),
  enable => enable,
  pc_reset => pc_reset,
  pc_out => pc_out,
  instruction => instruction,
  jmp_addr => jmp_addr,
  jmp => jump,
  branch_addr => branch_addr,
  pc_src => pc_src
);

instruction_decode: entity work.instruction_decode port map(
  clk => clk,
  instruction => instruction,
  reg_dst => reg_dst,
  ext_op => ext_op,
  reg_write => reg_write,
  wd => wd,
  rd1 => rd1,
  rd2 => rd2,
  ext_imm => ext_imm,
  func => func,
  sa => sa
);

main_control: entity work.main_control port map(
  opcode => instruction(15 downto 13),
  reg_dst => reg_dst,
  ext_op => ext_op,
  alu_src => alu_src,
  branch => branch,
  jump => jump,
  alu_op => alu_op,
  mem_write => mem_write,
  mem_to_reg => mem_to_reg,
  reg_write => reg_write
);

memory_unit: entity work.memory_unit port map(
  clk => clk,
  en => enable,
  mem_write => mem_write,
  alu_res => alu_res,
  rd2 => rd2,
  mem_data => mem_data
);

instruction_execute: entity work.instruction_execute port map(
  rd1 => rd1,
  rd2 => rd2,
  alu_src => alu_src,
  ext_imm => ext_imm,
  sa => sa,
  func => func,
  alu_op => alu_op,
  pc => pc_out,
  alu_res => alu_res,
  branch_addr => branch_addr,
  zero => zero
);



end Behavioral;
