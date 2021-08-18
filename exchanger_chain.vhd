library IEEE;
use IEEE.std_logic_1164.all;

library WORK;
use WORK.design_lib.all;

entity EXCH_CHAIN is
	generic(INPUT_PORT_SIZE : NATURAL := 8;
			K               : NATURAL := 5);
	port( DIST     : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  D_LABEL,CLK  : in std_logic;
		  CLASS_OP,STORED_CLASSES : out std_logic_vector(0 to K-1)
		);
end entity EXCH_CHAIN;

architecture DATAFLOW of EXCH_CHAIN is
	component EXCH_2 is
	port(D_VEC_IN : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 D_LAB_IN,CLK : in std_logic;
		 D_VEC_OUT  : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 D_LAB_OUT,D_STR_OUT : out std_logic
	);
	end component EXCH_2;
	
	signal D_INT :  STD_ARR (0 to K);
	signal LABEL_INT : std_logic_vector(0 to K);
	begin
	D_INT(0) <= DIST;
	LABEL_INT(0) <= D_LABEL;
	EXCH_GEN :
	for I in 0 to K-1 generate
		EXCH_INST : EXCH_2 port map(D_INT(I),LABEL_INT(I),CLK,
											D_INT(I+1),LABEL_INT(I+1),STORED_CLASSES(I));
	end generate EXCH_GEN;
	CLASS_OP <= LABEL_INT(0 to K-1);
	end architecture DATAFLOW;
	
