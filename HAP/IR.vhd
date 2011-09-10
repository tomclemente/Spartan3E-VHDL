----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:39:40 08/22/2011 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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

entity IR is
    Port ( instIn : in  STD_LOGIC_VECTOR (15 downto 0);
			  IRen : in STD_LOGIC;
			  Clock : in STD_LOGIC;
			  Opcode : out STD_LOGIC_VECTOR(4 downto 0);
			  RD : out STD_LOGIC_VECTOR(2 downto 0);
			  R1 : out STD_LOGIC_VECTOR(2 downto 0);
			  R2 : out STD_LOGIC_VECTOR(2 downto 0);
			  memOut : out STD_LOGIC_VECTOR(7 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end IR;

architecture Behavioral of IR is
	
	signal tempOp : STD_LOGIC_VECTOR(4 downto 0);
	signal tempRD, tempR1, tempR2 : STD_LOGIC_VECTOR(2 downto 0);
	signal tempmemOut, tempdataOut : STD_LOGIC_VECTOR(7 downto 0);
	
begin

	tempOp <= instIn(15 downto 11);

	process (IRen, Clock, instIn) is
	
	begin
	
		if(rising_edge(Clock)) then
			if(IRen = '1') then
			--for ALU (shift,logic,addition,subtraction,compare,multiplication,division)
				if((tempOp >= "00000") or (tempOp <= "10010")) then
					tempRD <= instIn(10 downto 8);
					tempR1 <= instIn(6 downto 4);
					tempR2 <= instIn(2 downto 0);
					tempmemOut <= "00000000";
					tempdataOut <= "00000000";
				end if;
			
			--for BNE and BE
				if((tempOp = "10011") or (tempOp = "10100")) then
					tempR1 <= instIn(10 downto 8);
					tempmemOut <= instIn(7 downto 0);
					tempRD <= "000";
					tempR2 <= "000";
					tempdataOut <= "00000000";
				end if;
			
			--for BNER and BER
				if((tempOp = "10101") or (tempOp = "10110")) then
					tempR1 <= instIn(10 downto 8);
					tempR2 <= instIn(2 downto 0);
					tempRD <= "000";
					tempmemOut <= "00000000";
					tempdataOut <= "00000000";
				end if;
			
			--for J
				if(tempOp = "10111") then
					tempmemOut <= instIn(7 downto 0);
					tempRD <= "000";
					tempR1 <= "000";
					tempR2 <= "000";
					tempdataOut <= "00000000";
				end if;
			
			--for JR
				if(tempOp = "11000") then
					tempR1 <= instIn(2 downto 0);
					tempRD <= "000";
					tempR2 <= "000";
					tempmemOut <= "00000000";
					tempdataOut <= "00000000";
				end if;
			
			--for LI
				if(tempOp = "11001") then
					tempRD <= instIn(10 downto 8);
					tempdataOut <= instIn(7 downto 0);
					tempR1 <= "000";
					tempR2 <= "000";
					tempmemOut <= "00000000";
				end if;
			
			--for LD
				if(tempOp = "11010") then
					tempRD <= instIn(10 downto 8);
					tempmemOut <= instIn(7 downto 0);
					tempR1 <= "000";
					tempR2 <= "000";
					tempdataOut <= "00000000";
				end if;
			
			--for STORE
				if(tempOp = "11011") then
					tempR1 <= instIn(10 downto 8);
					tempmemOut <= instIn(7 downto 0);
					tempRD <= "000";
					tempR2 <= "000";
					tempdataOut <= "00000000";
				end if;
			end if;
		end if;
				
	end process;

	Opcode <= tempOp;
	RD <= tempRD;
	R1 <= tempR1;
	R2 <= tempR2;
	memOut <= tempmemOut;
	dataOut <= tempdataOut;

end Behavioral;

