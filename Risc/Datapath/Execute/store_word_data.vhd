----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:41:31 04/01/2015 
-- Design Name: 
-- Module Name:    store_word_data - structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use work.all;

entity store_word_data is
	generic(	num_bits				: integer := 16;
				addr_size			: integer := 8);
	
	port(	-- inputs
			store_data_in			: in std_logic_vector(num_bits-1 downto 0);
			store_addr_in			: in std_logic_vector(addr_size-1 downto 0);
			
			-- outputs
			store_data_out			: out std_logic_vector(num_bits-1 downto 0);
			store_addr_out			: out std_logic_vector(addr_size-1 downto 0);
		
			-- control
			rst						: std_logic;
			clk						: std_logic);
end store_word_data;

architecture structural of store_word_data is
	signal data			: std_logic_vector(num_bits-1 downto 0) := (others => '0');
	signal addr			: std_logic_vector(addr_size-1 downto 0) := (others => '0');
	
	signal notClk		: std_logic;
	
begin
	notClk <= not clk;

	data_rising_delay: entity work.GP_register
		port map(	clk		=> notClk,
						rst		=> rst,
						D			=> store_data_in,
						Q			=> data);
	
	data_falling_delay:	entity work.GP_register
		port map(	clk		=> clk,
						rst		=> rst,
						D			=> data,
						Q			=> store_data_out);
						
	addr_rising_delay:	entity work.GP_register
		generic map(num_bits	=> 8)
		port map(	clk		=> notClk,
						rst		=> rst,
						D			=> store_addr_in,
						Q			=> addr);
						
	addr_falling_delay:	entity work.GP_register
		generic map(num_bits	=> 8)
		port map(	clk		=> clk,
						rst		=> rst,
						D			=> addr,
						Q			=> store_addr_out);

end structural;

