----------------------------------------------------------------------------------
-- Module Name:    LCD2 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LCD2 is

	port(		RS:out std_logic;
				RW:out std_logic; 
				E:out std_logic; 
				clk:in std_logic;
				Mode: in std_logic_vector(2 downto 0);
				AutoFlag: in std_logic;
				SF_D:out std_logic_vector(3 downto 0));
			
end LCD2;

architecture Behavioral of LCD2 is
type states is (T0, T1, T2, T3, T4);
signal present_state: states:=T0;
signal clockCount,i,substate: integer:=0;
signal modSig: STD_LOGIC_VECTOR(2 downto 0);
signal autoSig: STD_LOGIC;
type ROM_LUT is array (0 to 5) of STD_LOGIC_VECTOR (7 downto 0);
	constant INST: ROM_LUT := (
	0 => x"28",
	1 => x"06",
	2 => x"0C",
	3 => x"01",
	4 => x"80",
	
		OTHERS => X"00" 
	); 
	
type FORWARD_LUT is array (0 to 12) of STD_LOGIC_VECTOR (7 downto 0);
	constant forw: FORWARD_LUT := (
	0 => x"46", --F
	1 => x"61", --a
	2 => x"73", --s
	3 => x"74", --t
	4 => x"FE", --
	5 => x"46", --F
	6 => x"6F", --o
	7 => x"72", --r
	8 => x"77", --w
	9 => x"61", --a
	10 => x"72", --r
	11 => x"64", --d
	
	
		OTHERS => X"00" 
	); 
	
type BACKWARD_LUT is array (0 to 13) of STD_LOGIC_VECTOR (7 downto 0);
	constant backw: BACKWARD_LUT := (
	0 => x"46", --F
	1 => x"61", --a
	2 => x"73", --s
	3 => x"74", --t
	4 => x"FE", --
	5 => x"42", --B
	6 => x"61", --a
	7 => x"63", --c
	8 => x"6B", --k
	9 => x"77", --w
	10 => x"61", --a
	11 => x"72", --r
	12 => x"64", --d
		OTHERS => X"00" 
	); 	
	
type AUTOMATIC_LUT is array (0 to 9) of STD_LOGIC_VECTOR(7 downto 0);
		constant autolut: AUTOMATIC_LUT := (
		0 => x"41", 	--A
		1 => x"75", 	--u
		2 => x"74", 	--t
		3 => x"6F", 	--o
		4 => x"6D", 	--m
		5 => x"61", 	--a
		6 => x"74", 	--t
		7 => x"69", 	--i
		8 => x"63", 	--c	
		OTHERS => X"00" 
		);
type STOP_LUT is array (0 to 4) of STD_LOGIC_VECTOR(7 downto 0);
		constant stop: STOP_LUT := (
		0 => x"53", 	--S
		1 => x"54", 	--T
		2 => x"4F", 	--O
		3 => x"50", 	--P
		OTHERS => X"00" 
		);		
		
	

type ROM_DISP is array (0 to 25) of STD_LOGIC_VECTOR (7 downto 0);
	signal DISP: ROM_DISP := (	
	
	
		OTHERS => X"FE" 
	);
begin

	process(clk,Mode) 
	
		begin
		
		if(rising_edge(clk)) then
		
		clockCount<=clockCount+1;
		
		
		
		case present_state is
			when T0 =>
		
					autoSig<=AutoFlag;
					modSig<=Mode;
					RW<='0';
					RS<='0';
					
				if(clockCount>=777777) then
					present_state<=T1;
					clockCount<=0;
					else
					present_state<=T0;
					end if;
			
				when T1 => 
					if((clockCount>=0) and (clockCount<12)) then					--12 cycles
					SF_D<=X"3";	E<='1';
					elsif((clockCount>=12) and (clockCount<205012)) then 		--205k cycles
					SF_D<=X"3";	E<='0';
					elsif((clockCount>=205012) and (clockCount<205024)) then	--12 cycles
					SF_D<=X"3";	E<='1';
					elsif((clockCount>=205024) and (clockCount<210024)) then	--5k cycles
					SF_D<=X"3";	E<='0';
					elsif((clockCount>=210024) and (clockCount<210036)) then	--12 cylces
					SF_D<=X"3";	E<='1';
					elsif((clockCount>=210036) and (clockCount<212036)) then	--2k cycles
					SF_D<=X"3";	E<='0';
					elsif((clockCount>=212036) and (clockCount<212048)) then	--12 cycles
					SF_D<=X"2";	E<='1';
					elsif((clockCount>=212048) and (clockCount<250000)) then	--2k++ cycles
					SF_D<=X"2";	E<='0';
					elsif(clockCount>=250000) then	
					present_state<=T2;
					clockCount<=0;
					end if;
			
			when T2 =>	--initialize the lcd 
				-- function set(0x28), 0x0C(display on,disable cursor & blinking), 
				--	0x06(entry mode), 0x01(clear display)
				-- set memory address (0x00)
						RW<='0';	RS<='0';		
						if((clockCount>=0) and (clockCount<12))then
							SF_D<=INST(0+i)(7 downto 4);
							E<='1';
						elsif((clockCount>=12) and (clockCount<2012)) then
							SF_D<=INST(0+i)(7 downto 4);
							E<='0';
						elsif((clockCount>=2012) and (clockCount<2024)) then
							SF_D<=INST(0+i)(3 downto 0);
							E<='1';
						elsif((clockCount>=2024) and (clockCount<100000)) then
							SF_D<=INST(0+i)(3 downto 0);
							E<='0';
						elsif(clockCount>=100000) then	
							clockCount<=0;
							
								if(i=4) then
									i<=0;
										for i in 0 to 24 loop
											DISP(0+i) <= X"FE";
										end loop;	
										
													if(autoSig='1') then
														for i in 0 to 8 loop --automatic
														DISP(0+i) <= autolut(0+i);
														end loop;
													elsif(modSig="001") then --forward
														for i in 0 to 6 loop
														DISP(0+i) <= forw(5+i);
														end loop;
													
													elsif(modSig="010") then	--fast forward
														for i in 0 to 11 loop
														DISP(0+i) <= forw(0+i);
														end loop;
													
													elsif(modSig="011") then	--backward
														for i in 0 to 7 loop
														DISP(0+i) <= backw(5+i);
														end loop;
													
													elsif(modSig="100") then	--fast backward
														for i in 0 to 12 loop
														DISP(0+i) <= backw(0+i);	
														end loop;
														
													elsif(modSig="000") then -- stop
														for i in 0 to 3 loop
														DISP(0+i) <= stop(0+i);
														end loop;	
									
													else	
														
													end if;
											
										i<=0;
										present_state<=T3;
										
								else
								i<=i+1;
								present_state<=T2;
								end if;
							
						end if;
			when T3 =>		 --displaying of data
						RW<='0';	RS<='1';		
						if((clockCount>=0) and (clockCount<12))then
							SF_D<=DISP(0+i)(7 downto 4);
							E<='1';
						elsif((clockCount>=12) and (clockCount<2012)) then
							SF_D<=DISP(0+i)(7 downto 4);
							E<='0';
						elsif((clockCount>=2012) and (clockCount<2024)) then
							SF_D<=DISP(0+i)(3 downto 0);
							E<='1';
						elsif((clockCount>=2024) and (clockCount<100000)) then
							SF_D<=DISP(0+i)(3 downto 0);
							E<='0';
						elsif(clockCount>=100000) then	
							clockCount<=0;
							
								if(i=20) then
								present_state<=T4;
								clockCount<=0;
								i<=0;
								substate<=0;
								else
								i<=i+1;
								present_state<=T3;
								end if;
							
						end if;	
		when T4=>
						RW<='0';	RS<='0';		
						if((substate=0) and (clockCount>10000000)) then
							clockCount<=0;
							substate<=1;
						elsif(substate=1) then
						
							if((clockCount>=0) and (clockCount<12))then
								SF_D<=X"0";
								E<='1';
							elsif((clockCount>=12) and (clockCount<2012)) then
								SF_D<=X"0";
								E<='0';
							elsif((clockCount>=2012) and (clockCount<2024)) then
								SF_D<=X"8";
								E<='1';
							elsif((clockCount>=2024) and (clockCount<20000000)) then
								SF_D<=X"8";
								E<='0';
							elsif(clockCount>=20000000) then	
								clockCount<=0;
							present_state<=T0;
							end if;
				
						end if;			
			when others=>
		end case;	
		end if;
	end process;
	
end Behavioral;

