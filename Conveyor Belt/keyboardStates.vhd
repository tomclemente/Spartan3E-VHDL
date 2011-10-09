----------------------------------------------------------------------------------
-- Module Name:    keyboardStates - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyboardStates is
    Port ( KBScanCode : in  STD_LOGIC_VECTOR (15 downto 0);
           Sensor : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  PWMen : out  STD_LOGIC;
			  displayFlag: out STD_LOGIC;
           Mode : out  STD_LOGIC_VECTOR (2 downto 0);
           KBEnable : out  STD_LOGIC);
end keyboardStates;

architecture Behavioral of keyboardStates is

type state is (pressKey, Automatic, Pause, Forward, forwardFast, Backward, backwardFast);
signal presentState : state;
signal ExternalCount : integer range 0 to 300000000 := 0; 
--50 000 000 is 1 second, 250 000 000 is 5 seconds
signal autoFlag, oneFlag, fiveFlag : STD_LOGIC := '0';

begin

control: process(Clock, presentState, oneFlag, fiveFlag, Sensor, KBScanCode)
	
begin
	
	if rising_edge(Clock) then
			if Reset='1' then
					presentState <= pressKey;
					KBEnable <= '1';
			else
				case presentState is
					
				when pressKey =>	
					PWMen <= '0';
					Mode <= "000";
					KBEnable <= '1';
					displayFlag <= '0';
					--Forward -  2(1EF0), W(1DF0)
					if (KBScanCode = x"1EF0" or KBScanCode = x"1DF0") then		
							presentState <= Forward;
					--fastForward - 4(25F0), A(1CF0)		
					elsif (KBScanCode = x"25F0" or KBScanCode = x"1CF0") then	
							presentState <= forwardFast;
					--Backward - 8(3EF0), Z(1AF0)		
					elsif (KBScanCode = x"3EF0" or KBScanCode = x"1AF0") then	
							presentState <= Backward;
					--fastBackward - 6(36F0), S(1BF0)		
					elsif (KBScanCode = x"36F0" or KBScanCode = x"1BF0") then	
							presentState <= backwardFast;
					--Automatic - 1(16F0)		
					elsif (KBScanCode = x"16F0") then										
							presentState <= Automatic;
					--stop - 0 (45F0), spacebar (29F0)		
					elsif (KBScanCode = x"45F0" or KBScanCode = x"29F0") then	
							presentState <= pressKey;
					else
						presentState <= pressKey;
					end if;
					
				when Forward =>	
					displayFlag <= '0';
					autoFlag <= '0';
					KBEnable <= '1';
					--stop - 0 (45F0), spacebar (29F0)
					if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
						PWMen <= '0';
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					else
						PWMen <= '1';
						Mode <= "001"; --PWM forwards
						presentState <= Forward;
					end if;
				
				when forwardFast =>	
					displayFlag <= '0';
					autoFlag <= '0';
					KBEnable <= '1';
					--stop - 0 (45F0), spacebar (29F0)
					if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
						PWMen <= '0';
						Mode <= "000"; --PWM stops
						presentState <= pressKey;
					else
						PWMen <= '1';
						Mode <= "010";
						presentState <= forwardFast;
						
					end if;
				
				when Backward =>
					displayFlag <= '0';
					autoFlag <= '0';
					KBEnable <= '1';
					--stop - 0 (45F0), spacebar (29F0)
					if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
							PWMen <= '0';
							Mode <= "000"; --PWM stops
							presentState <= pressKey;
					else
						PWMen <= '1';
						Mode <= "011";
						presentState <= Backward;
						
					end if;
					
				when backwardFast =>
					displayFlag <= '0';
					autoFlag <= '0';
					KBEnable <= '1';
					--stop - 0 (45F0), spacebar (29F0)
					if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
							PWMen <= '0';
							Mode <= "000"; --PWM stops
							presentState <= pressKey;
					else
						PWMen <= '1';
						Mode <= "100";
						presentState <= backwardFast;
						
					end if;	
					
				when Automatic =>
						displayFlag <= '1';
						KBEnable <= '1';
						--stop - 0 (45F0), spacebar (29F0)
						if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
							PWMen <= '0';
							Mode <= "000"; --PWM stops
							presentState <= pressKey;
						elsif Sensor = '1' then
							PWMen <= '1';
							autoFlag <= '1';
							Mode <= "001";
							if oneFlag = '1' then
								PWMen <= '0';
								presentState <= Pause;
							end if;
						elsif Sensor = '0' then
							PWMen <= '0';
							Mode <= "000";
							autoFlag <= '0';
							presentState <= Automatic;
						else
							autoFlag <= '0';
						end if;
					
							
				when Pause =>
						displayFlag <= '1';
						KBEnable <= '1';
						if (KBScanCode = x"45F0" or KBScanCode = x"29F0") then
							PWMen <= '0';
							Mode <= "000"; --PWM stops
							presentState <= pressKey;
						else
							if fiveFlag = '1' then
								presentState <= Automatic;
							else
								PWMen <= '0';
								Mode <= "000";
								presentState <= Pause;
							end if;
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
	
end Behavioral;

