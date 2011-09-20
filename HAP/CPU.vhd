----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:23:46 09/19/2011 
-- Design Name: 
-- Module Name:    CPU - Structural 
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

entity CPU is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           instIn : in  STD_LOGIC_VECTOR (15 downto 0);
           mux2in : in  STD_LOGIC_VECTOR (7 downto 0);
           dataR1GPR : out  STD_LOGIC_VECTOR (7 downto 0);
           memOutPC : out  STD_LOGIC_VECTOR (7 downto 0);
           memOutIR : out  STD_LOGIC_VECTOR (7 downto 0);
           ROMen : out  STD_LOGIC;
           RWen : out  STD_LOGIC;
           RRen : out  STD_LOGIC);
end CPU;

architecture Structural of CPU is
component CU is
    Port ( Opcode : in  STD_LOGIC_VECTOR (4 downto 0);
           Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
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
           Mux2sel : out  STD_LOGIC_VECTOR (1 downto 0);
			  Status: in STD_LOGIC_VECTOR(2 downto 0));
end component;

component ALU is
    Port ( dataR1 : in  STD_LOGIC_VECTOR (7 downto 0);
           dataR2 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUMode : in  STD_LOGIC_VECTOR (2 downto 0);
           ALUen : in  STD_LOGIC_VECTOR (2 downto 0);
			  Status : out  STD_LOGIC_VECTOR (2 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component IR is
    Port ( instIn : in  STD_LOGIC_VECTOR (15 downto 0);
			  IRen : in STD_LOGIC;
			  Clock : in STD_LOGIC;
			  Opcode : out STD_LOGIC_VECTOR(4 downto 0);
			  RD : out STD_LOGIC_VECTOR(2 downto 0);
			  R1 : out STD_LOGIC_VECTOR(2 downto 0);
			  R2 : out STD_LOGIC_VECTOR(2 downto 0);
			  memOut : out STD_LOGIC_VECTOR(7 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component PC is
    Port ( memIn : in  STD_LOGIC_VECTOR (7 downto 0);
			  PCen : in  STD_LOGIC;
           PCLen : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Clock : in STD_LOGIC;
           memOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component MUX1 is
    Port ( r1in : in  STD_LOGIC_VECTOR (7 downto 0);
			  r2in : in  STD_LOGIC_VECTOR (7 downto 0);
           irIn : in  STD_LOGIC_VECTOR (7 downto 0);
           mux1sel : in  STD_LOGIC_VECTOR (1 downto 0);
           memOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component MUX2 is
    Port ( irOut : in  STD_LOGIC_VECTOR (7 downto 0);
           ramOut : in  STD_LOGIC_VECTOR (7 downto 0);
           aluOut : in  STD_LOGIC_VECTOR (7 downto 0);
           mux2sel : in  STD_LOGIC_VECTOR (1 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component GPR is
    Port ( DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           RD: in  STD_LOGIC_VECTOR (2 downto 0);
           R1 : in  STD_LOGIC_VECTOR (2 downto 0);
           R2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Read_en : in  STD_LOGIC;
			  Write_en: in STD_LOGIC;
			  Reset: in STD_LOGIC;
           dataR1 : out  STD_LOGIC_VECTOR (7 downto 0);
           dataR2: out  STD_LOGIC_VECTOR (7 downto 0));
end component;
	
	signal ir_opcode : STD_LOGIC_VECTOR(4 downto 0);
	signal cu_resetOut, cu_PCen, cu_PCLen, cu_ROMen, cu_IRen, cu_GPRRen, cu_GPRWen,
				cu_RWen, cu_RRen : STD_LOGIC;
	signal alu_statusOut,cu_ALUmode, ir_RD, ir_R1, ir_R2, cu_ALUen : STD_LOGIC_VECTOR(2 downto 0);
	signal gpr_dataR1, gpr_dataR2, alu_dataOut, ir_memOut, ir_dataOut, mux1_dataOut, mux2_dataOut, pc_memOut : STD_LOGIC_VECTOR(7 downto 0);
	signal cu_mux2sel, cu_mux1sel : STD_LOGIC_VECTOR(1 downto 0);
	
begin
	
	A: CU port map(ir_opcode, Clock, Reset, cu_resetOut, cu_ALUen, cu_ALUmode, cu_PCen, cu_PCLen, cu_ROMen, cu_IRen,  
						cu_GPRRen, cu_GPRWen, cu_RWen, cu_RRen, cu_mux1sel, cu_mux2sel, alu_statusOut);
	B: ALU port map(gpr_dataR1, gpr_dataR2, cu_ALUmode, cu_ALUen, alu_statusOut, alu_dataOut);
	C: IR port map(instIn, cu_IRen, Clock, ir_opcode, ir_RD, ir_R1, ir_R2, ir_memOut, ir_dataOut);
	D: PC port map(mux1_dataOut, cu_PCen, cu_PCLen, Reset, Clock, pc_memOut);
	E: MUX1 port map(gpr_dataR1, gpr_dataR2, ir_memOut, cu_mux1sel, mux1_dataOut);
	F: MUX2 port map(ir_dataOut, mux2in, alu_dataOut, cu_mux2sel, mux2_dataOut);
	G: GPR port map(mux2_dataOut, ir_RD, ir_R1, ir_R2, cu_GPRRen, cu_GPRWen, cu_resetOut, gpr_dataR1, gpr_dataR2);
	ROMen <= cu_ROMen;
	RWen <= cu_RWen;
	RRen <= cu_RRen;
	memOutPC <= pc_memOut;
	dataR1GPR <= gpr_dataR1;
	memOutIR <= ir_memOut;
end Structural;

