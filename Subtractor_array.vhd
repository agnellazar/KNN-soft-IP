
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
use work.design_lib.all;
--type array_stream is array (0 TO 7) of std_logic_vector(7 downto 0);
--type word is array (0 TO 31) of bit;

ENTITY Subtractor_array IS
	GENERIC(INPUT_PORT_NUMBER : INTEGER:= 8;
		    input_port_size    : INTEGER:= 8);
	PORT(
	input_bus_a  : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
	input_bus_b  : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
	output_bus   : OUT STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
	CLK          : IN std_logic
	);
END;


ARCHITECTURE structural OF Subtractor_array IS 
	COMPONENT FullSub8 PORT(
		A,B : in std_logic_vector(7 downto 0);
		Diff : out std_logic_vector(7 downto 0);
		Borr: out std_logic 
	); 
	END COMPONENT;
	signal INPUT_BUS_A_INT, INPUT_BUS_B_INT,output_bus_int : STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
BEGIN
	GEN_subtractor_array: 
	FOR i IN INPUT_PORT_NUMBER-1 DOWNTO 0 GENERATE
		Subtractor_inst: FullSub8 PORT MAP (
		input_bus_a_INT(i),input_bus_b_INT(i),output_bus (i),open );  
	END GENERATE GEN_subtractor_array;
	process(CLK)
	begin
		--if (CLK'EVENT)
			if(CLK='1')then   --positive edge
				INPUT_BUS_A_INT <= input_bus_a;
				INPUT_BUS_B_INT <= input_bus_b;
			end if;
		--end if;
	end process;
END structural;