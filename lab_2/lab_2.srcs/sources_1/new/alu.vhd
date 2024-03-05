----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2024 12:11:57 PM
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
  Port ( 
    signal clk: in std_logic;
    signal btn: in std_logic;
    signal sw: in std_logic_vector(15 downto 0);
    signal digits: inout std_logic_vector(31 downto 0);
    signal detect_zero: out std_logic
  );
end alu;

architecture Behavioral of alu is

signal enable_counter: std_logic := '0';
signal counter: std_logic_vector(1 downto 0) := "00";
signal s1: std_logic_vector(31 downto 0) := (others => '0');
signal s2: std_logic_vector(31 downto 0) := (others => '0');
signal s3: std_logic_vector(31 downto 0) := (others => '0');

begin

mpg: entity work.mpg port map(clk => clk, input => btn, enable => enable_counter);

process(enable_counter, clk)
begin
  if rising_edge(clk) then
    if enable_counter = '1' then
      counter <= counter + 1;
    end if;
  end if;
end process;

s1 <= x"000000" & sw(7 downto 0);
s2 <= x"000000" & sw(15 downto 8);
s3 <= x"0000" & sw(15 downto 0);

process(counter, s1, s2, s3)
begin
  case counter is
    when "00" =>
      digits <= s1 + s2;
    when "01" =>
      digits <= s1 - s2;
    when "10" =>
      digits <= s3(29 downto 0) & "00";
    when "11" =>
      digits <= "00" & s3(31 downto 2);
    when others =>
      digits <= (others => '0');
  end case;
end process;

process(digits)
begin
    if digits = x"00000000" then
        detect_zero<='1';
    else
        detect_zero<='0';
    end if;
end process;

end Behavioral;
