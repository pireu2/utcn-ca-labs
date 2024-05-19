
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ssd is
  Port ( 
    signal clk: in std_logic;
    signal digits: in std_logic_vector(31 downto 0);
    signal an: out std_logic_vector(7 downto 0);
    signal cat: out std_logic_vector(6 downto 0)
  );
end ssd;

architecture Behavioral of ssd is

signal counter: std_logic_vector(15 downto 0);
signal digit: std_logic_vector(3 downto 0);

begin

process(clk)
begin
    if rising_edge(clk) then
        counter <= counter + 1;
    end if;
end process;

process(counter)
begin
    case counter(15 downto 13) is
        when "000" =>
            digit <= digits(3 downto 0);
            an <= "11111110";
        when "001" =>
            digit <= digits(7 downto 4);
            an <= "11111101";
        when "010" =>
            digit <= digits(11 downto 8);
            an <= "11111011";
        when "011" =>
            digit <= digits(15 downto 12);
            an <= "11110111";
        when "100" =>
            digit <= digits(19 downto 16);
            an <= "11101111";
        when "101" =>
            digit <= digits(23 downto 20);
            an <= "11011111";
        when "110" =>
            digit <= digits(27 downto 24);
            an <= "10111111";
        when "111" =>
            digit <= digits(31 downto 28);
            an <= "01111111";
        when others =>
            digit <= "0000";
            an <= "11111111";
    end case;
end process;

process(digit)
begin
    case digit is
        when "0000" =>
            cat <= "1000000";
        when "0001" =>
            cat <= "1111001";
        when "0010" =>
            cat <= "0100100";
        when "0011" =>
            cat <= "0110000";
        when "0100" =>
            cat <= "0011001";
        when "0101" =>
            cat <= "0010010";
        when "0110" =>
            cat <= "0000010";
        when "0111" =>
            cat <= "1111000";
        when "1000" =>
            cat <= "0000000";
        when "1001" =>
            cat <= "0011000";
        when "1010" =>
            cat <= "0001000";
        when "1011" =>
            cat <= "0000011";
        when "1100" =>
            cat <= "1000110";
        when "1101" =>
            cat <= "0100001";
        when "1110" =>
            cat <= "0000110";
        when "1111" =>
            cat <= "0001110";
        when others =>
            cat <= "1111111";
    end case;
end process;


end Behavioral;
