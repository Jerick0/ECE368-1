----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date:    15:35:19 03/18/2015 
-- Design Name: 
-- Module Name:    mux_4to1 - Behavioral 
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


entity mux_4to1 is
	generic	(	num_bits			: integer := 5);
	
   port		( 	A 			: in  STD_LOGIC_Vector(num_bits-1 downto 0);
					B 			: in  STD_LOGIC_Vector(num_bits-1 downto 0);
					C 			: in  STD_LOGIC_Vector(num_bits-1 downto 0);
					D 			: in  STD_LOGIC_Vector(num_bits-1 downto 0);        
					SEL 		: in  STD_LOGIC_Vector(1 downto 0);
					CLK 		: in 	STD_LOGIC;
					O 			: out  STD_LOGIC_Vector(num_bits-1 downto 0);
					rst		: in std_logic);
end mux_4to1;

architecture Combinational of mux_4to1 is
	signal A_sig		: std_logic_vector(num_bits-1 downto 0);
	signal B_sig		: std_logic_vector(num_bits-1 downto 0);
	signal C_sig		: std_logic_vector(num_bits-1 downto 0);
	signal D_sig		: std_logic_vector(num_bits-1 downto 0);

begin
	A_sig <= A;
	B_sig <= B;
	C_sig <= C;
	D_sig <= D;
	
	with sel select O <=
		A_sig when "00",
		B_sig when "01",
		C_sig when "10",
		D_sig when "11",
		B_sig when others;

 end COMBINATIONAL;





