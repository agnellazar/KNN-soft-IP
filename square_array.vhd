library IEEE;
use IEEE.std_logic_1164.all;

library WORK;
use WORK.design_lib.all;

entity square_array is 
	generic(
		INPUT_PORT_NUMBER : NATURAL := 8;
		INPUT_PORT_SIZE   : NATURAL := 8
	);
	port (A_ARR : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
		  SQR_ARR : out STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
		  CLK : in  std_logic 
		  );
end entity square_array;

architecture dataflow of square_array is
	component SQUARE_ENT is 
		--generic(INPUT_PORT_NUMBER,INPUT_PORT_SIZE);
		port(
		  A : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  SQR : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  CLK : in  std_logic 
		  );
	end component SQUARE_ENT;
	begin
		SQUARE_I_GEN:
		for I in 0 to INPUT_PORT_NUMBER-1 generate
			SQR_ENT:SQUARE_ENT port map(A_ARR(I),SQR_ARR(I),CLK);
		end generate SQUARE_I_GEN;
end architecture dataflow;

	