----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2024 01:06:27 PM
-- Design Name: 
-- Module Name: alu_ssd - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_ssd is
  Port (
    signal clk: in std_logic;
    signal sw: in std_logic_vector(15 downto 0);
    signal btn: in std_logic_vector(3 downto 0);
    signal led: out std_logic_vector(7 downto 0);
    signal cat: out std_logic_vector(6 downto 0);
    signal an: out std_logic_vector(7 downto 0)
   );
end alu_ssd;

architecture Behavioral of alu_ssd is

signal digits : std_logic_vector(31 downto 0);

begin

alu: entity work.alu
  port map(
    clk => clk,
    sw => sw,
    btn => btn(0),
    digits => digits,
    detect_zero => led(0)
  );

ssd: entity work.ssd
    port map(
        clk => clk,
        digits => digits,
        cat => cat,
        an => an
    );



end Behavioral;
