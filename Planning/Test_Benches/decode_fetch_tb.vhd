----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:13:40 03/24/2015 
-- Design Name: 
-- Module Name:    decode_fetch_tb - structural 
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

entity decode_fetch_tb is
	port(	clk		: in std_logic;
			
			-- fetch output signals
			progC		: out std_logic_vector(13 downto 0);
			inst		: out std_logic_vector(15 downto 0);
			
			-- decode output signal
			reg_a				: out std_logic_vector(15 downto 0);
			reg_b				: out std_logic_vector(15 downto 0);
			immediate_out	: out std_logic_vector(15 downto 0);
			wbPlusOne		: out std_logic_vector(15 downto 0);
			
			-- decode input signals
			store_addr		: in std_logic_vector(15 downto 0);
			store_data		: in std_logic_vector(15 downto 0);
			store_enable	: in std_logic;
			sel				: in std_logic);
			
			
end decode_fetch_tb;

architecture structural of decode_fetch_tb is
	signal rst_line	: std_logic;
	
	-- fetch/decode signals
	signal imm	: std_logic_vector(3 downto 0);
	signal rb	: std_logic_vector(3 downto 0);
	signal ra	: std_logic_vector(3 downto 0);

begin
	rst_unit:	entity work.system_reset
		port map(	clk	=> clk,
						rst	=> rst_line);
	
	fetch_unit: entity work.fetch
		port map(	clk	=> clk,
						rst	=> rst_line,
						imm	=> imm,
						rb		=> rb,
						ra		=> ra,
						progC	=> progC,
						inst	=> inst);
	
	decode_unit:	entity work.decode
		port map(	addr_reg_a		=> ra,
						addr_reg_b		=> rb,
						immediate		=> imm,
						store_addr		=> store_addr,
						store_data		=> store_data,
						reg_a				=> reg_a,
						reg_b				=> reg_b,
						immediate_out	=> immediate_out,
						wbPlusOne		=> wbPlusOne,
						store_enable	=> store_enable,
						sel				=> sel,
						rst				=> rst_line,
						clk				=> clk);

end structural;

