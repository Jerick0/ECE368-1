----------------------------------------------------------------------------------
-- Create Date:    22:02:42 03/12/2015  
-- Module Name:    reg_bank - behavioral 
-- Project Name: 	 umd risc machine
-- Description:    register bank is a collection of 16 registers
--						 on the rising edge of the clock the bank reads 
--									from two registers
--						 on the falling edge of the clock the bank writes
--									to a register if enabled
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_bank is
	generic(	num_reg	 : integer:= 16;	-- number of registers
				num_bits  :	integer:= 16;	-- number of bits in a register
				addr_size :	integer:= 4);	-- number of addressing bits, 16 registers
	
	port(	-- input addresses
			reg_a_addr	:	in std_logic_vector(addr_size-1 downto 0);	-- address of register a to read from
			reg_b_addr	:	in std_logic_vector(addr_size-1 downto 0);	-- address of register b to read from
			write_addr	:	in std_logic_vector(addr_size-1 downto 0);	-- address of regsiter to write to
			
			-- input data
			data_in	:		in std_logic_vector(num_bits-1 downto 0);		-- data to store on write back, when applicable
			
			-- output data
			reg_a		:		out std_logic_vector(num_bits-1 downto 0);	-- data read from register a
			reg_b		:		out std_logic_vector(num_bits-1 downto 0);	-- data read from register b
			
			-- control signals
			rst		:		in std_logic;											-- universal reset
			w_en		:		in std_logic_vector(0 downto 0);					-- write enable
			clk 		:		in std_logic);											-- system clock, used on rising edge
end reg_bank;

architecture behavioral of reg_bank is
	-- create an array of num_reg each num_bits wide
	type regs_type is array(0 to num_reg-1) of std_logic_vector(num_bits-1 downto 0);
	signal reg_collection : regs_type := (others => (others => '0'));
	
begin

	-- perform a write
	process(clk)
	begin
		if (clk'event and clk = '0') then    	-- on the falling edge
			if (rst = '1') then
				reg_collection <= (others => (others => '0'));
			elsif(w_en(0) = '1') then																-- if a write is being enabled
				reg_collection(to_integer(unsigned(write_addr))) <= data_in;	-- write to the register being addressed
			end if;
		end if;
	end process;
	
	-- perform a read
	process(clk)
	begin
		if (clk'event and clk = '1') then 		-- on the rigsing edge
				reg_a <= reg_collection(to_integer(unsigned(reg_a_addr)));		
				reg_b <= reg_collection(to_integer(unsigned(reg_b_addr)));
		end if;
	end process;
	
end behavioral;
