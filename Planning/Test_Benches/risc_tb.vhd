--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:36:28 03/24/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/GitHub/ECE368/Planning/Test_Benches/risc_tb.vhd
-- Project Name:  RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Risc_machine
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
 
ENTITY risc_tb IS
END risc_tb;
 
ARCHITECTURE behavior OF risc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Risc_machine
    PORT(
         CLK : IN  std_logic;
         Store_Result : OUT  std_logic_vector(15 downto 0);
         WB_Result : OUT  std_logic_vector(15 downto 0);
         OPCODE : OUT  std_logic_vector(3 downto 0);
         ST_offset : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal Store_Result : std_logic_vector(15 downto 0);
   signal WB_Result : std_logic_vector(15 downto 0);
   signal OPCODE : std_logic_vector(3 downto 0);
   signal ST_offset : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Risc_machine PORT MAP (
          CLK => CLK,
          Store_Result => Store_Result,
          WB_Result => WB_Result,
          OPCODE => OPCODE,
          ST_offset => ST_offset
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
