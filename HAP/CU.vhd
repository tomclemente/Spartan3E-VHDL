----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ronah Bengil & Tom Clemente
-- 
-- Create Date:    16:29:22 08/27/2011 
-- Design Name: 
-- Module Name:    CU - Behavioral 
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

entity CU is
    Port ( Opcode : in  STD_LOGIC_VECTOR (4 downto 0);
           Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  branchOut : in STD_LOGIC_VECTOR (7 downto 0);
           ResetOut : out  STD_LOGIC;
           ALUen : out  STD_LOGIC_VECTOR(2 downto 0);
           ALUMode : out  STD_LOGIC_VECTOR(2 downto 0);
           PCen : out  STD_LOGIC;
           PCLen : out  STD_LOGIC;
           ROMen : out  STD_LOGIC;
           IRen : out  STD_LOGIC;
           GPRRen : out  STD_LOGIC;
           GPRWen : out  STD_LOGIC;
           RWen : out  STD_LOGIC;
           RRen : out  STD_LOGIC;
           Mux1sel : out  STD_LOGIC_VECTOR (1 downto 0);
           Mux2sel : out  STD_LOGIC_VECTOR (1 downto 0));
end CU;

architecture Behavioral of CU is

type states is (fetch,decode,branchexecute,execute,store);
signal present_state, next_state: states;
signal opcodesig: STD_LOGIC_VECTOR (4 downto 0);
signal operand1, operand2: STD_LOGIC_VECTOR(2 downto 0);

begin

process(Reset,Clock)
begin
	if (Reset = '1') then
		present_state<=fetch;
		ResetOut <= '1';
	elsif rising_edge(Clock) then
		present_state <= next_state;
		ResetOut <= '0';
	end if;
end process;

process(present_state,Opcode,branchOut,Clock)
begin
case present_state is
		
		---FETCH STATE---	disables everything except PC, IR and ROM
			when fetch =>
				
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '1';
								IRen <= '1';
								GPRRen <= '0';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "00";
								Mux2sel <= "00";
								
								opcodesig <= Opcode;
								next_state <= decode;
								
		---DECODE STATE--- for non-branch & non-load instructions, muxes are disabled, data is read from GPR
			when decode =>	PCen <= '0';
				
				---SHIFT, LOGIC, ADD, SUB, COMPARE, MULT, DIV---
				if((opcodesig >= "00000") and (opcodesig < "10011")) then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "00"; --disable Mux1
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				---BNE, BE--- data is read from GPR, MMMM MMMM from IR is set to Mux1
				elsif((opcodesig = "10011") or (opcodesig = "10100")) then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "01"; --get memory MMMM MMMM from IR to load for PC
								Mux2sel <= "00"; --disable Mux2
								next_state <= branchexecute; 
				---BNER, BER--- 
				elsif((opcodesig = "10101") or (opcodesig = "10110")) then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "11"; --dataR2
								Mux2sel <= "00"; --disable Mux2
								next_state <= branchexecute; 
				---J---
				elsif(opcodesig = "10111") then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '1'; --tom
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "01"; --get memory MMMM MMMM from IR to load for PC
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				---JR---
				elsif(opcodesig = "11000") then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "10"; --dataR1
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				---LI---data is read from GPR, IIII IIII from IR is set to Mux2
				elsif(opcodesig = "11001") then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '0';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0';
								Mux1sel <= "00"; --disable Mux1
								Mux2sel <= "01"; --get immediate from IR to GPR
								next_state <= execute;
				---LD---data is read from GPR, MMMM MMMM from RAM is set to Mux2
				elsif(opcodesig = "11010") then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '0';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '1'; --read RAM
								Mux1sel <= "00"; --disable Mux1
								Mux2sel <= "10"; --get MMMM MMMM from RAM to GPR
								next_state <= execute;
				---STORE---
				elsif(opcodesig = "11011") then
								ALUen <= "000";
								PCen <= '0';
								PCLen <= '0';
								ROMen <= '0';
								IRen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '0';
								RRen <= '0'; --read RAM
								Mux1sel <= "00"; --disable Mux1
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				end if;
		---BRANCHEXECUTE STATE---
			when branchexecute =>
				
				---BNE---
				if(opcodesig = "10011") then
								ALUen <= "111";
								ALUMode <= "111";
								Mux1sel <= "01"; --get memory MMMM MMMM from IR to load for PC
								Mux2sel <= "10"; --disable Mux2
								next_state <= execute;
				---BE---
				elsif(opcodesig = "10100") then
								ALUen <= "111";
								ALUMode <= "110";
								Mux1sel <= "01"; --get memory MMMM MMMM from IR to load for PC
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				---BNER--- 
				elsif(opcodesig = "10101") then
								ALUen <= "111";
								ALUMode <= "111";
								Mux1sel <= "11"; --dataR2
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
				---BER--- 
				elsif(opcodesig = "10110") then
								ALUen <= "111";
								ALUMode <= "110";
								Mux1sel <= "11"; --dataR2
								Mux2sel <= "00"; --disable Mux2
								next_state <= execute;
	
				end if;
		---EXECUTE STATE---	
			when execute =>
				---SRL, SRA, SL, ROL, ROR---
				if(opcodesig < "00101") then
					ALUen <= "101";
					ALUMode <= opcodesig(2 downto 0);
					PCen <= '0';
					PCLen <= '0';
					Mux2sel <= "11"; --enable input from ALU output
					next_state <= store;
				---AND, OR, NOT, XOR---
				elsif(opcodesig < "01001") then
					ALUen <= "110";
					ALUMode <= (opcodesig(2 downto 0) - "101");
					PCen <= '0';
					PCLen <= '0';
					Mux2sel <= "11";
					next_state <= store;
				---ADD, SUB---
				elsif(opcodesig < "01011") then
					ALUen <= opcodesig(2 downto 0);
					PCen <= '0';
					PCLen <= '0';
					Mux2sel <= "11";
					next_state <= store;
				---LT, GT, EQ, GTE, LTE, NE---
				elsif(opcodesig < "10001") then
					ALUen <= "111";
					ALUMode <= (opcodesig(2 downto 0) - "011");
					PCen <= '0';
					PCLen <= '0';
					Mux2sel <= "11";
					next_state <= store;
				---MULT, DIV---
				elsif(opcodesig < "10011") then
					ALUen <= (opcodesig(2 downto 0) + "10");
					PCen <= '0';
					PCLen <= '0';
					Mux2sel <= "11";
					next_state <= store;
				---BNE, BE, BNER, BER, J, JR---
				elsif(opcodesig < "11001") then
				
					
					case branchOut is
						when "00000001" =>
							PCLen <= '1';
							PCen	<= '0';
--						when "00000000" =>
--							PCen <= '1';
--							PCLen <= '0';
						when others =>
							PCen <= '0';
							PCLen <= '0';
					end case;
						
					next_state <= store;--tom
							
				---LI, 
				elsif(opcodesig ="11010") then
					PCen <= '0';
					next_state <= store;
					GPRRen <= '0';
					GPRWen <= '1';
					Mux2sel <= "01";
				---LD
				elsif(opcodesig = "11001") then
					PCen <= '0';
					next_state <= store;
					GPRRen <= '0';
					GPRWen <= '0';
					Mux2sel <= "10";
					
				---STORE---
				elsif(opcodesig = "11011") then
								PCen <= '0';
								GPRRen <= '1';
								GPRWen <= '0';
								RWen <= '1';
								RRen <= '0'; --read RAM
								Mux1sel <= "00"; --disable Mux1
								Mux2sel <= "00"; --disable Mux2
								next_state <= store;
				end if;
		---STORE STATE---
			when store =>
				PCen <= '1';
			
				--store
				if(opcodesig = "11011") then
					RWen <= '0';
					RRen <= '0';
					GPRRen <= '0';
					GPRWen <= '0';
					Mux2sel <= "01"; --disable Mux2
					--JR
				elsif(opcodesig="11000") then
						PCLen <= '1';
						PCen <= '0';
					
				
				--LI
				elsif(opcodesig = "11001") then
				
					GPRRen <= '0';
					GPRWen <= '1';
					Mux2sel <= "01";
				--Jump
				elsif(opcodesig ="10111") then
					PCen <='0';
					GPRWen <='0';
					GPRRen <= '0';
					Mux2sel <= "11";
				--load
				elsif(opcodesig="11010") then
					GPRWen <='1';
					GPRRen <= '0';
					Mux2sel <= "10";
					
				
				elsif((opcodesig<="10010") and (opcodesig>="00000")) then
					GPRWen <='1';
					GPRRen <= '0';
					Mux2sel <= "11";
				else
					GPRWen <='0';
					GPRRen <= '0';
					
				end if;
				
					next_state <= fetch;
			end case;	
		
end process;

end Behavioral;

