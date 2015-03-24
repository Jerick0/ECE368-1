--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:12:10 03/23/2015
-- Design Name:   
-- Module Name:   D:/ECE368/Project Path/Decode_TB/Decode_TB.vhd
-- Project Name:  Decode_TB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decode_controlpath
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
 
ENTITY Decode_TB IS
END Decode_TB;
 
ARCHITECTURE behavior OF Decode_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decode_controlpath
    PORT(
         D_inst : IN  std_logic_vector(15 downto 0);
         D_instout : OUT  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         NOTCLK : IN  std_logic;
         in_mux_sel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D_inst : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal NOTCLK : std_logic := '0';

 	--Outputs
   signal D_instout : std_logic_vector(15 downto 0);
   signal in_mux_sel : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant NOTCLK_period : time := 10 ns;
 
BEGIN
notCLK <= not CLK;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decode_controlpath PORT MAP (
          D_inst => D_inst,
          D_instout => D_instout,
          CLK => CLK,
          NOTCLK => NOTCLK,
          in_mux_sel => in_mux_sel
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   NOTCLK_process :process
   begin
		NOTCLK <= '1';
		wait for NOTCLK_period/2;
		NOTCLK <= '0';
		wait for NOTCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		
		D_inst <= "0000000100010000";
		wait for CLK_period;
		D_inst <= "0001000100010000";
		wait for CLK_period;
		D_inst <= "0111000100010000";

      wait;
   end process;

END;
