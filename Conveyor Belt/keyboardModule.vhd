---------------------------------------------------------------------------------- 
-- Module Name:    keyboardModule - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyboardModule is
	Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           kBEnable : in  STD_LOGIC;
           kBClock : in  STD_LOGIC;
           kBData : in  STD_LOGIC;
           KBScancode : out  STD_LOGIC_VECTOR (15 downto 0));
end keyboardModule;

architecture Behavioral of keyboardModule is

signal kBClockFlag, kBDataFlag : STD_LOGIC;
signal kBClockTemp, kBDataTemp : STD_LOGIC_VECTOR(7 downto 0);
signal kBDataHigh, kBDataLow : STD_LOGIC_VECTOR(10 downto 0);
signal tempKBDataHigh, tempKBDataLow : STD_LOGIC_VECTOR(10 downto 0);

begin


		KBScancode <= kBDataHigh(8 downto 1) & kBDataLow(8 downto 1);
		
		data : PROCESS(Clock, Reset)
		begin
			if Reset = '1' then
				kBClockTemp <= "00000000";
				kBDataTemp <= "00000000";
				kBClockFlag <= '1';
				kBDataFlag <= '1';
			elsif Clock = '1' and Clock'event then
				kBClockTemp(7) <= kBClock;
				kBClockTemp(6 downto 0) <= kBClockTemp(7 downto 1);
				kBDataTemp(7) <= KBData;
				kBDataTemp(6 downto 0) <= kBDataTemp(7 downto 1);
				if kBClockTemp = "11111111" then
					kBClockFlag <= '1';
				elsif kBClockTemp = "00000000" then
					kBClockFlag <= '0';
				end if;
				if kBDataTemp = "11111111" then
					kBDataFlag <= '1';
				elsif kBDataTemp = "00000000" then
					kBDataFlag <= '0';
				end if;
			end if;
		end process;
		
		shift : PROCESS(kBClockFlag, Reset)
		begin
				if (Reset = '1') then
					kBDataHigh <= "00000000000";
					kBDataLow <= "00000000000";
				elsif (kBEnable = '0') then
					KBDataHigh <= tempKBDataHigh;
					KBDataLow <= tempKBDataLow;
				
				elsif (kBClockFlag = '0' and kBClockFlag'event and kBEnable = '1') then
					kBDataHigh <= kBDataFlag& kBDataHigh(10 downto 1);
					kBDataLow <= kBDataHigh(0) & kBDataLow(10 downto 1);
				end if;
				
				tempKBDataHigh<=KBDataHigh;
				tempKBDataLow<=KBDataLow;
		end process;
	

end Behavioral;