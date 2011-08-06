--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package ROTATE is

  
 function ROLCF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0); signal shiftinput: in STD_LOGIC) return STD_LOGIC_VECTOR;
 
 function RORF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR;

 procedure ROLP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0));

 procedure RORCP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal shiftinput: in STD_LOGIC;
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0));

end ROTATE;


package body ROTATE is

  
 function ROLCF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0); signal shiftinput: in STD_LOGIC) return STD_LOGIC_VECTOR is
	 variable temp2 : std_logic_vector(7 downto 0);
	 variable carry: std_logic;
	 
  begin
	carry := shiftinput;
	temp2 := inputdata;
    
	 for i in 0 to 6 loop
		temp2(i+1):=inputdata(i);
	 end loop;
	 
		temp2(0) := carry;
		carry := temp2(7);
		
		return temp2;
  end ROLCF;


 function RORF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
	 variable temp : std_logic_vector(7 downto 0);
  begin
	 temp := inputdata;
    
	 for i in 7 downto 1 loop
		temp(i-1):=inputdata(i);
	 end loop;
	 
		temp(7):=inputdata(0);
		return temp;
		
  end RORF;

	procedure ROLP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						--signal shiftinput: in STD_LOGIC;
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0)) is
	
	begin
		for i in 0 to 6 loop
			outputdata(i+1) <= inputdata(i);
		end loop;
		outputdata(0) <= inputdata(7);
						
	end ROLP;
	
	procedure RORCP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal shiftinput: in STD_LOGIC;
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0)) is
	variable carry: std_logic;
	--variable temp2: std_logic_vector (7 downto 0);
	begin
		carry := shiftinput;
		
		for i in 7 downto 1 loop
			outputdata(i-1) <= inputdata(i);
		end loop;
		 
		outputdata (7) <= carry;
		carry := inputdata(0);
		
						
	end RORCP;
			
	
	
 
end ROTATE;
