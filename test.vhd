----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:57:14 07/28/2011 
-- Design Name: 
-- Module Name:    test - Behavioral 
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

library SFR;
use SFR.ROTATE.all;
			
entity test is
    Port ( mode : in  STD_LOGIC_VECTOR (1 downto 0);
			  shiftinput: in STD_LOGIC;
			  enable: in STD_LOGIC;
           inputshift : in  STD_LOGIC_VECTOR (7 downto 0);
           outputshift : out  STD_LOGIC_VECTOR (7 downto 0));
end test;

architecture Behavioral of test is

--   <signal_name> = <function_name>(<input1> => <insig1>, <input2> => <insig2>, ...);
	
--   <signal_name> = <function_name>(<comma_separated_inputs>);

signal temp : STD_LOGIC_VECTOR(7 downto 0);
signal temp2: STD_LOGIC_VECTOR(3 downto 0);


begin


rot: process(inputshift, mode, shiftinput, temp, temp2, enable)
	
	begin
		--enable<= '0';
		temp2<="0000";
		temp<=inputshift(7 downto 6) & temp2 & inputshift(1 downto 0);
		
		if(enable='1') then
			if(mode="00")  then outputshift <=ROLCF(temp, );
				end if;
			if(mode="01")  then outputshift <=RORF(temp); 
				end if;
			if(mode="10")  then  ROLP(temp, outputshift); 
				end if;
			if(mode="11")   then RORCP(temp, shiftinput, outputshift); 
				end if;
		else
			outputshift <= temp;
		end if;
end process shft;

   --<procedure_name>(<comma_separated_inputs>,<comma_separated_outputs>);
			

end Behavioral;

