library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity main_control is
Port (
    opcode : in std_logic_vector(2 downto 0);
    reg_dst : out std_logic;
    ext_op : out std_logic;
    alu_src : out std_logic;
    branch : out std_logic;
    jump : out std_logic;
    alu_op : out std_logic_vector(2 downto 0);
    mem_write : out std_logic;
    mem_to_reg : out std_logic;
    reg_write : out std_logic
 );
end main_control;

architecture Behavioral of main_control is

begin

CONTROL:process(opcode) is
begin
  reg_dst <= '0';
  ext_op <= '0';
  alu_src <= '0';
  branch <= '0';
  jump <= '0';
  alu_op <= "000";
  mem_write <= '0';
  mem_to_reg <= '0';
  reg_write <= '0';

    case opcode is
        when "000" => -- R-type (ADD, SUB, SLL, SRL, AND, OR, SLT, XOR)
            reg_dst <= '1';        -- Destination register is RD
            ext_op <= 'X';          -- Don't care (no immediate)
            alu_src <= '0';         -- Second operand is from a register
            branch <= '0';         -- R-type is not a branch
            jump <= '0';           -- R-type does not cause a jump
            alu_op <= "000";         -- ALU operation for R-type (to be decoded further by funct field)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= '0';       -- Data comes from ALU, not memory
            reg_write <= '1';       -- R-type writes to register
        
        when "001" => -- ADDI
            reg_dst <= '0';        -- Destination register is RT, not RD
            ext_op <= '1';          -- Sign-extend the immediate value
            alu_src <= '1';         -- ALU takes the second operand from the immediate field
            branch <= '0';         -- ADDI is not a branch instruction
            jump <= '0';           -- ADDI does not cause a jump
            alu_op <= "001";         -- ALU operation for addition (assuming '00' for ADD)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= '0';       -- Data comes from ALU, not memory
            reg_write <= '1';       -- ADDI writes to a register

        when "101" => -- LW
            reg_dst <= '0';        -- Destination register is RT, not RD
            ext_op <= '1';          -- Sign-extend the offset
            alu_src <= '1';         -- ALU takes the second operand from the immediate field (offset)
            branch <= '0';         -- LW is not a branch instruction
            jump <= '0';           -- LW does not cause a jump
            alu_op <= "101";         -- ALU operation for addition (offset computation)
            mem_write <= '0';       -- No memory write for LW
            mem_to_reg <= '1';       -- Data to register comes from memory
            reg_write <= '1';  

       when "100" => -- SW
            reg_dst <= 'X';        -- Don't care (no destination register)
            ext_op <= '1';          -- Sign-extend the offset
            alu_src <= '1';         -- ALU takes the second operand from the immediate field (offset)
            branch <= '0';         -- SW is not a branch instruction
            jump <= '0';           -- SW does not cause a jump
            alu_op <= "100";         -- ALU operation for addition (offset computation)
            mem_write <= '1';       -- Memory write for SW
            mem_to_reg <= 'X';       -- Don't care (no data written to registers)
            reg_write <= '0';       -- SW does not write to a register

        when "110" => -- BEQ
            reg_dst <= 'X';        -- Don't care (no destination register)
            ext_op <= '1';          -- Sign-extend the immediate value for branch offset
            alu_src <= '0';         -- ALU takes the second operand from the register file
            branch <= '1';         -- BEQ is a branch instruction
            jump <= '0';           -- BEQ does not cause a jump
            alu_op <= "110";         -- ALU operation for subtraction (assuming '01' for subtraction)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= 'X';       -- Don't care (no data written to registers)
            reg_write <= '0';       -- BEQ does not write to a register

        when "010" => -- Branch on greater than zero
            reg_dst <= 'X';        -- Don't care (no destination register)
            ext_op <= '1';          -- Sign-extend the immediate value for branch offset
            alu_src <= '0';         -- ALU takes the second operand from the register file
            branch <= '1';         -- This is a branch instruction
            jump <= '0';           -- This operation does not cause a jump
            alu_op <= "010";         -- ALU operation for comparison (assuming '10' for comparison)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= 'X';       -- Don't care (no data written to registers)
            reg_write <= '0';       -- This operation does not write to a register

        when "011" => -- Branch on less than zero
            reg_dst <= 'X';        -- Don't care (no destination register)
            ext_op <= '1';          -- Sign-extend the immediate value for branch offset
            alu_src <= '0';         -- ALU takes the second operand from the register file
            branch <= '1';         -- This is a branch instruction
            jump <= '0';           -- This operation does not cause a jump
            alu_op <= "011";         -- ALU operation for comparison (assuming '11' for comparison)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= 'X';       -- Don't care (no data written to registers)
            reg_write <= '0';       -- This operation does not write to a register

        when "111" => -- Jump
            reg_dst <= 'X';        -- Don't care (no destination register)
            ext_op <= 'X';          -- Don't care (immediate value not used)
            alu_src <= 'X';         -- Don't care (ALU not used)
            branch <= '0';         -- Jump is not a branch instruction
            jump <= '1';           -- Jump causes a jump
            alu_op <= "XXX";         -- Don't care (ALU not used)
            mem_write <= '0';       -- No memory write
            mem_to_reg <= 'X';       -- Don't care (no data written to registers)
            reg_write <= '0';       -- Jump does not write to a register

        when others =>
            reg_dst <= '0';        -- No destination register
            ext_op <= '0';          -- No sign-extension
            alu_src <= '0';         -- ALU takes the second operand from the register file
            branch <= '0';         -- Not a branch instruction
            jump <= '0';           -- Does not cause a jump
            alu_op <= "000";         -- No ALU operation
            mem_write <= '0';       -- No memory write
            mem_to_reg <= '0';       -- No data written to registers
            reg_write <= '0';
    end case;
end process;



end Behavioral;
