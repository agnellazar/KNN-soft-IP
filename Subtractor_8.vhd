
library ieee;
use ieee.std_logic_1164.all;

entity FullSub8 is 
	generic(BIT_LENGTH: INTEGER :=8);
	port ( 
		A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
		Diff : out std_logic_vector(BIT_LENGTH-1 downto 0);
		Borr: out std_logic 
); 
end FullSub8;

architecture behavioral of FullSub8 is
	COMPONENT FullAdd PORT(
		A, B, Cin: in std_logic; 
		Sum, Cout: out std_logic 
		); 
	end COMPONENT;
	signal Borr_int: std_logic_vector(BIT_LENGTH downto 0);		--BIT_LENGTH +1 size to accomodate Borrow in and Borrow out
	Signal S1 : std_logic_vector(BIT_LENGTH-1 downto 0); 
	
	--Signal A,B : std_logic_vector(BIT_LENGTH-1 downto 0); 
	
	begin
		Borr_int(0) <= '1';
		S1 <=not (B);
		Adder_generator:
		for I in 0 to BIT_length-1 generate
			Add_1_bit_inst: FullAdd port map(
			A(I),S1(I),Borr_int(I),Diff(I),Borr_int(I+1));
		end generate Adder_generator;
	Borr <= not(Borr_int(BIT_LENGTH));
end behavioral;
	
	
	
	
	
	
	--Diff(1) <= Borr_int(0) xor (A(1) xor B_t(1));
	--Borr_int(1) <= (A(1) and B_t(1)) or (Borr_int(0) and (A(1) xor B_t(1)));
	
	--Diff(2) <= Borr_int(1) xor (A(2) xor B_t(2));
	--Borr_int(2) <= (A(2) and B_t(2)) or (Borr_int(1) and (A(2) xor B_t(2)));
	
	--Diff(3) <= Borr_int(2) xor (A(3) xor B_t(3));
	--Borr_int(3) <= (A(3) and B_t(3)) or (Borr_int(2) and (A(3) xor B_t(3)));
	
	--Diff(4) <= Borr_int(3) xor (A(4) xor B_t(4));
	--Borr_int(4) <= (A(4) and B_t(4)) or (Borr_int(3) and (A(4) xor B_t(4)));
	
	--Diff(5) <= Borr_int(4) xor (A(5) xor B_t(5));
	--Borr_int(5) <= (A(5) and B_t(5)) or (Borr_int(4) and (A(5) xor B_t(5)));
	
	--Diff(6) <= Borr_int(5) xor (A(6) xor B_t(6));
	--Borr_int(6) <= (A(6) and B_t(6)) or (Borr_int(5) and (A(6) xor B_t(6)));
	
	--Diff(7) <= Borr_int(6) xor (A(7) xor B_t(7));
	--Borr_int(7) <= (A(7) and B_t(7)) or (Borr_int(6) and (A(7) xor B_t(7)));
	
	--Borr <= Borr_int(7);
