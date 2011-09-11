----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:03:31 08/29/2011 
-- Design Name: 
-- Module Name:    HAP - Behavioral 
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

entity HAP is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end HAP;

architecture Behavioral of HAP is

component CU is
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

component RAM is
    Port ( dataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           memIn : in  STD_LOGIC_VECTOR(7 downto 0);
			  Clock : in STD_LOGIC;
           RRen : in  STD_LOGIC;
           RWen : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROM is
    Port ( memIn : in  STD_LOGIC_VECTOR (7 downto 0);
           instOut : out  STD_LOGIC_VECTOR (15 downto 0);
           ROMen : in  STD_LOGIC);
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
signal rom_instOut : STD_LOGIC_VECTOR (15 downto 0);
signal  cu_Mux1sel, cu_Mux2sel : STD_LOGIC_VECTOR(1 downto 0);
signal mux1_memOut, pc_memOut, ir_memOut, ir_dataOut, ram_dataOut,
		 gpr_dataR1, gpr_dataR2, mux2_dataOut, alu_dataOut: STD_LOGIC_VECTOR(7 downto 0);
signal cu_ALUEn, cu_ALUMode, ir_RD, ir_R1, ir_R2, alu_statusOut, cu_statusOut: STD_LOGIC_VECTOR(2 downto 0);
signal cu_PCen, cu_GPRREn, cu_GPRWen, cu_PCLen, cu_Reset, 
cu_RomEn, cu_RWen, cu_RRen,cu_IREn: STD_LOGIC;

begin

		A: CU port map(ir_opcode, Clock, Reset, alu_dataOut, cu_Reset, cu_ALUEn, cu_ALUMode, cu_PCen,
							cu_PCLen, cu_RomEn, cu_IREn, cu_GPRREn, cu_GPRWen, cu_RWen, cu_RRen, cu_Mux1sel, cu_Mux2sel,alu_statusOut);	
		B:	IR port map(rom_instOut, cu_IRen, Clock, ir_opcode, ir_RD, ir_R1, ir_R2, ir_memOut, ir_dataOut);
		C: ROM port map(pc_memOut, rom_instOut, cu_RomEn);
		D: PC port map(mux1_memOut, cu_PCen, cu_PCLen, cu_Reset, Clock, pc_memOut);
		E: RAM port map(gpr_dataR1, ir_memOut, Clock, cu_RRen, cu_RWen, ram_dataOut);
		F: MUX2 port map(ir_dataOut, ram_dataOut, alu_dataOut, cu_Mux2sel, mux2_dataOut);
		G: ALU port map(gpr_dataR1, gpr_dataR2, cu_ALUMode, cu_ALUEn, alu_statusOut, alu_dataOut);
		H: MUX1 port map(gpr_dataR1, gpr_dataR2, ir_memOut, cu_Mux1sel, mux1_memOut);
		I: GPR port map(mux2_dataOut, ir_RD, ir_R1, ir_R2, cu_GPRREn, cu_GPRWen, cu_Reset, gpr_dataR1, gpr_dataR2);
end Behavioral;

