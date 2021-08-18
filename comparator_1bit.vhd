library IEEE;
use IEEE.STD_LOGIC_1164.all;

library WORK;
use WORK.design_lib.all;

entity comp_1_bit is
	port(A,B,H : in std_logic;
		A_G,E,B_G : out std_logic
		);
end entity comp_1_bit;

architecture dataflow of comp_1_bit is	
	begin
		A_G <=H and ( A and not(B));
		B_G <=H and (B and not(A));
		E  	<=H and (not(A xor B));
end architecture dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;
library WORK;
use WORK.design_lib.all;
	
entity comp_array is
	generic(INPUT_PORT_SIZE : NATURAL := 8);
	port( A_ARR,B_ARR : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 A_G,E,B_G : out std_logic	
		);
end entity comp_array;

architecture dataflow of comp_array is
	component comp_1_bit is
		port(A,B,H : in std_logic;
			A_G,E,B_G : out std_logic
			);
	end component comp_1_bit;
	signal H_INT : std_logic_vector(INPUT_PORT_SIZE downto 0);
	signal A_INT,B_INT : std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
	begin
		H_INT(INPUT_PORT_SIZE)<='1';
		COMPARATOR_GEN:
		for I in INPUT_PORT_SIZE-1 downto 0 generate
			COMP_INST : comp_1_bit port map(A_ARR(I),B_ARR(I),H_INT(I+1),
											A_INT(I),H_INT(I),B_INT(I));
		end generate COMPARATOR_GEN;
		A_G <= or_reduce(A_INT);
		B_G <= or_reduce(B_INT);
		E   <= H_INT(0);
end architecture dataflow;