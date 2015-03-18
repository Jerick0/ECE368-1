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
    Port ( Decode_Reg : in  STD_LOGIC_Vector(15 downto 0);
            Reg_B : in  STD_LOGIC_Vector(15 downto 0);
           Reg_A : in  STD_LOGIC_Vector(15 downto 0);
           Load_EX_F : in  STD_LOGIC_Vector(15 downto 0);
           Load_WB_F : in  STD_LOGIC_Vector(15 downto 0);
           WB_F_Reg : in  STD_LOGIC_Vector(15 downto 0);
            EX_F_Reg : in  STD_LOGIC_Vector(15 downto 0);
           EX_F_Line : in  STD_LOGIC_Vector(15 downto 0);
           Load_Fwd_line : in  STD_LOGIC_Vector(15 downto 0);
           Cntl_A : in  STD_LOGIC_Vector(2 downto 0);
           Cntl_B : in  STD_LOGIC_Vector(1 downto 0);
			  CLK		: in  STD_LOGIC;
           OP_A : out  STD_LOGIC_Vector(15 downto 0);
           OP_B : out  STD_LOGIC_Vector(15 downto 0)
			  );
end Opacc;

architecture Behavioral of Opacc is

begin
		MUX_B: entity work.mux2to1
				Port map( IN_1 => Decode_Reg,
							 IN_2 => Reg_B,
							 SEL => Cntl_B,
							 CLK => CLK,
							 O => OP_B );
		 
		 Mux_A: entity work.mux_7to1
				Port map( A => Reg_A,
							 B => Load_EX_F,
							 C => Load_WB_F,
							 D => WB_F_Reg,
							 E => EX_F_Reg,
							 F => EX_F_Line,
							 G => Load_Fwd_line,
							 SEL => Cntl_A,
							 EN =>CLK,
							 OUTP => OP_A);
							 
							 
							 

end Behavioral;

