----------------------------------------------------------------------------------
-- Module Name:    keypadStates - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypadStates is
   Port (	keyIn : in STD_LOGIC_VECTOR (3 downto 0);
				Sensor : in STD_LOGIC;
				Clock : in STD_LOGIC;
				Reset : in STD_LOGIC;
				DataAv : in STD_LOGIC;
				PWMen : out STD_LOGIC;
				displayFlag : out STD_LOGIC;
				keyOut : out  STD_LOGIC_VECTOR (3 downto 0);
				Mode : out STD_LOGIC_VECTOR (2 downto 0));   
end keypadStates;
	

architecture Behavioral of keypadStates is

type state is (pressKey, Automatic, Pause, Forward, forwardFast, Backward, backwardFast);
signal presentState : state;
signal ExternalCount : integer range 0 to 300000000 := 0; 
--50 000 000 is 1 second, 250 000 000 is 5 seconds
signal autoFlag, oneFlag, fiveFlag : STD_LOGIC := '0';

begin

control: process(Clock, DataAv, presentState, KeyIn, oneFlag, fiveFlag, Sensor)	
begin
	
	if rising_edge(Clock) then
			if Reset='1' then
					presentState <= pressKey;
			else
				case presentState is
		
				when pressKey =>	
					PWMen <= '0';
					Mode <= "000";
					displayFlag <= '0';
					if (DataAv = '1') then
						if keyIn = "0001" then
							presentState <= Forward;
						elsif keyIn = "0100" then
							presentState <= forwardFast;
						elsif keyIn = "0110" then
							presentState <= backwardFast;
						elsif keyIn = "1001" then
							presentState <= Backward;
						elsif keyIn = "0000" then 
							presentState <= Automatic;
						else
							presentState <= pressKey;
						end if;		
					else
						presentState <= pressKey;
					end if;
					
				when Forward =>	
					PWMen <= '1';
					autoFlag <= '0';
					displayFlag <= '0';
					if (DataAv = '1') then
						if (keyIn = "0001") then
							presentState <= Forward;
							Mode <= "001"; --PWM starts forward
						else
							presentState <= pressKey;
						end if;
					elsif (DataAv = '0') then
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					end if;
				
				when forwardFast =>	
					PWMen <= '1';
					autoFlag <= '0';
					displayFlag <= '0';
					if (DataAv = '1') then
						if (keyIn = "0100") then
							presentState <= forwardFast;
							Mode <= "010"; --PWM starts forward
						else
							presentState <= pressKey;
						end if;
					elsif (DataAv = '0') then
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					end if;
				
				when Backward =>
					PWMen <= '1';
					autoFlag <= '0';
					displayFlag <= '0';
					if (DataAv = '1') then
						if (keyIn = "1001") then
							Mode <= "011"; --PWM starts backward
							presentState <= Backward;
						else
							presentState <= pressKey;
						end if;
					elsif (DataAv = '0') then
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					end if;
					
				when backwardFast =>
					PWMen <= '1';
					autoFlag <= '0';
					displayFlag <= '0';
					if (DataAv = '1') then
						if (keyIn = "0110") then
							Mode <= "100"; --PWM starts backward
							presentState <= backwardFast;
						else
							presentState <= pressKey;
						end if;
					elsif (DataAv = '0') then
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					end if;	
					
				when Automatic =>
						PWMen <= '1';
						displayFlag <= '1';
						if (DataAv = '1') then
							autoFlag <= '0';
							if (keyIn = "1101") then
								presentState <= pressKey;
								Mode <= "000";
							else
								presentState <= Automatic;
							end if;
						elsif Sensor = '1' then
							autoFlag <= '1';
							Mode <= "001";
							if oneFlag = '1' then
								presentState <= Pause;
							end if;
							
						elsif Sensor = '0' then
							Mode <= "000";
							autoFlag <= '0';
							presentState <= Automatic;
						else
							autoFlag <= '0';
						end if;
							
				when Pause =>
						displayFlag <= '1';
						if (DataAv = '1') then
							presentState <= pressKey;
							Mode <= "000";
						elsif fiveFlag = '1' then
							presentState <= Automatic;
						else
							Mode <= "000";
							presentState <= Pause;
						end if;						
					
				when others => presentState <= pressKey;
				end case;
			end if;
	end if;
end process;
	

	excount: process (Clock, ExternalCount, autoFlag)
	begin
		if rising_edge(Clock) then
		
			if (autoFlag = '1') then
			
				ExternalCount <= ExternalCount + 1;
	
				if ExternalCount = 0 then
					oneFlag <= '0';
					fiveFlag <= '0';
				elsif (ExternalCount = 100000000) then -- 2 seconds
				--elsif (ExternalCount = 15) then --1 second --For Simulation Purposes
					oneFlag <= '1';
				elsif (ExternalCount = 300000000) then -- 5 seconds
				--elsif (ExternalCount >= 30) then --5 seconds --For Simulation Purposes
					ExternalCount <= 0;
					fiveFlag <= '1';
				end if;
			else
				ExternalCount <= 0;
				oneFlag <= '0';
				fiveFlag <= '0';
			end if;			
		end if;
	end process;

	keyOut <= keyIn;
end Behavioral;