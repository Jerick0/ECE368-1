--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:26:07 03/24/2015
-- Design Name:   
-- Module Name:   D:/Xilinx/Execute_TB/Execute_TB.vhd
-- Project Name:  Execute_TB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: execute_controlpath
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
 
ENTITY Execute_TB IS
END Execute_TB;
 
ARCHITECTURE behavior OF Execute_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute_controlpath
    PORT(
         E_inst : IN  std_logic_vector(15 downto 0);
         E_instout : OUT  std_logic_vector(15 downto 0);
         opcode : OUT  std_logic_vector(3 downto 0);
         enable_SW : OUT  std_logic_vector(0 downto 0);
         CLK : IN  std_logic;
         NotCLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal E_inst : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal NotCLK : std_logic := '0';

 	--Outputs
   signal E_instout : std_logic_vector(15 downto 0);
   signal opcode : std_logic_vector(3 downto 0);
   signal enable_SW : std_logic_vector(0 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant NotCLK_period : time := 10 ns;
 
BEGIN
notclk <= not clk;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: execute_controlpath PORT MAP (
          E_inst => E_inst,
          E_instout => E_instout,
          opcode => opcode,
          enable_SW => enable_SW,
          CLK => CLK,
          NotCLK => NotCLK
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   NotCLK_process :process
   begin
		NotCLK <= '1';
		wait for NotCLK_period/2;
		NotCLK <= '0';
		wait for NotCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		E_inst<= "0000000100010000";
		wait for CLK_period;
		E_inst<="0001000100010000";
		wait for CLK_period;
		E_inst <= "0001000100010000";
		wait for CLK_period;
		E_inst<= "1010000100010000";
		wait for CLK_period;
		E_inst <= "0001000100010000";
		wait for CLK_period;

      wait;
   end process;

END;
