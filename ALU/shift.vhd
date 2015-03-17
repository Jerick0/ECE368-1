----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:10:50 02/12/2015 
-- Design Name: 
-- Module Name:    Shift - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.RISCCONSTANTS_PKG.all;

entity Shift is
	port( A				: in std_logic_vector(DATAPATH-1 downto 0);		-- First input
			POS			: in std_logic_vector(3 downto 0);					-- Second input, amount to shift
			OP				: in std_logic;											-- Op Code, only need MSB
			CCR			: out std_logic_vector(3 downto 0);					-- Condition code register
			RESULT		: out std_logic_vector(DATAPATH-1 downto 0));	-- Result of operation
end Shift;

architecture Behavioral of Shift is
	-- vectors must be longer to check for overflow and carry out
	signal a1					: std_logic_vector(DATAPATH downto 0);
	signal s_left, s_right	: std_logic_vector(DATAPATH downto 0);
	signal tmp					: std_logic_vector(DATAPATH downto 0);	-- Need temp result to use for CCR
	
begin
	-- Need to connect ports to signals because they are unstable by themselves
	a1 <= ('0' & A);

	-- these are the logical shift operators in VHDL
	s_left <= to_stdlogicvector(to_bitvector(a1) sll conv_integer(POS));
	s_right <= to_stdlogicvector(to_bitvector(a1) srl conv_integer(POS));
	
	tmp <= s_left when OP = '0' else s_right;
	
		-- checks sign bit: if 1, the flag is thrown
	CCR(3) <= tmp(7);	

	-- checks to see if the result is zero
	CCR(2) <= '1' when tmp(DATAPATH downto 0) = x"00" else '0';	
					  
	-- reset overflow and carry flags
	CCR(1 downto 0) <= (others => '0');
	
	RESULT <= tmp(DATAPATH-1 downto 0);
end Behavioral;

