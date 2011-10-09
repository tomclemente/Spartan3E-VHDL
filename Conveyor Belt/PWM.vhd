----------------------------------------------------------------------------------
-- Module Name:    PWM - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
    Port ( PWMen : in STD_LOGIC;
				Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           Clk : in  STD_LOGIC;
           PWMLeft : out  STD_LOGIC;
           PWMRight : out  STD_LOGIC);
end PWM;

architecture Behavioral of PWM is

signal PWMcount : integer range 0 to 100000 := 0;
signal PWMsignal : std_logic := '0';
signal DutyCycle: integer range 0 to 15000:= 10000;
--signal DutyCycle: integer := 10; --For Simulation Purposes
signal flag, stopFlag : STD_LOGIC  := '0';

begin

	pwm: process(Clk, Mode, PWMcount, PWMen, PWMsignal, stopFlag)
	 
	begin
		
		if rising_edge(Clk) then
		
			PWMcount <= 0;
			if stopFlag = '1' then
				PWMcount <= 0;
			else
				PWMcount <= PWMcount + 1;
			end if;
				if (PWMcount < 100000) then --(100000cycles * 20n) = (2ms) = 500 Hz
				--For Simulation Purposes
				--if (PWMcount < 100) then
					if(PWMcount <  DutyCycle) then
						PWMsignal <= '1';
						flag <= '0';
					else
						flag <= '1';
						PWMsignal <= '0';	
					end if;
				else
					PWMcount <= 0;
				end if;
				
				
		end if;
		
	end process;
	 				
	modes: process (Mode, flag)
	begin
		if PWMen = '0' then
				PWMLeft <= '0';
				PWMRight <= '0';
		else		
			if Mode = "001" then --forward/automatic
				if flag = '1' then
					PWMLeft <= '0';
					PWMRight <= '0';
				elsif flag = '0' then
					PWMLeft <= PWMsignal;
					PWMRight <= not PWMsignal;
				end if;
				stopFlag <= '0';
				DutyCycle <= 10000;
				--DutyCycle <= 10; --For Simulation Purposes
			elsif Mode = "010" then --fast forward
				if flag = '1' then
					PWMLeft <= '0';
					PWMRight <= '0';
				elsif flag = '0' then
					PWMLeft <= PWMsignal;
					PWMRight <= not PWMsignal;
				end if;
				stopFlag <= '0';
				DutyCycle <= 15000;
				--DutyCycle <= 15; --For Simulation Purposes
			elsif Mode = "011" then --backward
				if flag = '1' then
					PWMLeft <= '0';
					PWMRight <= '0';
				elsif flag = '0' then
					PWMLeft <= not PWMsignal;
					PWMRight <= PWMsignal;
				end if;
				stopFlag <= '0';
				DutyCycle <= 10000;
				--DutyCycle <= 10; --For Simulation Purposes
			elsif Mode = "100" then --fast backward
				if flag = '1' then
					PWMLeft <= '0';
					PWMRight <= '0';
				elsif flag = '0' then
					PWMLeft <= not PWMsignal;
					PWMRight <= PWMsignal;
				end if;
				stopFlag <= '0';
				DutyCycle <= 15000;
				--DutyCycle <= 15; --For Simulation Purposes
			else
				PWMLeft <= '0';
				PWMRight <= '0';
				stopFlag <= '1';
				DutyCycle <= 0;
			end if;
		end if;
	end process;

end Behavioral;