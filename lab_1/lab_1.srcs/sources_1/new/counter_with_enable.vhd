----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 11:26:30 PM
-- Design Name: 
-- Module Name: counter_with_enable - Behavioral
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_with_enable is
  Port ( 
    btn : in std_logic;
    clk : in std_logic;
    led : out std_logic_vector(7 downto 0)
  );
end counter_with_enable;

architecture Behavioral of counter_with_enable is

signal enable : std_logic := '0';
signal counter : std_logic_vector(2 downto 0) := (others => '0');

begin


mpg: entity work.mpg port map(clk => clk, input => btn, enable => enable);

COUNTER_WITH_ENABLE:
process(clk, enable)
begin
    if rising_edge(clk) then
        if enable = '1' then
            counter <= counter + 1;
        end if;
    end if;
end process;

DCD:
process(counter)
begin
    case counter is
        when "000" => led <= x"00";
        when "001" => led <= x"01";
        when "010" => led <= x"02";
        when "011" => led <= x"04";
        when "100" => led <= x"08";
        when "101" => led <= x"10";
        when "110" => led <= x"20";
        when others => led <= x"40";
     end case;
end process;

end Behavioral;
