

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity main_control is
Port (
    instruction : in std_logic_vector(2 downto 0);
    reg_dst : out std_logic;
    ext_op : out std_logic;
    alu_src : out std_logic;
    branch : out std_logic;
    jump : out std_logic;
    alu_op : out std_logic;
    mem_write : out std_logic;
    mem_to_reg : out std_logic;
    reg_write : out std_logic
 );
end main_control;

architecture Behavioral of main_control is

begin

process(instruction)
begin
    case instruction is
        when "000" => reg_dst <= '1';
                      reg_write <= '1';
                      jump <= '0';
        when "111" => jump <='1';
        when others => branch <= '1';
    end case;
end process;



end Behavioral;
