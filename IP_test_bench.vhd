library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library WORK;
use Work.design_lib.all;

entity IP_TB is 
	generic(M : natural := 3);
	port (CLK : in std_logic);
end entity IP_TB;

architecture BEHAVIOURAL2 of IP_TB is
	component final_IP_integration_1 is
		port( D_VEC_IN,D_STORED_IN : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);				--Input feature vector
			  D_LAB_IN,CLK : IN std_logic;				--Input feature vector's label	
			  PRED_OUT : out std_logic				--Prediction made
		);
	end component final_IP_integration_1;

	signal DB_SAM : DB(M-1 downto 0);
	signal DB_LAB : std_logic_vector(M-1 downto 0);
	signal VEC_IN,DB_SAM_IN : STD_ARR(7 downto 0);
	signal DB_LAB_IN : std_logic;
	signal PRED: std_logic;
	
	begin
	DB_SAM <= ( ("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000"),
			("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000"),
			("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000"));
	DB_LAB <= "111";
	VEC_IN <= ("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");
	
	DUT_INST : final_IP_integration_1 port map(VEC_IN, DB_SAM_IN ,DB_LAB_IN, CLK, PRED);
	process(CLK,DB_SAM_IN,DB_LAB_IN)
	variable COUNT : NATURAL := M-1;
	begin
		if CLK'event and CLK='1' then
			report "CLK event and CLK=1";
			DB_SAM_IN <= DB_SAM(COUNT);
			DB_LAB_IN <= DB_LAB(COUNT);
			COUNT:=COUNT-1;
			if COUNT=0 then
				report "COUNT=0";
				COUNT:=M-1;
			end if;
		end if;
		
	end process;
end architecture BEHAVIOURAL2;