----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:51 03/18/2015 
-- Design Name: 
-- Module Name:    Opacc - Behavioral 
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

entity Opacc is
    Port ( Decode_Reg 		: in  STD_LOGIC_Vector(15 downto 0);
			  Decode_Reg_Br	: in  STD_LOGIC_Vector(15 downto 0);
           Reg_B 				: in  STD_LOGIC_Vector(15 downto 0);
			  Reg_B_Br			: in  STD_LOGIC_Vector(15 downto 0);
           Reg_A				: in  STD_LOGIC_Vector(15 downto 0);
			  Reg_A_Br			: in  STD_LOGIC_Vector(15 downto 0);
           Load_EX_F 		: in  STD_LOGIC_Vector(15 downto 0);
           WB_F 				: in  STD_LOGIC_Vector(15 downto 0);			  
			  RR_EX_F 			: in  STD_LOGIC_Vector(15 downto 0);           
           WBplus1_F 		: in  STD_LOGIC_Vector(15 downto 0);
           Cntl_A 			: in  STD_LOGIC_Vector(2 downto 0);
           Cntl_B 			: in  STD_LOGIC_Vector(2 downto 0);
			  CLK					: in  STD_LOGIC;
           OP_A 				: out  STD_LOGIC_Vector(15 downto 0);
           OP_B 				: out  STD_LOGIC_Vector(15 downto 0)
			  );
end Opacc;

architecture Behavioral of Opacc is 
	signal notclock : Std_logic;

begin
notclock<=not clk;

		MUX_B: entity work.mux_8to1
				Port map( A => Decode_Reg,
							 B => Decode_Reg_BR,
							 C => Reg_B,
							 D => Reg_B_BR,
							 E => Load_EX_F,
							 F => WB_F,
							 G => RR_EX_F,
							 H => WBplus1_F,							 
							 SEL => Cntl_B,
							 CLK => notclock,
							 O => OP_B
							 );
		 
		 MUX_A: entity work.mux_6to1
				Port map( A => Reg_A,
							 B =>	Reg_A_BR,
							 C => Load_EX_F,							 
							 D => WB_F,
							 E => RR_EX_F,
							 F => WBplus1_F,
							 SEL => Cntl_A,
							 CLK =>notclock,
							 O => OP_A);
							 
							 
							 

end Behavioral;

