LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
library work;
use work.design_lib.all;


--type array_stream is array (0 TO 7) of std_logic_vector(7 downto 0);
--type word is array (0 TO 31) of bit;

ENTITY Adder_array IS
	GENERIC(input_ports_number : INTEGER;
		    input_port_size    : INTEGER);
	PORT(
	input_bus_a,input_bus_b  : IN STD_ARR(input_ports_number -1 downto 0); 
	--STD_LOGIC_VECTOR((input_ports_number*input_port_size)-1 DOWNTO 0);
	output_bus   : OUT STD_ARR(input_ports_number -1 downto 0)
	);
END;


ARCHITECTURE dataflow OF Adder_array IS 
COMPONENT Adder_8bit PORT(
	A,B : IN std_logic_vector(input_port_size DOWNTO 0);
	Cin : IN std_logic; 
	Sum : OUT std_logic_vector(input_port_size DOWNTO 0)
); 
END COMPONENT;
BEGIN
	GEN_adder_array: 
	FOR i IN input_ports_number-1 DOWNTO 0 GENERATE
		Adder_inst: Adder_8bit PORT MAP (
		input_bus_a(i),
		input_bus_b(i), '0',
		output_bus(i)
		);  
	END GENERATE GEN_adder_array;
END dataflow;