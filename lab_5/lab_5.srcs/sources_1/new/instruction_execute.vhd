library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity instruction_execute is
Port (
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  alu_src: in std_logic;
  ext_imm : in std_logic_vector(15 downto 0);
  sa: in std_logic;
  func: in std_logic_vector(2 downto 0);
  alu_op: in std_logic_vector(2 downto 0);
  pc: in std_logic_vector(15 downto 0);
  alu_res: out std_logic_vector(15 downto 0);
  branch_addr: out std_logic_vector(15 downto 0);
  zero: out std_logic
);
end instruction_execute;

architecture Behavioral of instruction_execute is

signal op_2: std_logic_vector(15 downto 0);
signal control: std_logic_vector(3 downto 0);
signal temp: std_logic_vector(15 downto 0);

begin

  -- second operand mux
  process(alu_src, rd2, ext_imm)
  begin
    if alu_src = '0' then
      op_2 <= rd2;
    else
      op_2 <= ext_imm;
    end if;
  end process;

  --branch adder
  branch_addr <= pc + ext_imm;

  --alu control
  process(alu_op, func)
  begin
    case alu_op is
      when "000" =>
        control <= "0" & func;
      when "001" =>
        --add imidiate
        control <= "0000";
      when "100" =>
        --store word
        control <= "0000";
      when "101" =>
        --load word
        control <= "0000";
      when others =>
        control <= "1" & alu_op;
    end case;
  end process;

  --alu 
  process(rd1,op_2,sa,control)
  begin
    case control is
      when "0000" =>
        --addition
        temp <= rd1 + op_2;
      when "0001" =>
        -- subtract
        temp <= rd1 - op_2;
      when "0010" =>
        --shift left logical
        if sa = '1' then
          temp <= rd1(14 downto 0) & "0";
        else
          temp <= rd1;
        end if;
      when "0011" =>
        -- shift right logical
        if sa = '1' then
          temp <= "0" & rd1(15 downto 1); 
        else
          temp <= rd1;
        end if;
      when "0100" =>
        --and
        temp <= rd1 and op_2;
      when "0101" =>
        --or
        temp <= rd1 or op_2;
      when "0110" =>
        --xor
        temp <= rd1 xor op_2;
      when "0111" =>
        --noop
        temp <= (others => '0');
      when "1110" =>
        --branch on equal
        if rd1 = op_2 then
          zero <= '1';
        else
          zero <= '0';
        end if;
        temp <= (others => '0');
      when "1010" =>
        --branch on greater than zero
        if rd1(rd1'left) = '0'  then
          zero <= '1';
        else
          zero <= '0';
        end if;
        temp <= (others => '0');
      when "1011" =>
        --branch on less than zero
        if rd1(rd1'left) = '1'  then
          zero <= '1';
        else
          zero <= '0';
        end if;
        temp <= (others => '0');
      when others =>
        zero <= '0';
        temp <= (others => '0');
    end case;
    alu_res <= temp(15 downto 0);
  end process;
  
end Behavioral;
