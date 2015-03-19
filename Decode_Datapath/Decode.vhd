----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:19 03/18/2015 
-- Design Name: 
-- Module Name:    Decode - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decode is
    Port ( CLK 		: in  	STD_LOGIC;
           RST 		: in  	STD_LOGIC;
			  SEL			: in		STD_LOGIC;
			  WE			: in		STD_LOGIC_VECTOR (0 downto 0);
			  IMMED		: in		STD_LOGIC_VECTOR (3 downto 0);
           REGA_IN 	: in  	STD_LOGIC_VECTOR (3 downto 0);
           REGB_IN 	: in  	STD_LOGIC_VECTOR (3 downto 0);
			  LOAD_EXFI : in		STD_LOGIC_VECTOR (15 downto 0);
			  LOAD_WBFI : in		STD_LOGIC_VECTOR (15 downto 0);
			  WB_FI 		: in		STD_LOGIC_VECTOR (15 downto 0);
			  EX_FI 		: in		STD_LOGIC_VECTOR (15 downto 0);
			  WB_ADDR 	: in		STD_LOGIC_VECTOR (3 downto 0);
			  WB_MDAT 	: in		STD_LOGIC_VECTOR (15 downto 0);
           REGA_OUT 	: out  	STD_LOGIC_VECTOR (15 downto 0);
           REGB_OUT 	: out  	STD_LOGIC_VECTOR (15 downto 0);
           LOAD_EXFO : out  	STD_LOGIC_VECTOR (15 downto 0);
           LOAD_WBFO : out  	STD_LOGIC_VECTOR (15 downto 0);
           WB_FO 		: out  	STD_LOGIC_VECTOR (15 downto 0);
           EX_FO 		: out  	STD_LOGIC_VECTOR (15 downto 0);
			  DEC_O		: out  	STD_LOGIC_VECTOR (15 downto 0));
end Decode;

architecture Structural of Decode is
	signal ra : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
	signal rb : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
	signal muxo : STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
	signal a : std_logic_vector(7 downto 0) := (others => '0');
	signal b : std_logic_vector(7 downto 0) := (others => '0');
	signal c : std_logic_vector(15 downto 0) := (others => '0');
begin
	
	a <= "0000" & IMMED;
	b <= REGB_IN & IMMED;
	c <= "00000000" & muxo;
	
	U1: entity work.reg_bank
	port map( 	clk			=>	CLK,
					reg_a_addr	=>	REGA_IN,
					reg_b_addr	=>	REGB_IN,
					write_addr	=>	WB_ADDR,
					data_in		=>	WB_MDAT,
					reg_a			=>	ra,
					reg_b			=>	rb,
					w_en			=>	WE);
	
	MUX_DEC: entity work.mux2to1
	generic map(num_bits 	=> 8)
	port map( 	CLK			=>	CLK,
					IN_1			=>	a,
					IN_2			=>	b,
					O				=>	muxo,
					SEL			=>	SEL);
					
					
	Reg_DEC: entity work.GP_register
	port map( 	CLK			=> CLK,
					RST			=>	RST,
					D				=>	c,
					Q				=>	DEC_O);
					
	Reg_A: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	ra,
					Q				=>	REGA_OUT);
					
	Reg_B: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	rb,
					Q				=>	REGB_OUT);
					
	Reg_LEXF: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	LOAD_EXFI,
					Q				=>	LOAD_EXFO);
	
	Reg_LWBF: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	LOAD_WBFI,
					Q				=>	LOAD_WBFO);
					
	Reg_WBF: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	WB_FI,
					Q				=>	WB_FO);
					
	Reg_EXF: entity work.GP_register
	port map( 	CLK			=>	CLK,
					RST			=>	RST,
					D				=>	EX_FI,
					Q				=>	EX_FO);

end Structural;