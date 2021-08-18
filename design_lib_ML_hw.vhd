library IEEE;
use ieee.std_logic_1164.all;

package DESIGN_LIB is
	type STD_ARR is array(natural range <>) of std_logic_vector(7 downto 0);
	--type STD_ARR2 is array(natural range 7 downto 0) of std_logic_vector(15 downto 0);
	type DB is array (natural range <>) of STD_ARR(7 downto 0);
	constant INPUT_PORT_NUMBER : NATURAL := 8;
	constant INPUT_PORT_SIZE   : NATURAL := 8;
	constant K                 : NATURAL := 5;
end package DESIGN_LIB;

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.design_lib.all;

package COMPONENTS_LIB is 
	component SUBTRACTOR_ARRAY IS
	-- GENERIC(INPUT_PORT_NUMBER : INTEGER:= 8;
		    -- input_port_size    : INTEGER:= 8);
		PORT(
			input_bus_a  : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			input_bus_b  : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			output_bus   : OUT STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			CLK          : IN std_logic
			);
	END component SUBTRACTOR_ARRAY;

	component ADDER_ARRAY IS
	-- GENERIC(INPUT_PORT_NUMBER : INTEGER;
		    -- input_port_size    : INTEGER);
		PORT(
			input_bus_a,input_bus_b  : IN STD_ARR(INPUT_PORT_NUMBER -1 downto 0); 
			output_bus   : OUT STD_ARR(INPUT_PORT_NUMBER -1 downto 0)
			);
	END component ADDER_ARRAY;
	
	component SQUARE_ARRAY is 
	-- generic(
		-- INPUT_PORT_NUMBER : NATURAL := 8;
		-- INPUT_PORT_SIZE   : NATURAL := 8
	-- );
		port (
			  A_ARR   : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			  SQR_ARR : out STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			  CLK     : IN std_logic
			 );
	end component SQUARE_ARRAY;
	
	component M_ADDER is
	-- generic( INPUT_PORT_NUMBER : NATURAL := 8;
			 -- INPUT_PORT_SIZE   : NATURAL := 8
			-- );
		port( 
			 M0  : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			 SUM : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
			 CLK :	IN std_logic
			);
	end component M_ADDER;
	
	component EXCH_CHAIN is
	-- generic(INPUT_PORT_SIZE : NATURAL := 8;
			-- K               : NATURAL := 5);
		port( 
			 DIST     : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
			 D_LABEL,CLK  : in std_logic;
		     CLASS_OP,STORED_CLASSES : out std_logic_vector(0 to K-1)
			);
	end component EXCH_CHAIN;
	
	component FINAL_RES_CALC is 
	-- generic(K : NATURAL := 5);
		port(
			 LAB_VEC_IN :in std_logic_vector(K-1 downto 0);
			 PRED_OUT    :out std_logic
			);
	end component FINAL_RES_CALC;
end package COMPONENTS_LIB;