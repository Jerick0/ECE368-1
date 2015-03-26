----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:20 03/21/2015 
-- Design Name: 
-- Module Name:    User_Interface - Behavioral 
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

entity User_Interface is
		Port (CLK		: in		STD_LOGIC;
				BTN		: in		STD_LOGIC;
				WE			: in		STD_LOGIC;
				OPCODE	: in		STD_LOGIC_VECTOR (3 downto 0);
				WB			: in		STD_LOGIC_VECTOR (15 downto 0);
				SW			: in		STD_LOGIC_VECTOR (15 downto 0);
				RST		: out		STD_LOGIC;
				DP			: out		STD_LOGIC;
				SEG		: out		STD_LOGIC_VECTOR (6 downto 0);
				AN			: out		STD_LOGIC_VECTOR (3 downto 0);
				LED		: out		STD_LOGIC_VECTOR (7 downto 0);
				DEBUG 	: out STD_LOGIC_VECTOR(15 downto 0)
				);
end User_Interface;

architecture Behavioral of User_Interface is
	signal debounced: STD_LOGIC := '0';
	signal dat: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal msel: STD_LOGIC := '0';
	signal sseg: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal LED_I: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal RST_I: STD_LOGIC := '0';
	signal wb_b: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal sw_b: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal sw_bb: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
		LED <= LED_I;
		RST <= RST_I;
		DEBUG <= sseg;
		
		RST_L:entity work.rst_logic
		port map(CLK			=>	CLK,
					RESTART		=>	RST_I,
					OPCODE		=> OPCODE,
					MO				=> msel);
		
		WB_BUF:entity work.GP_register
		port map(CLK			=>	CLK,
					RST			=> RST_I,
					D				=> WB,
					Q				=> wb_b);
		
		SW_BUF1:entity work.GP_register
		port map(CLK			=>	CLK,
					RST			=> RST_I,
					D				=> SW,
					Q				=> sw_b);
					
		SW_BUF2:entity work.GP_register
		port map(CLK			=>	CLK,
					RST			=> RST_I,
					D				=> sw_b,
					Q				=> sw_bb);
		
		MUX:entity work.mux2to1
		--generic map(num_bits		=> 0)
		port map(CLK			=>	CLK,
					IN_1			=> wb_b,
					IN_2			=> sw_bb,
					O				=> dat,
					SEL			=> msel);
		
		RSLT_BANK:entity work.result_bank
		port map(CLK			=>	CLK,
					RST			=> RST_I,
					W_EN(0)		=> WE,
					READ_ADDR	=> LED_I,
					DATA_IN		=>	dat,
					DATA_OUT		=> sseg);
					
		BTNCTRL:entity work.buttoncontrol
		port map(CLK			=>	CLK,
					B_O			=> BTN,
					DEB			=> debounced);
		
		PNTCNT:entity work.counter
		port map(CLK			=> CLK,
					RST			=>	RST_I,
					INC			=> debounced,
					COUNT_OUT	=> LED_I);
					
		SSEGD:entity work.SSeg_toplevel
		port map(CLK			=> CLK,
					RESULT		=>	sseg,
					SEG			=> SEG,
					DP				=> DP,
					AN				=> AN);

end Behavioral;

