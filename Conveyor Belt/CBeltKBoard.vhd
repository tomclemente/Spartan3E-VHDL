---------------------------------------------------------------------------------- 
-- Module Name:    CBeltKBoard - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBeltKBoard is
    Port ( keyIn : in STD_LOGIC_VECTOR (3 downto 0);
				DataAv : in STD_LOGIC;
				Reset : in  STD_LOGIC;
				enableThis : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Sensor : in  STD_LOGIC;
			  Switch : in  STD_LOGIC;
           KBClock : in  STD_LOGIC;
           KBData : in  STD_LOGIC;
			  red : out STD_LOGIC;
			  green : out STD_LOGIC;
           blue : out STD_LOGIC;
			  hsync : out STD_LOGIC;
			  vsync : out STD_LOGIC;
			  keyOut : out  STD_LOGIC_VECTOR (3 downto 0);
           Left : out  STD_LOGIC;
           Right : out  STD_LOGIC;
           outMode : out  STD_LOGIC_VECTOR (2 downto 0);
			  RS:out std_logic;
			  RW:out std_logic; 
			  E:out std_logic; 
			  SF_D:out std_logic_vector(3 downto 0);
           outEn : out  STD_LOGIC);
end CBeltKBoard;

architecture Behavioral of CBeltKBoard is

component keyboardStates is
     Port ( KBScanCode : in  STD_LOGIC_VECTOR (15 downto 0);
           Sensor : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  PWMen : out  STD_LOGIC;
			  displayFlag: out STD_LOGIC;
           Mode : out  STD_LOGIC_VECTOR (2 downto 0);
           KBEnable : out  STD_LOGIC);
end component;

component keyboardModule is
	Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           KBEnable : in  STD_LOGIC;
           KBClock : in  STD_LOGIC;
           KBData : in  STD_LOGIC;
           KBScancode : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component PWM is
    Port ( PWMen : in STD_LOGIC;
				Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           Clk : in  STD_LOGIC;
           PWMLeft : out  STD_LOGIC;
           PWMRight : out  STD_LOGIC);
end component;

component keypadStates is
   Port (	keyIn : in STD_LOGIC_VECTOR (3 downto 0);
				Sensor : in STD_LOGIC;
				Clock : in STD_LOGIC;
				Reset : in STD_LOGIC;
				DataAv : in STD_LOGIC;
				PWMen : out STD_LOGIC;
				displayFlag : out STD_LOGIC;
				keyOut : out  STD_LOGIC_VECTOR (3 downto 0);
				Mode : out STD_LOGIC_VECTOR (2 downto 0));    
end component;

component VGA is
	Port ( Clock					: 	in std_logic;
			 vga_r,vga_g,vga_b	:	out std_logic;
			 vga_hs,vga_vs		:	out std_logic);
end component;

component LCD2 is

	port(		RS:out std_logic; 
				RW:out std_logic;
				E:out std_logic; 
				clk:in std_logic; 
				Mode: in std_logic_vector(2 downto 0);
				AutoFlag: in std_logic;
				SF_D:out std_logic_vector(3 downto 0)); 
			
end component;


signal tempKEnable : STD_LOGIC;
signal tempScanCode : STD_LOGIC_VECTOR (15 downto 0);
signal tempPEnable, KPEnable, KBEnable : STD_LOGIC;
signal tempMode, KBMode, KPMode : STD_LOGIC_VECTOR (2 downto 0);
signal rsSig, rwSig, eSig : STD_LOGIC;
signal sfSig : STD_LOGIC_VECTOR(3 downto 0);
signal KPDisplayFlag, KBDisplayFlag, tempDisplayFlag : STD_LOGIC;
signal dummy: STD_LOGIC;
begin


	VG1: VGA port map (Clock, red, green, blue, hsync, vsync);
	KP1: keypadStates port map (keyIn, Sensor, Clock, Reset,DataAv, KPEnable, KPDisplayFlag, keyOut, KPMode);
	KB1: keyboardModule port map (Clock, Reset, tempKEnable, KBClock, KBData, tempScanCode);
	KB2: keyboardStates port map (tempScanCode, Sensor, Clock, Reset, KBEnable, KBDisplayFlag, KBMode, tempKEnable);
		
	process (enableThis, KBMode, KBEnable, KPMode, KPEnable)
	begin		
		if (enableThis = '1')	then
			tempMode <= KBMode;
			tempPEnable <= KBEnable;
			tempDisplayFlag <= KBDisplayFlag;
		elsif (enableThis = '0') then
			tempMode <= KPMode;
			tempPEnable <= KPEnable;
			tempDisplayFlag <= KPDisplayFlag;
		end if;
	end process;	
		
	LCD: LCD2 port map(rsSig, rwSig, eSig, Clock, tempMode, tempDisplayFlag, sfSig);
	CB1: PWM port map (tempPEnable, tempMode, Clock, Left, Right);
		
	outMode <= tempMode;
	outEn <= tempPEnable;
	RS<=rsSig;
	RW<=rwSig;
	E<=eSig;
	SF_D<=sfSig;
	
end Behavioral;