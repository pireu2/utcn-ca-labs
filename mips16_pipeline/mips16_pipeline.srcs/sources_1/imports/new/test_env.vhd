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
signal reset : std_logic := '0';
signal instruction: std_logic_vector(15 downto 0)  := (others => '0');
signal pc_out: std_logic_vector(15 downto 0) := (others => '0');
signal pc_inc : std_logic_vector(15 downto 0) := (others => '0');
signal jmp_addr: std_logic_vector(15 downto 0) := (others => '0');
signal pc_src: std_logic;

--main control signal
signal reg_dst : std_logic := '0';
signal ext_op : std_logic := '0';
signal alu_src : std_logic := '0';
signal branch : std_logic := '0';
signal jump : std_logic := '0';
signal alu_op : std_logic_vector(2 downto 0) := (others => '0');
signal mem_write : std_logic := '0';
signal mem_to_reg : std_logic := '0';
signal reg_write : std_logic := '0';

--instruction decode signals
signal wd : std_logic_vector(15 downto 0) := (others => '0');
signal rd1 : std_logic_vector(15 downto 0) := (others => '0');
signal rd2 : std_logic_vector(15 downto 0) := (others => '0');
signal ext_imm : std_logic_vector(15 downto 0) := (others => '0');
signal func : std_logic_vector(2 downto 0) := (others => '0');
signal sa : std_logic := '0';

--alu signals
signal alu_res: std_logic_vector(15 downto 0) := (others => '0');
signal branch_addr: std_logic_vector(15 downto 0) := (others => '0');
signal zero: std_logic := '0';

signal mem_data: std_logic_vector(15 downto 0) := (others => '0');

--ssd signals
signal digits : std_logic_vector(31 downto 0) := (others => '0');

--clk
signal clk_aux: std_logic := '0';

--if_id_reg signals
signal pc_inc_aux: std_logic_vector(15 downto 0) := (others => '0');
signal instruction_aux: std_logic_vector(15 downto 0) := (others => '0');

--id_ex_reg signals
signal pc_inc_aux1: std_logic_vector(15 downto 0) := (others => '0');
signal w_addr_1: std_logic_vector(2 downto 0) := (others => '0');
signal w_addr_2: std_logic_vector(2 downto 0) := (others => '0');
signal w_addr_in: std_logic_vector(2 downto 0) := (others => '0');
signal rd1_aux: std_logic_vector(15 downto 0) := (others => '0');
signal rd2_aux: std_logic_vector(15 downto 0) := (others => '0');
signal imm_aux: std_logic_vector(15 downto 0) := (others => '0');
signal mem_to_reg_aux: std_logic := '0';
signal reg_write_aux: std_logic := '0';
signal mem_write_aux: std_logic := '0';
signal branch_aux: std_logic := '0';
signal alu_op_aux: std_logic_vector(2 downto 0) := (others => '0');
signal alu_src_aux: std_logic := '0';
signal reg_dst_aux: std_logic := '0';
signal func_aux: std_logic_vector(2 downto 0) := (others => '0');
signal sa_aux: std_logic := '0';
signal w_addr_1_aux: std_logic_vector(2 downto 0) := (others => '0');
signal w_addr_2_aux: std_logic_vector(2 downto 0) := (others => '0');


signal w_addr_aux: std_logic_vector(2 downto 0) := (others => '0');

signal alu_res_aux: std_logic_vector(15 downto 0) := (others => '0');
signal zero_aux: std_logic := '0';
signal branch_addr_aux: std_logic_vector(15 downto 0) := (others => '0');
signal w_addr_out_aux: std_logic_vector(2 downto 0) := (others => '0');
signal branch_aux2: std_logic := '0';


signal mem_to_reg_aux2: std_logic := '0';
signal reg_write_aux2: std_logic := '0';
signal mem_write_aux2: std_logic := '0';
signal rd2_aux2: std_logic_vector(15 downto 0) := (others => '0');


signal mem_to_reg_aux3: std_logic := '0';
signal reg_write_aux3: std_logic := '0';
signal mem_data_aux: std_logic_vector(15 downto 0) := (others => '0');
signal alu_res_aux2: std_logic_vector(15 downto 0) := (others => '0');


begin


-- mpg1: entity work.mpg port map(
--   clk => clk,
--   input => btn(0),
--   enable => mpg_btn(0)
-- );

-- mpg2: entity work.mpg port map(
--   clk => clk,
--   input => btn(1),
--   enable => mpg_btn(1)
-- );

-- mpg3: entity work.mpg port map(
--   clk => clk,
--   input => btn(2),
--   enable => mpg_btn(2)
-- );

-- mpg4: entity work.mpg port map(
--   clk => clk,
--   input => btn(3),
--   enable => mpg_btn(3)
-- );

-- mpg5: entity work.mpg port map(
--   clk => clk,
--   input => btn(4),
--   enable => mpg_btn(4)
-- );

enable <= sw(0);
reset <= sw(1);
clk_aux <= clk;


-- process(sw, instruction, pc_out, rd1, rd2, ext_imm, alu_res, mem_data, wd)
-- begin
--   case sw(7 downto 5) is
--     when "000" => digits <= x"0000" & instruction;
--     when "001" => digits <= x"0000" & pc_out;
--     when "010" => digits <= x"0000" & rd1;
--     when "011" => digits <= x"0000" & rd2;
--     when "100" => digits <= x"0000" & ext_imm;
--     when "101" => digits <= x"0000" & alu_res;
--     when "110" => digits <= x"0000" & mem_data;
--     when "111" => digits <= x"0000" & wd;
--     when others => digits <= x"00000000"; 
--   end case;
-- end process;




-- ssd: entity work.ssd port map(
--   clk => clk,
--   digits => digits,
--   an => an,
--   cat => cat
-- );

jmp_addr <= "000" & instruction(12 downto 0);

instruction_fetch: entity work.instruction_fetch port map(
  clk => clk_aux,
  enable => enable,
  pc_reset => reset,
  pc_out => pc_out,
  pc_inc => pc_inc,
  instruction => instruction,
  jmp_addr => jmp_addr,
  jmp => jump,
  branch_addr => branch_addr,
  pc_src => pc_src
);

if_id_reg: entity work.if_id_reg port map(
  clk => clk_aux,
  reset => reset,
  pc_inc_in => pc_inc,
  pc_inc_out => pc_inc_aux,
  instruction_in => instruction,
  instruction_out => instruction_aux
);

main_control: entity work.main_control port map(
  opcode => instruction_aux(15 downto 13),
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


instruction_decode: entity work.instruction_decode port map(
  clk => clk_aux,
  instruction => instruction_aux,
  reg_dst => reg_dst,
  ext_op => ext_op,
  reg_write => reg_write_aux3,
  wd => wd,
  rd1 => rd1,
  rd2 => rd2,
  ext_imm => ext_imm,
  func => func,
  sa => sa,
  w_addr_in => w_addr_in,
  w_addr_out_1 => w_addr_1,
  w_addr_out_2 => w_addr_2
);

id_ex_reg: entity work.id_ex_reg port map(
  clk => clk_aux,
  reset => reset,
  pc_inc_in => pc_inc_aux,
  pc_inc_out => pc_inc_aux1,
  rd1_in => rd1,
  rd2_in => rd2,
  imm_in => ext_imm,
  mem_to_reg_in => mem_to_reg,
  reg_write_in => reg_write,
  mem_write_in => mem_write,
  branch_in => branch,
  alu_op_in => alu_op,
  alu_src_in => alu_src,
  reg_dst_in => reg_dst,
  func_in => func,
  sa_in => sa,
  w_addr_in_1 => w_addr_1,
  w_addr_in_2 => w_addr_2,
  rd1_out => rd1_aux,
  rd2_out => rd2_aux,
  imm_out => imm_aux,
  mem_to_reg_out => mem_to_reg_aux,
  reg_write_out => reg_write_aux,
  mem_write_out => mem_write_aux,
  branch_out => branch_aux,
  alu_op_out => alu_op_aux,
  alu_src_out => alu_src_aux,
  reg_dst_out => reg_dst_aux,
  func_out => func_aux,
  sa_out => sa_aux,
  w_addr_out_1 => w_addr_1_aux,
  w_addr_out_2 => w_addr_2_aux
);

instruction_execute: entity work.instruction_execute port map(
  rd1 => rd1_aux,
  rd2 => rd2_aux,
  alu_src => alu_src_aux,
  ext_imm => imm_aux,
  w_addr_1 => w_addr_1_aux,
  w_addr_2 => w_addr_2_aux,
  w_addr_out => w_addr_aux,
  reg_dst => reg_dst_aux,
  sa => sa_aux,
  func => func_aux,
  alu_op => alu_op_aux,
  pc => pc_inc_aux1,
  alu_res => alu_res,
  branch_addr => branch_addr,
  zero => zero
);


ex_mem_reg: entity work.ex_mem_reg port map(
  clk => clk_aux,
  reset => reset,
  mem_to_reg_in => mem_to_reg_aux,
  reg_write_in => reg_write_aux,
  mem_write_in => mem_write_aux,
  mem_to_reg_out => mem_to_reg_aux2,
  reg_write_out => reg_write_aux2,
  mem_write_out => mem_write_aux2,
  alu_res_in => alu_res,
  alu_res_out => alu_res_aux,
  zero_in => zero,
  zero_out => zero_aux,
  branch_addr_in => branch_addr,
  branch_addr_out => branch_addr_aux,
  w_addr_in => w_addr_aux,
  w_addr_out => w_addr_out_aux,
  branch_in => branch_aux,
  branch_out => branch_aux2,
  rd2_in => rd2_aux,
  rd2_out => rd2_aux2
);

pc_src <= zero_aux and branch_aux2;


memory_unit: entity work.memory_unit port map(
  clk => clk_aux,
  en => enable,
  mem_write => mem_write_aux2,
  alu_res => alu_res_aux,
  rd2 => rd2_aux2,
  mem_data => mem_data
);

mem_wb_reg: entity work.mem_wb_reg port map(
  clk => clk_aux,
  reset => reset,
  mem_to_reg_in => mem_to_reg_aux2,
  mem_to_reg_out => mem_to_reg_aux3,
  reg_write_in => reg_write_aux2,
  reg_write_out => reg_write_aux3,
  mem_data_in => mem_data,
  mem_data_out => mem_data_aux,
  alu_res_in => alu_res_aux,
  alu_res_out => alu_res_aux2,
  w_addr_in => w_addr_out_aux,
  w_addr_out => w_addr_in
);



wd <= alu_res_aux when mem_to_reg_aux3 = '0' else mem_data_aux;





end Behavioral;
