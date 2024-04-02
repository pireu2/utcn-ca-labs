----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 11:20:12 PM
-- Design Name: 
-- Module Name: mpg - Behavioral
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

entity mpg is
  Port (
     clk : in std_logic;
     input : in std_logic;
     enable : out std_logic
      );
end mpg;

architecture Behavioral of mpg is

signal counter : std_logic_vector(15 downto 0) := (others => '0');
signal q1,q2,q3 : std_logic := '0';

begin


CONTER:
process(clk)
begin
    if rising_edge(clk) then
        counter <= counter + 1;
    end if;
end process;

D1:
process(clk, counter)
begin
    if rising_edge(clk) then
        if counter = x"FFFF" then
            q1 <= input;
        end if;
    end if;
end process;


D2:
process(clk)
begin
    if rising_edge(clk) then
        q2 <= q1;
    end if;
end process;

D3:
process(clk)
begin
    if rising_edge(clk) then
        q3 <= q2;
    end if;
end process;

enable <= q2 and not(q3);


end Behavioral;









