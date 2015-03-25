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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity result_bank is
	generic(	num_reg	 : integer:= 20;	-- number of registers
				num_bits  :	integer:= 16;	-- number of bits in a register
				addr_size :	integer:= 8);	-- number of addressing bits, 16 registers
	
	port(	-- input addresses
			read_addr	:	in std_logic_vector(addr_size-1 downto 0);	-- address of register a to read from
			
			-- input data
			data_in	:		in std_logic_vector(num_bits-1 downto 0);		-- data to store on write back, when applicable
			
			-- output data
			data_out		:		out std_logic_vector(num_bits-1 downto 0);	-- data read from register a
			
			-- control signals
			rst		:		in std_logic;											-- universal reset
			w_en		:		in std_logic_vector(0 downto 0);					-- write enable
			clk 		:		in std_logic);											-- system clock, used on rising edge
end result_bank;

architecture behavioral of result_bank is
	-- create an array of num_reg each num_bits wide
	type regs_type is array(0 to num_reg-1) of std_logic_vector(num_bits-1 downto 0);
	signal reg_collection : regs_type := (others => (others => '0'));
	signal write_addr : STD_LOGIC_VECTOR(addr_size-1 downto 0) := (others => '0');
	
begin

	-- perform a write
	process(clk, RST)
	begin
		if (clk'event and clk = '0') then    	-- on the falling edge
			if (rst = '1') then
				write_addr <= (others => '0');
				reg_collection <= (others => (others => '0'));
			elsif(w_en(0) = '1') then																-- if a write is being enabled
				reg_collection(to_integer(unsigned(write_addr))) <= data_in;	-- write to the register being addressed
				write_addr <= write_addr + 1;
			end if;
		end if;
	end process;
	
	-- perform a read
	process(clk)
	begin
		if (clk'event and clk = '1') then 		-- on the rigsing edge
				data_out <= reg_collection(to_integer(unsigned(read_addr)));
		end if;
	end process;
	
end behavioral;
