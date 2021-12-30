----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2021 12:48:12 AM
-- Design Name: 
-- Module Name: uart_deb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_deb is
generic(
		DBIT: integer := 8;     -- # data bits
		SB_TICK: integer := 32; -- # ticks de parada
										-- 32/48/64 para 11/1.5/2 bits
		DVSR: integer := 407;   -- divisor de ticks
										-- = clk/(32*baudrate)
		DVSR_BIT: integer := 9; -- # bits de DVSR
		FIFO_W: integer := 4    -- # bits de direccion del fifo
										-- # palabras en FIFO = 2^FIFO_W
	);
 Port (clk, reset: in std_logic;
		bt_rd, bt_wr: in std_logic; -- Para el FIFO
		rx: in std_logic;
		w_data: in std_logic_vector(DBIT-1 downto 0);
		tx_full, rx_empty: out std_logic;
		r_data: out std_logic_vector(DBIT-1 downto 0);
		tx: out std_logic );
end uart_deb;

architecture Behavioral of uart_deb is

signal tick_rd: std_logic := '0';
signal tick_wr: std_logic := '0';
begin

dbrd: entity work.debounce_circuit(Behavioral)
port map(clk => clk,sw =>bt_rd,reset => reset,db_tick => tick_rd,db_level => open);

dbwr: entity work.debounce_circuit(Behavioral)
port map(clk => clk,sw =>bt_wr,reset => reset,db_tick => tick_wr,db_level => open);

uartmodd:entity  work.uart
port map(
clk=>clk, reset => reset,rd_uart => tick_rd,wr_uart => tick_wr, -- Para el FIFO
		rx => rx,
		w_data => w_data,
		tx_full => tx_full, rx_empty => rx_empty,
		r_data => r_data,
		tx => tx
);

end Behavioral;
