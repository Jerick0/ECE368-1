---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Daniel Noyes
-- 
-- Create Date:    SPRING 2015
-- Module Name:    SevenSeg_toplevel
-- Project Name:   SevenSegmentDisplay
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description: 7-segment toplevel example
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity SSeg_toplevel is
	generic(	num_bits	: integer:=16);
	
   port(	CLK 		: in  STD_LOGIC; -- 50 MHz input
			RESULT  	: in  STD_LOGIC_VECTOR (num_bits-1 downto 0);
			SEG 		: out STD_LOGIC_VECTOR (6 downto 0);
			DP  		: out STD_LOGIC;
			AN  		: out STD_LOGIC_VECTOR (3 downto 0));

end SSeg_toplevel;

architecture Structural of SSeg_toplevel is
    signal enl : STD_LOGIC := '1';
    signal dpc : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal cen : STD_LOGIC := '0';
	 signal off : std_logic;

begin
	off <= '0';
    ----- Structural Components: -----
    SSeg: entity work.SSegDriver
    port map( CLK     => CLK,
              RST     => off,
              EN      => enl,
              SEG_0   => RESULT(3 downto 0),
              SEG_1   => RESULT(7 downto 4),
              SEG_2   => RESULT(11 downto 8),
              SEG_3   => RESULT(15 downto 12),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);

    
    ----- End Structural Components -----

end Structural;






