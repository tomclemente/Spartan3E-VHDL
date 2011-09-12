----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:53 09/11/2011 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( dataR1 : in  STD_LOGIC_VECTOR (7 downto 0);
           dataR2 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUMode : in  STD_LOGIC_VECTOR (2 downto 0);
           ALUen : in  STD_LOGIC_VECTOR (2 downto 0);
           Status : out  STD_LOGIC_VECTOR (2 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is

component Adder8 is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           C_in : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           C_out : out  STD_LOGIC);
end component;

component SUBTRACTOR is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Borrow_out : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Multiplier is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component DIVIDER is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Borrow_out : out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Shift is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
			op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			mode	: in  STD_LOGIC_VECTOR (2 downto 0);			  
			output : out  STD_LOGIC_VECTOR (7 downto 0);
			S_out: out STD_LOGIC);	
end component;

component Logic is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           mode : in STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component comparator is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           mode : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component mux7x1_8bits is
    Port ( Input1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input3 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input4 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input5 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input6 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input7 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUEn : in  STD_LOGIC_VECTOR (2 downto 0);
           Output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal addtemp,subtemp,multtemp,divtemp,shiftrottemp,logtemp,comptemp : STD_LOGIC_VECTOR(7 downto 0);
signal carrytempout,borrowtempout, dborrowtempout, shiftrottempout : STD_LOGIC;
signal carrytempin : STD_LOGIC := '0';

begin

ADD: Adder8 PORT MAP(op1 => dataR1,
							op2 => dataR2,
							C_in => carrytempin,
							output => addtemp,
							C_out => carrytempout);

SUBTRACT: SUBTRACTOR PORT MAP(op1 => dataR1,
										op2 => dataR2,
										Borrow_out => borrowtempout,
										output => subtemp);
										
MULTIPLY: Multiplier PORT MAP(op1 => dataR1,
										op2 => dataR2,
										output => multtemp);
										
DIVIDE: DIVIDER PORT MAP(op1 => dataR1,
								 op2 => dataR2,
								 Borrow_out => dborrowtempout,
								 output => divtemp);
								 
SHIFTROT: Shift PORT MAP(op1 => dataR1,
								 op2 => dataR2,
								 mode => ALUMode,
								 output => shiftrottemp,
								 S_out => shiftrottempout);
								 
LOGICGATES: Logic PORT MAP(op1 => dataR1,
									op2 => dataR2,
									mode => ALUMode,
									output => logtemp);
									
COMPARE: comparator PORT MAP(op1 => dataR1,
									  op2 => dataR2,
									  mode => ALUMode,
									  output => comptemp);
									  
MUX: mux7x1_8bits PORT MAP(Input1 => addtemp,
									Input2 => subtemp,
									Input3 => multtemp,
									Input4 => divtemp,
									Input5 => shiftrottemp,
									Input6 => logtemp,
									Input7 => comptemp,
									ALUEn => ALUen,
									Output => dataOut);
									
--Carry Bit(2) ,Overflow Bit(1),  Zero Bit(0)--
Status(0) <= '1' when addtemp = "00000000" and ALUen = "001" else -- if add result is 0
			 '1' when subtemp = "00000000" and ALUen = "010" else -- if subtract result is 0
			 '1' when multtemp = "00000000" and ALUen = "011" else -- if multiply result is 0
			 '1' when divtemp = "00000000" and ALUen = "100" else -- if divide result is 0
			 '1' when logtemp = "00000000" and ALUen = "110" else -- if logic result is 0
			 '1' when comptemp = "00000001" and ALUen = "111" and ALUmode = "110"  else
			 '1' when comptemp = "00000001" and ALUen = "111" and ALUmode = "111"  else
			 '0' when ALUen /= "000";
Status(1) <= '1' when carrytempout = '1' and ALUen = "001" else -- if add has overflow
			 '1' when borrowtempout = '1' and ALUen = "010" else -- if subtract has overflow
			 '1' when dborrowtempout = '1' and ALUen = "100" else -- if divide has overflow
			 '0' when ALUen ="110" else --The overflow flag is cleared for logical operations  
			 '0' when ALUen /= "000";
Status(2) <= '1' when shiftrottempout = '1' and ALUen = "101" else
			 '0' when ALUen ="110" else --The carry flag is cleared for logical operations
			 '0' when ALUen /= "000";
		

end Behavioral;

