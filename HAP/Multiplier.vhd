----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:17:16 08/22/2011 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
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

entity Multiplier is

    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
          		op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           		output : out  STD_LOGIC_VECTOR (7 downto 0));

end Multiplier;


architecture Behavioral of Multiplier is

	begin

		process(op1, op2)
	
			variable count, data_out: std_logic_vector(7 downto 0);
			variable mult1, mult2: std_logic_vector(3 downto 0);
		
			begin
			
				mult1 := op1(3 downto 0);
				mult2 := op2(3 downto 0);
			
				data_out := "00000000";
				count := "00000000";
			
				while count < mult2 loop
				
					data_out := data_out + Op1;
					count := count + '1';
					
				end loop;
				
			output <= data_out;
		
		end process;
	
end Behavioral;

