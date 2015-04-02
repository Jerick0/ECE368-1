----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josh Erick
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
           Reg_B 				: in  STD_LOGIC_Vector(15 downto 0);
           Reg_A				: in  STD_LOGIC_Vector(15 downto 0);
           Load_EX_F 		: in  STD_LOGIC_Vector(15 downto 0);
           WB_F 				: in  STD_LOGIC_Vector(15 downto 0);			  
			  RR_EX_F 			: in  STD_LOGIC_Vector(15 downto 0);           
           WBplus1_F 		: in  STD_LOGIC_Vector(15 downto 0);
           Cntl_A 			: in  STD_LOGIC_Vector(2 downto 0);
           Cntl_B 			: in  STD_LOGIC_Vector(2 downto 0);
			  CLK					: in  STD_LOGIC;
           OP_A 				: out  STD_LOGIC_Vector(15 downto 0);
           OP_B 				: out  STD_LOGIC_Vector(15 downto 0);
			  rst					: in std_logic
			  );
end Opacc;

architecture Behavioral of Opacc is 
	signal notclock : Std_logic;
	
	-- tmp signals for stabilization
	signal decode			: STD_LOGIC_Vector(15 downto 0); 
	signal register_b		: STD_LOGIC_Vector(15 downto 0); 
	signal register_a 	: STD_LOGIC_Vector(15 downto 0); 
	signal load_forward 	: STD_LOGIC_Vector(15 downto 0); 
	signal wb_forward		: STD_LOGIC_Vector(15 downto 0); 
	signal rr_forward		: STD_LOGIC_Vector(15 downto 0); 
	signal wbplus1_forward: STD_LOGIC_Vector(15 downto 0); 
	

begin
	notclock<=not clk;
	decode <= decode_reg;
	register_b <= reg_b;
	register_a <= reg_a;
	load_forward <= load_ex_f;
	wb_forward <= wb_f;
	rr_forward <= rr_ex_f;
	wbplus1_forward <= wbplus1_f;

		MUX_B: entity work.mux_6to1
				Port map( A => decode,
							 B => register_b,
							 C => load_forward,
							 D => wb_forward,
							 E => rr_forward,
							 F => wbplus1_forward,							 
							 SEL => Cntl_B,
							 CLK => notclock,
							 O => OP_B,
							 rst=> rst
							 );
		 
		 MUX_A: entity work.mux_5to1
				Port map( A => register_a,
							 B => load_forward,							 
							 C => wb_forward,
							 D => rr_forward,
							 E => wbplus1_forward,
							 SEL => Cntl_A,
							 EN =>notclock,
							 OUTP => OP_A,
							 rst => rst);
							 
--		MUX_B: entity work.mux_6to1
--				Port map( A => Decode_Reg,
--							 B => Reg_B,
--							 C => Load_EX_F,
--							 D => WB_F,
--							 E => RR_EX_F,
--							 F => WBplus1_F,							 
--							 SEL => Cntl_B,
--							 CLK => notclock,
--							 O => OP_B,
--							 rst=> rst
--							 );
--		 
--		 MUX_A: entity work.mux_5to1
--				Port map( A => Reg_A,
--							 B => Load_EX_F,							 
--							 C => WB_F,
--							 D => RR_EX_F,
--							 E => WBplus1_F,
--							 SEL => Cntl_A,
--							 EN =>notclock,
--							 OUTP => OP_A,
--							 rst => rst);
							 

end Behavioral;

