library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.design_lib.all;

entity SQUARE_ENT is 
	generic(INPUT_PORT_NUMBER: NATURAL:= 1;
			INPUT_PORT_SIZE:   NATURAL:= 8 
	);
	
	port( A : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  SQR : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  CLK : in  std_logic 
	);
end entity SQUARE_ENT;

architecture dataflow of SQUARE_ENT is
	signal A_INT:std_logic_vector (INPUT_PORT_SIZE-1 downto 0);
	signal S_AND_INT,S_SHIFT_INT: STD_ARR(INPUT_PORT_SIZE-1 downto 0);-- := (0=>"0",others => "0");
	type TEMP_UNSIGNED_ARR is array (INPUT_PORT_SIZE-1 downto 0) of unsigned (INPUT_PORT_SIZE-1 downto 0);
	signal SH_TEMP1,SH_TEMP2 : TEMP_UNSIGNED_ARR;
	component m_adder_async is
	port( M0  : in STD_ARR(INPUT_PORT_SIZE-1 downto 0);
		  SUM : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0)
		);
	end component m_adder_async;
	begin
		process(A_INT,S_AND_INT,S_SHIFT_INT,SH_TEMP1,SH_TEMP2)
		begin
			for I in  0 to INPUT_PORT_SIZE-1 loop
				BIT_ASSIGNMENT : for J in  0 to INPUT_PORT_SIZE-1 loop
					S_AND_INT(I)(J) <=  A_INT(J) and A_INT(I);
				end loop;
				SH_TEMP1(I) <= unsigned(S_AND_INT(I));
				SH_TEMP2(I) <= SH_TEMP1(I) sll I;
				S_SHIFT_INT(I) <= std_logic_vector(SH_TEMP2(I));
			end loop;
		end process;
		
		process(CLK)
		begin
			if(CLK='0')then
				A_INT<=A;
			end if;
		end process;
		
		MULTIPLICAND_ADDER : m_adder_async port map (S_SHIFT_INT,SQR);
end architecture dataflow;