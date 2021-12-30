----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2021 01:47:09 AM
-- Design Name: 
-- Module Name: uart_deb_tb - Behavioral
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_deb_tb is
--  Port ( );
end uart_deb_tb;

architecture Behavioral of uart_deb_tb is
constant T: time :=  8 ns;
constant T2: time := 104.2 us;
signal clk, reset: std_logic;
	signal bt_rd, bt_wr: std_logic:='0'; -- Para el FIFO
		signal rx: std_logic:='0';
		signal w_data: std_logic_vector(7 downto 0):=(others=>'0');
		signal tx_full, rx_empty: std_logic;
		signal r_data: std_logic_vector(7 downto 0);


signal word: std_logic_vector(7 downto 0):= (others => '0');

begin

FBA: entity work.uart_deb port map(clk => clk, reset => reset, bt_rd => bt_rd,  bt_wr => bt_wr, rx=>rx, w_data=>word, tx_full=>tx_full, rx_empty=>rx_empty, r_data=>r_data, tx=>rx);

CLK1:process
begin
clk <= '1'; 
wait for T/2;
clk <= '0';
wait for T/2;
end process;


reset <= '1','0' after T;

wrstim: process
begin

for item in 1 to 18 loop
word <= word+10;
wait for 500 us;
bt_wr <= '1'; 
wait for 100 us;
bt_wr <= '0';
end loop;

wait for 1000 us;


for i in 1 to 18 loop
bt_rd <= '1';
wait for 500 us;
bt_rd <= '0';
wait for 500 us;
end loop;
wait;
end process;

end Behavioral;
