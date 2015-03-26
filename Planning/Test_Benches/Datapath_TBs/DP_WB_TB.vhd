--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:30:35 03/25/2015
-- Design Name:   
-- Module Name:   D:/ECE368/Project Path/DP_WB_TB/DP_WB_TB.vhd
-- Project Name:  DP_WB_TB
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
USE ieee.numeric_std.ALL;
 
ENTITY DP_WB_TB IS
END DP_WB_TB;
 
ARCHITECTURE behavior OF DP_WB_TB IS 
 
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		ALU_result <= "1111000000000000";
	Load_result <= "1010101010101010";
	sel <= '0';
	wait for CLK_period*2;
	sel <= '1';
	wait for CLK_period*2;
	sel <= '0';

      wait;
   end process;
	
	
END;
