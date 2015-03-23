----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:03 02/11/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
	generic( DATAPATH	: integer :=16);
	
	port(	RA				: in std_logic_vector(DATAPATH-1 downto 0);		-- register A
			RB				: in std_logic_vector(DATAPATH-1 downto 0);		-- register B
			OPCODE		: in std_logic_vector(3 downto 0);		-- op code
			EN 			: in std_logic;
			CCR			: out std_logic_vector(3 downto 0);		-- condition code register
			ALU_OUT		: out std_logic_vector(DATAPATH-1 downto 0));	-- result of operation
			-- LDST_OUT
end ALU;

architecture Behavioral of ALU is
	signal arith		: std_logic_vector(DATAPATH-1 downto 0);
	signal logic		: std_logic_vector(DATAPATH-1 downto 0);
	signal shift		: std_logic_vector(DATAPATH-1 downto 0);
	-- MEMORY
	signal ccr_arith	: std_logic_vector(3 downto 0);
	signal ccr_logic	: std_logic_vector(3 downto 0);
	signal ccr_shift	: std_logic_vector(3 downto 0);
	
begin
	ARITH_UNIT: entity work.Arith
		port map(	A			=> RA,
						B			=> RB,
						OP			=> OPCODE(2 downto 0),
						CCR		=> ccr_arith,
						RESULT	=> arith);
	
	LOGIC_UNIT: entity work.Logic
		port map(	A			=> RA,
						B			=> RB,
						OP			=> OPCODE(2 downto 0),
						CCR		=> ccr_logic,
						RESULT	=> logic);
						
	SHIFT_UNIT: entity work.Shift
		port map(	A			=> RA,
						POS		=> RB(3 downto 0),
						OP			=> OPCODE(3),
						CCR		=> ccr_shift,
						RESULT	=> shift);
	
	MUX_UNIT: entity work.MUX_ALU
		port map(	OP				=> OPCODE,
						EN				=> EN,
						regb  		=> RB,
						ARITH			=> arith,
						LOGIC			=> logic,
						SHIFT			=> shift,
						CCR_ARITH	=> ccr_arith,
						CCR_LOGIC	=> ccr_logic,
						CCR_SHIFT	=> ccr_shift,
						ALU_OUT		=> ALU_OUT,
						CCR_OUT		=> CCR);

end Behavioral;

