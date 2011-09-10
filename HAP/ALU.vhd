----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ryan Danielle Redula, Janine Potian, Therese Romero, Simon Buri
-- 
-- Create Date:    22:34:20 08/28/2011 
-- Design Name: 
-- Module Name:    ALU - Structural 
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
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Structural of ALU is

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
           Borrow_in : in  STD_LOGIC;
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
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component SHIFT is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
			 op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			 mode	: in  STD_LOGIC_VECTOR (2 downto 0);			  
			 output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component LOGIC is
	Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
          op2 : in  STD_LOGIC_VECTOR (7 downto 0);
          mode : in STD_LOGIC_VECTOR (2 downto 0);
          output : out  STD_LOGIC_VECTOR (7 downto 0));	  
end component;

component Comparator is
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

signal addtemp,subtemp,multtemp,divtemp,shftrottemp,logtemp,comptemp : STD_LOGIC_VECTOR(7 downto 0);
signal carrytempout,borrowtempout : STD_LOGIC;
signal carrytempin,borrowtempin : STD_LOGIC := '0';

begin

ADD: Adder8 PORT MAP(op1 => dataR1,
						   op2 => dataR2,
							C_in => carrytempin,
							output => addtemp,
							C_out => carrytempout);
		  
SUBTRACT: SUBTRACTOR PORT MAP(op1 => dataR1,
										 op2 => dataR2,
										 Borrow_in => borrowtempin,
										 Borrow_out => borrowtempout,
										 output => subtemp);
											
MULTIPLY: Multiplier PORT MAP(op1 => dataR1,
										op2 => dataR2,
										output => multtemp);
										
DIVIDE: DIVIDER PORT MAP(op1 => dataR1,
								 op2 => dataR2,
								 output => divtemp);

SHFTROT: SHIFT PORT MAP(op1 => dataR1,
						      op2 => dataR2,
								mode => ALUMode,
								output => shftrottemp);
								
LOGICGATES: LOGIC PORT MAP(op1 => dataR1,
								   op2 => dataR2,
									mode => ALUMode,
									output => logtemp);
					
COMPARE: COMPARATOR PORT MAP(op1 => dataR1,
									  op2 => dataR2,
									  mode => ALUMode,
									  output => comptemp);

MUX: Mux7x1_8bits PORT MAP(Input1 => addtemp,
									Input2 => subtemp,
									Input3 => multtemp,
									Input4 => divtemp,
									Input5 => shftrottemp,
									Input6 => logtemp,
									Input7 => comptemp,
									ALUEn => ALUEn,
									Output => dataOut);

end Structural;

