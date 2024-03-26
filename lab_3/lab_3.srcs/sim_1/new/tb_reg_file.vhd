library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_reg_file is

end tb_reg_file;

architecture Behavioral of tb_reg_file is

component reg_file is
 port (
    clk : in std_logic;
    ra1 : in std_logic_vector (2 downto 0);
    ra2 : in std_logic_vector (2 downto 0);
    wa : in std_logic_vector (2 downto 0);
    wd : in std_logic_vector (7 downto 0);
    wen : in std_logic;
    rd1 : out std_logic_vector (7 downto 0);
    rd2 : out std_logic_vector (7 downto 0)
);
end component reg_file;

signal    tb_clk : std_logic;
signal    tb_ra1 : std_logic_vector (2 downto 0);
signal    tb_ra2 : std_logic_vector (2 downto 0);
signal    tb_wa : std_logic_vector (2 downto 0);
signal    tb_wd : std_logic_vector (7 downto 0);
signal    tb_wen : std_logic;
signal    tb_rd1 : std_logic_vector (7 downto 0);
signal    tb_rd2 : std_logic_vector (7 downto 0);

begin
init:
    reg_file port map(tb_clk, tb_ra1, tb_ra2, tb_wa, tb_wd, tb_wen, tb_rd1, tb_rd2);
    
clk:
    process
    begin
        loop
            tb_clk <= '0';
            wait for 1ns;
            tb_clk <= '1';
            wait for 1ns;
        end loop;
    end process;
    
sim:
    process
    begin
        --test 1
        tb_wen<='0';
        tb_ra1<="000";
        wait for 5 ns;
        assert(tb_rd1 = x"F1") report "Test 1 failed" severity error;
        
        --test 2
        tb_wen<='0';
        tb_ra2<="001";
        wait for 5 ns;
        assert(tb_rd2 = x"E1") report "Test 2 failed" severity error;
        
        --test 3
        tb_wa<="010";
        tb_wd<=x"00";
        tb_wen<='1';
        wait for 5 ns;
        tb_wen<='0';
        tb_ra1<="010";
        wait for 5ns;
        assert(tb_rd1 = x"00") report "Test 1 failed" severity error;
        
    end process;

end Behavioral;
