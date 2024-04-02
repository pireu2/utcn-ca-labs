

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
signal w_addr : std_logic_vector(2 downto 0) := "000";

begin

func <= instruction(2 downto 0);
sa <= instruction(3);

--sign extension
process(ext_op)
begin
    if ext_op = '0' then
        ext_imm <= x"00" & "0" & imm;
    else
        if imm(6) = '1' then
            ext_imm <= x"FF" & "1" & imm;
        else
            ext_imm <= x"00" & "0" & imm;
        end if;
    end if;
end process;

--write addr mux
process(reg_dest)
begin
    if reg_dst = '0' then
        w_addr <= rd;
    else
        w_addr <= rt;  
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
