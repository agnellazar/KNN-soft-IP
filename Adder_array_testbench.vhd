library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.design_lib.all;

entity ADDER_ARRAY_TESTBENCH is
end entity ADDER_ARRAY_TESTBENCH;

architecture TEST of ADDER_ARRAY_TESTBENCH is
	component m_adder is
		generic( INPUT_PORT_NUMBER : NATURAL := 8;
				 INPUT_PORT_SIZE   : NATURAL := 8
				);
		port( M0  : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
			  SUM : out std_logic_vector(7 downto 0)
			);
	end component m_adder;
	signal A : STD_ARR(7 downto 0);
	signal R : std_logic_vector(7 downto 0);
	begin
		A(0) <= "00001100";
		A(1) <= "00001010";
		A(2) <= "00010001";
		A(3) <= "00001100";
		A(4) <= "00001010";
		A(5) <= "00010001";
		A(6) <= "00001100";
		A(7) <= "00001010";
		DUT : m_adder port map(A,R);
	end architecture;