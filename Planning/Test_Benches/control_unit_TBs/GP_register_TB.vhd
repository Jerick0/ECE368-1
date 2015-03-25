--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:52:11 03/23/2015
-- Design Name:   
-- Module Name:   D:/ECE368/Project Path/GP_reg_TB/GPREG_TB.vhd
-- Project Name:  GP_reg_TB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GP_register
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
 
ENTITY GPREG_TB IS
END GPREG_TB;
 
ARCHITECTURE behavior OF GPREG_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GP_register
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         D : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal D : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GP_register PORT MAP (
          CLK => CLK,
          RST => RST,
          D => D,
          Q => Q
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
		D <= "1010101010101010";
		wait for CLK_period/2;
		d <= "1111010111110000";
		wait for CLK_period;
      wait;
   end process;

END;
