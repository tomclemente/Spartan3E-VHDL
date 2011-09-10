----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:03:42 08/28/2011 
-- Design Name: 
-- Module Name:    Logic - Behavioral 
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

entity Logic is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           mode : in STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
			  
end Logic;

architecture Behavioral of Logic is

begin

	process(op1,op2,mode)
	
		variable temp : std_logic_vector (7 downto 0);
		
			begin
				case (mode) is
					when "000" => temp := op1 AND op2;
					
					when "001" => temp := op1 OR op2;
					
					when "010" => temp := NOT op1;
					
					when "011" => temp := op1 XOR op2;
					
					when others => temp := "ZZZZZZZZ";
					
				end case;
				
		output <= temp;
	end process;

end Behavioral;
 

