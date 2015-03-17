----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:55 03/14/2015 
-- Design Name: 
-- Module Name:    reg_bank - behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

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
			w_en		:		in std_logic_vector(0 downto 0);	-- write enable, since block ram is a vector, must be vector
			clk		:		in std_logic);							-- system clock

end reg_bank;

architecture behavioral of reg_bank is
	signal clk_write, clk_read	: std_logic;

begin
	clk_write 	<= not clk;		-- write is done on falling edge (block ram is triggered on rising edge)
	clk_read		<= clk;			-- read is done on rising edge
	
	-- instantiate two block rams to operate in parallel as follows:
	--			ram_a reads out to register a
	--			ram_b reads out to register b
	--			the same write occurs to both reigsters to ensure the same data
	ram_a: entity work.reg_bank_ram
		port map(	clka 	=> clk_write,
						wea	=> w_en,
						addra	=> write_addr,
						dina	=> data_in,
						clkb	=> clk_read,
						addrb	=>	reg_a_addr,
						doutb	=>	reg_a);

	ram_b: entity work.reg_bank_ram
		port map(	clka 	=> clk_write,
						wea	=> w_en,
						addra	=> write_addr,
						dina	=> data_in,
						clkb	=> clk_read,
						addrb	=>	reg_b_addr,
						doutb	=>	reg_b);
end behavioral;

