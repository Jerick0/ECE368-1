--------------------------------------------------------------------------------
-- Company: 
-- Engineer:	Josh Erick
--
-- Create Date:   01:05:07 03/24/2015
-- Design Name:   
-- Module Name:   D:/Xilinx/WB_TB/WB_TB.vhd
-- Project Name:  WB_TB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WB_controlpath
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
 
ENTITY WB_TB IS
END WB_TB;
 
ARCHITECTURE behavior OF WB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WB_controlpath
    PORT(
         WB_inst : IN  std_logic_vector(15 downto 0);
         WB_instout : OUT  std_logic_vector(15 downto 0);
         Reg_Aval : OUT  std_logic_vector(3 downto 0);
         En_StoreData : OUT  std_logic_vector(0 downto 0);
         WB_mux : OUT  std_logic;
         CLK : IN  std_logic;
         NotCLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal WB_inst : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal NotCLK : std_logic := '0';

 	--Outputs
   signal WB_instout : std_logic_vector(15 downto 0);
   signal Reg_Aval : std_logic_vector(3 downto 0);
   signal En_StoreData : std_logic_vector(0 downto 0);
   signal WB_mux : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant NotCLK_period : time := 10 ns;
 
BEGIN
notclk <= not clk;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WB_controlpath PORT MAP (
          WB_inst => WB_inst,
          WB_instout => WB_instout,
          Reg_Aval => Reg_Aval,
          En_StoreData => En_StoreData,
          WB_mux => WB_mux,
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
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		WB_inst <= "1001000100010000";
		wait for CLK_period;
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		WB_inst <= "1010000100010000";
		wait for CLK_period;
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		WB_inst <= "0001000100010000";
		wait for CLK_period;
		
		
		
		

      wait;
   end process;

END;
