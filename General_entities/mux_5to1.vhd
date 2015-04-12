----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josh Erick
-- 
-- Create Date:    15:35:19 03/18/2015 
-- Design Name: 
-- Module Name:    mux_5to1 - Behavioral 
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

entity mux_5to1 is
	generic	(	num_bits			: integer := 13);
    Port ( A 		: in  STD_LOGIC_Vector(num_bits-1 downto 0);
           B 		: in  STD_LOGIC_Vector(num_bits-1 downto 0);
           C 		: in  STD_LOGIC_Vector(num_bits-1 downto 0);
           D 		: in  STD_LOGIC_Vector(num_bits-1 downto 0);
           E 		: in  STD_LOGIC_Vector(num_bits-1 downto 0);
           SEL 	: in  STD_LOGIC_Vector(2 downto 0);
           OUTP 	: out  STD_LOGIC_Vector(num_bits-1 downto 0);
			  rst		: in std_logic
			  );
end mux_5to1;

architecture Combinational of mux_5to1 is
	signal A_sig		: std_logic_vector(num_bits-1 downto 0);
	signal B_sig		: std_logic_vector(num_bits-1 downto 0);
	signal C_sig		: std_logic_vector(num_bits-1 downto 0);
	signal D_sig		: std_logic_vector(num_bits-1 downto 0);
	signal E_sig		: std_logic_vector(num_bits-1 downto 0);
begin
	A_sig <= A;
	B_sig <= B;
	C_sig <= C;
	D_sig <= D;
	E_sig <= E;

	with sel select OUTP <=
		A_sig when "000",
		B_sig when "001",
		C_sig when "010",
		D_sig when "011",
		E_sig when "100",
		B_sig when others;
		
 end COMBINATIONAL;





