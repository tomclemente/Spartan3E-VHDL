----------------------------------------------------------------------------------
-- Engineer: GROUP
-- Module Name:    HAP - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HAP is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end HAP;

architecture Structural of HAP is
	component CPU is
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

signal rom_instOut : STD_LOGIC_VECTOR(15 downto 0);
signal ram_dataOut, cpu_dataR1GPR, cpu_memOutPC, cpu_memOutIR : STD_LOGIC_VECTOR(7 downto 0);
signal cpu_ROMen, cpu_RWen, cpu_RRen : STD_LOGIC;



begin

	A: CPU port map(Clock, Reset, rom_instOut, ram_dataOut, cpu_dataR1GPR, cpu_memOutPC, cpu_memOutIR, cpu_ROMen, cpu_RWen, cpu_RRen);
	B: ROM port map(cpu_memOutPC, rom_instOut, cpu_ROMen );
	C: RAM port map(cpu_dataR1GPR, cpu_memOutIR, Clock, cpu_RRen, cpu_RWen, ram_dataOut);
	
end Structural;