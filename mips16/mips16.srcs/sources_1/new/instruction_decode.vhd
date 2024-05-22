

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_decode is
Port ( 
        clk : in std_logic;
        instruction : in std_logic_vector(15 downto 0);
        reg_dst : in std_logic;
        ext_op : in std_logic;
        reg_write : in std_logic;
        wd :in std_logic_vector(15 downto 0);
        rd1 : out std_logic_vector(15 downto 0);
        rd2 : out std_logic_vector(15 downto 0);
        ext_imm : out std_logic_vector(15 downto 0);
        func : out std_logic_vector(2 downto 0);
        sa : out std_logic
);
end instruction_decode;

architecture Behavioral of instruction_decode is


signal op : std_logic_vector(2 downto 0) := instruction(15 downto 13);
signal rs : std_logic_vector(2 downto 0) := instruction(12 downto 10);
signal rt : std_logic_vector(2 downto 0) := instruction(9 downto 7);
signal rd : std_logic_vector(2 downto 0) := instruction(6 downto 4);
signal imm : std_logic_vector(6 downto 0) := instruction(6 downto 0);
signal w_addr : std_logic_vector(2 downto 0);

begin

op <= instruction(15 downto 13);
rs <= instruction(12 downto 10);
rt <= instruction(9 downto 7);
rd <= instruction(6 downto 4);
imm <= instruction(6 downto 0);
w_addr <= instruction(9 downto 7) when reg_dst = '0' else instruction(6 downto 4);


func <= instruction(2 downto 0);
sa <= instruction(3);

--sign extension
process(instruction, ext_op)
    begin
        if ext_op = '1' then
            ext_imm(15 downto 7) <= (others => instruction(6));
            ext_imm(6 downto 0) <= instruction(6 downto 0);
        else
            ext_imm(15 downto 7) <= (others => '0');
            ext_imm(6 downto 0) <= instruction(6 downto 0);
        end if;
    end process;


reg_file: entity work.reg_file
    port map(
        clk=> clk,
        ra1=> rs,
        ra2=> rt,
        wa=> w_addr,
        wd=> wd,
        wen=> reg_write,
        rd1=> rd1,
        rd2=> rd2
    );


end Behavioral;
