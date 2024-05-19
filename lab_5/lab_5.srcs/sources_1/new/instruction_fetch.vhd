

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity instruction_fetch is
Port ( 
    clk: in std_logic;
    enable: in std_logic;
    pc_reset: in std_logic; 
    instruction: out std_logic_vector(15 downto 0);
    pc_out: out std_logic_vector(15 downto 0);
    pc_inc: out std_logic_vector(15 downto 0);
    jmp_addr: in std_logic_vector(15 downto 0);
    jmp: in std_logic;
    branch_addr: in std_logic_vector(15 downto 0);
    pc_src: in std_logic
);
end instruction_fetch;

architecture Behavioral of instruction_fetch is

type rom is array(0 to 15) of std_logic_vector(15 downto 0);
signal pc: std_logic_vector(15 downto 0) := (others =>'0');
signal addr1: std_logic_vector(15 downto 0):= (others =>'0');
signal out1: std_logic_vector(15 downto 0):= (others =>'0');

--first 20 fibbonaci numbers

-- 0: xor $0,$0,$0       - init $0=0
-- 1: addi $1,$0,1       - init $1=1 - first number
-- 2: addi $2,$0,1       - init $2=1 - second number
-- 3: addi $3,$0,18      - init $3=18 - no of numbers
-- 4: xor $4,$4,$4       - init $4=0 - position in memory
-- 5: sw $1,0($4)        - store first number
-- 6: addi $4,$4,2       - increment position
-- 7: sw $2,0($4)        - store second number
-- 8: addi $4,$4,2       - increment position
-- 9: add $5,$1,$2       - add first and second number
-- 10: sw $5,0($4)       - store next number
-- 11: addi $4,$4,2      - increment position
-- 12: addi $1,$2,0      - move second number to first
-- 13: addi $2,$5,0      - move next number to second
-- 14: addi $3,$3,-1     - decrement counter
-- 15: beq $3,$0,17      - check if counter is 0
-- 16: j 9               - jump to add next number
-- 17: ret               - end


-- signal rom_data: rom := (
--     0=> B"001_000_001_0000010",--- addi $1,$0,2  initializam contorul cu 2
--     1=> B"001_000_100_0001010", --addi $4,$0,10  $4- initializam valoarea maxima=10
--     2=> B"000_100_000_011_0_000", --add $3,$0,$4  $3 = $4 + $0
--     8=> B"110_001_100_0000100", --beq $1,$4,4 - cat timp contorul<valoarea maxima
--     9=> B"001_101_101_0000010",--addi $5,$5,2  -trecem la urmatorul numar par
--     10=> B"000_011_101_011_0_000", --add $3,$3,5    adunam la suma numarul par
--     11=> B"001_001_001_0000010",    --addi $1,$1,2  -crestem contorul cu 2
--     12=> B"111_0000000001000",             --j,8   sarim inapoi la beq 
--     13=> B"100_011_001_0000000", --sw $1,offset($3)  
--     14=> B"101_011_001_0000000", --lw $1,offset($3)   
--     others =>B"000_001_001_001_0_111");  --noop       

signal rom_data: rom := (
    B"001_000_001_0000010", -- addi $1, $0, 2 (initialize $1 to 2)
    B"001_000_100_0001010", -- addi $4, $0, 10 (initialize $4 to 10)
    B"110_001_100_0000100", -- beq $1, $4, 6 (if $1 == $4, jump to instruction 9)
    B"001_101_101_0000010", -- addi $5, $5, 2 (increment $5 by 2)
    B"000_011_101_011_0_000", -- add $3, $3, $5 (add $5 to $3)
    B"001_001_001_0000010", -- addi $1, $1, 2 (increment $1 by 2)
    B"111_0000000000010", -- j 2 (jump back to instruction 2)
    B"100_011_001_0000000", -- sw $1, 0($3) (store $1 at memory address $3)
    B"101_011_001_0000000", -- lw $1, 0($3) (load $1 from memory address $3)
    others => B"000_001_001_001_0_111" -- noop (default operation)
);

begin

--pc
process(clk, pc_reset)
begin
    if pc_reset = '1' then
        pc <= (others => '0');
    elsif clk'event and clk = '1' then
        if enable = '1' then
            pc<= addr1;
        end if;
    end if;
end process;

--rom
pc_inc <= pc + 1;

instruction <= rom_data(conv_integer(pc(3 downto 0)));

out1 <= branch_addr when pc_src = '1' else pc + 1;

addr1 <= jmp_addr when jmp = '1' else out1;

pc_out <= addr1; 




end Behavioral;
