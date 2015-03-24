--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:36:14 03/24/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/College/UMD/Digital Design/Lab03/Testing/Fetch_Test/fetch_reset_tb.vhd
-- Project Name:  Fetch_Test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fetch_reset_test
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
 
ENTITY fetch_reset_tb IS
END fetch_reset_tb;
 
ARCHITECTURE behavior OF fetch_reset_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fetch_reset_test
    PORT(
         clk : IN  std_logic;
         IMM : OUT  std_logic_vector(3 downto 0);
         RB : OUT  std_logic_vector(3 downto 0);
         RA : OUT  std_logic_vector(3 downto 0);
         ProgC : OUT  std_logic_vector(13 downto 0);
         INST : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal IMM : std_logic_vector(3 downto 0);
   signal RB : std_logic_vector(3 downto 0);
   signal RA : std_logic_vector(3 downto 0);
   signal ProgC : std_logic_vector(13 downto 0);
   signal INST : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fetch_reset_test PORT MAP (
          clk => clk,
          IMM => IMM,
          RB => RB,
          RA => RA,
          ProgC => ProgC,
          INST => INST
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

      wait;
   end process;

END;
