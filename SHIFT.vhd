--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package SHIFT is

  
--  type SHIFT is
--    record
--        outdata      : std_logic_vector( 7 downto 0);
----<type_name>        : std_logic;
--    end record;

-- Declare constants
	
  --constant <constant_name>		: time := <time_unit> ns;
  --constant <constant_name>		: integer := <value>;
 
-- Declare functions and procedure


--   function <FUNC_NAME> (
--                         <comma_separated_inputs> : <type>) return <type>;
--			

  --function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
  function SLAF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR;

  function SRLF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR;
 -- procedure SRAP (inputdata: in STD_LOGIC_VECTOR(7 downto 0);
--  procedure SLLP (inputdata: in STD_LOGIC_VECTOR(7 downto 0);
 -- procedure <procedure_name>	(<type_declaration> <constant_name>	: in <type_declaration>);

procedure SLLP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0));

procedure SRAP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0));

end SHIFT;


package body SHIFT is

-- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;
--  
  function SRLF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
	 variable temp : std_logic_vector(7 downto 0);
  begin
	 temp := inputdata;
    
	 for i in 0 to 6 loop
		temp(i+1):=inputdata(i);
	 end loop;
	 
		temp(0):='0';
		return temp;
		
  end SRLF;

	
  function SLAF (signal inputdata: in STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
	 variable temp2 : std_logic_vector(7 downto 0);
  begin
	temp2 := inputdata;
    
	 for i in 7 downto 1 loop
		temp2(i-1):=inputdata(i);
	 end loop;
	 
		temp2(7):=inputdata(0);
		
		return temp2;
  end SLAF;

  
-- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

-- Procedure Example

  

--
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
-- 

--   procedure <PROC_NAME> (<comma_separated_inputs> : in <type>;
--                          <comma_separated_outputs> : out <type>) is
--      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
--   begin
--      -- procedure body
--   end <PROC_NAME>;

	
	procedure SLLP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0)) is
	
	begin
		for i in 7 downto 1 loop
			outputdata(i-1) <= inputdata(i);
		end loop;
		outputdata(7) <= '0';
						
	end SLLP;
	
	
	procedure SRAP(signal inputdata: in STD_LOGIC_VECTOR(7 downto 0);
						signal outputdata: out STD_LOGIC_VECTOR(7 downto 0)) is
	
	begin
		for i in 0 to 6 loop
			outputdata(i+1) <= inputdata(i);
		end loop;
		outputdata(0) <= inputdata(7);
						
	end SRAP;
			

end SHIFT;
