--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:38:09 03/25/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/GitHub/ECE368/Planning/Test_Benches/Datapath_TBs/write_back_tb.vhd
-- Project Name:  writeback_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: write_back
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY write_back_tb IS
END write_back_tb;
 
ARCHITECTURE behavior OF write_back_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT write_back
    PORT(
         alu_result : IN  std_logic_vector(15 downto 0);
         load_result : IN  std_logic_vector(15 downto 0);
         writeback_out : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal alu_result : std_logic_vector(15 downto 0) := (others => '0');
   signal load_result : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal sel : std_logic := '0';

 	--Outputs
   signal writeback_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: write_back PORT MAP (
          alu_result => alu_result,
          load_result => load_result,
          writeback_out => writeback_out,
          clk => clk,
          sel => sel
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for clk_period*21;
		
      -- insert stimulus here 
		alu_result	<= x"A5A5";
		load_result	<= x"F0F0";
		
		wait for clk_period*3/2;
		sel			<= '1';
		
      wait;
   end process;

END;
