----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:10 08/28/2011 
-- Design Name: 
-- Module Name:    Shift - Behavioral 
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

entity Shift is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
			op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			mode	: in  STD_LOGIC_VECTOR (2 downto 0);			  
			output : out  STD_LOGIC_VECTOR (7 downto 0);
			S_out: out STD_LOGIC);
			
end Shift;

architecture Behavioral of Shift is

begin

	process(op1,op2,mode)

		variable Input1 : STD_LOGIC_VECTOR(7 downto 0);
		variable Input2 : integer range 0 to 255;
		variable count : integer range 0 to 255;
	
		begin
		
		Input1 := op1;
		Input2 := CONV_INTEGER(op2(2 downto 0));	
		count :=0;
		
			for x in 6 downto 0 loop
					if Input2 = count then exit; 
					end if;
					if mode = "000" then 									--SRL
						Input1 := '0' & Input1(7 downto 1);
						S_out <= Input1(0);
					elsif mode = "001" then 								--SRA
						Input1 := Input1(7) & Input1(7 downto 1); 
						S_out <= Input1(0);	
					elsif mode = "010" then 	
						Input1 := Input1(6 downto 0) & '0';				--SLL
						S_out <= Input1(7);
					elsif mode = "011" then 	
						Input1 := Input1(6 downto 0) & Input1(7);		--ROL
						S_out <= Input1(7);	
					elsif mode = "100" then 	
						Input1 := Input1(0) & Input1(7 downto 1);		--ROR
						S_out <= Input1(0);	
					else Input1 := "ZZZZZZZZ"; exit;
					
					end if;	
				count := count + 1;
			end loop;
				
		output <=  Input1;
				
	end process;
		
end Behavioral;
