----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:50:31 08/19/2011 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
    Port ( clk_in : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Sensor : in  STD_LOGIC;
           Highway : out  STD_LOGIC_VECTOR (2 downto 0);
           Farm : out  STD_LOGIC_VECTOR (2 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

	type states is (st0, st1, st2, st3);
	signal present_state, next_state: states;
	signal counter : integer:=0;
	signal flag,flag1: integer:=0;

begin

--	check: process(reset,clk_in)
--	begin
--		
--		if(reset='1') then
--			present_state <= st0;
--			counter<=0;
--			
--		elsif rising_edge(clk_in) then
--			
--			counter<=counter+1;
--			present_state <= next_state;
--			
--		end if;
--	
--	end process;

	trans: process(next_state,Sensor,clk_in,reset)
		--	variable counter : integer:=0;
	begin

	
	if(rising_edge(clk_in)) then
	if(reset='1') then
	counter<=0;
	next_state<st0;s
	else
	
		case next_state is	
			when st0 => Highway <= "100";
							Farm <= "001";
						
						if(Sensor='1' and counter>=14) then
							next_state<=st1;
						else
							counter<=counter+1;
							next_state<=st0;
						end if;
							
						
						
				when st1 => Highway <= "010";
								Farm <= "001";
								next_state<=st2;
								
				when st2 => Highway <= "001";
								Farm <= "100";
							if(Sensor='0') then
								next_state<=st3;
							else
								next_state<=st2;
							end if;
				when st3 => Highway <= "001";
								Farm <= "010";
								counter<=0;
								next_state<=st0;
								
		end case;	
	end if;end if;
	end process;

end Behavioral;

