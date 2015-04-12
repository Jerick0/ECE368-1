----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:54 03/29/2015 
-- Design Name: 
-- Module Name:    WBPlus1_controlpath - structural 
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

entity WBPlus1_controlpath is
	port(		clk				: in std_logic;
				notclk			: in std_logic;
				wbPlus1_inst	: in std_logic_vector(15 downto 0);
				wbPlus1_instout: out std_logic_vector(15 downto 0);
				rst				: in std_logic);
end WBPlus1_controlpath;

architecture structural of WBPlus1_controlpath is
	signal wb1r_inst	: std_logic_vector(15 downto 0);
	signal wb1f_inst	: std_logic_vector(15 downto 0);
begin

	wb1_r		: entity work.GP_Register
				port map(	clk		=> clk,
								D			=> wbPlus1_inst,
								Q			=> wb1r_inst,
								rst		=> rst);
								
	wb1_f		: entity work.GP_Register
				port map(	clk		=> notclk,
								D			=> wb1r_inst,
								Q			=> wb1f_inst,
								rst		=> rst);
								
	wbPlus1_instout	<= wb1f_inst;

end structural;

