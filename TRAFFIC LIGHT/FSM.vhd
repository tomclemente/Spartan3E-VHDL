----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:53:04 08/05/2011 
-- Design Name: 
-- Module Name:    ClockGen - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockGen is
	PORT(clk_in : IN std_logic;
		clk_out : OUT std_logic);
	
end ClockGen;

architecture Behavioral of ClockGen is

--constant PERIOD : time := '1';
				
--clk_in <= not clk_in after PERIOD/2;

signal clk_sig: std_logic;
signal count : integer:=0;
begin

	process (clk_in)
	--	variable count : integer :=0;
		begin
	
			if falling_edge(clk_in) then
				if(count=24999999) then
					clk_sig<=NOT(clk_sig);
					count<=0;
				else
				count<=count+1;
				end if;
			end if;
			
	end process;
	clk_out <= clk_sig;		
			
		

end Behavioral;

