
library ieee;
use ieee.std_logic_1164.all;
--library work;
--use work.design_lib.all;

entity Adder_8bit is 
	generic(BIT_LENGTH: INTEGER :=8);
	port ( 
	A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
	Cin : in std_logic; 
	Sum : out std_logic_vector(BIT_LENGTH-1 downto 0)
	); 
end Adder_8bit;

architecture behavioral of Adder_8bit is
	COMPONENT FullAdd PORT(
		A, B, Cin: in std_logic; 
		Sum, Cout: out std_logic 
		); 
	end COMPONENT;
	signal Cout_int: std_logic_vector(BIT_LENGTH downto 0);		--BIT_LENGTH +1 size to accomodate Cin in and Cou out
	begin
		Cout_int(0) <= Cin;
		Adder_generator:
		for I in 0 to BIT_length-1 generate
			Add_1_bit_inst: FullAdd port map(
			A(I),B(I),Cout_int(I),Sum(I),Cout_int(I+1));
		end generate Adder_generator;
		--Sum(BIT_LENGTH)<=	Cout_int(BIT_LENGTH);
end behavioral;