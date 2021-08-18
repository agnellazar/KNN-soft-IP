library IEEE;
use IEEE.std_logic_1164.all;

library WORK;
use WORK.design_lib.all;
use WORK.COMPONENTS_LIB.all;
entity final_IP_integration_1 is 
	-- generic(INPUT_PORT_NUMBER : NATURAL := 8;	--Number of input features at a time
			-- INPUT_PORT_SIZE   : NATURAL := 8;	--Number of bits in each input p
			-- K 				  : NATURAL :=5		--Number of vectors to be compared in prediction calculation
			-- );
	port( D_VEC_IN,D_STORED_IN : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);				--Input feature vector
		  D_LAB_IN,CLK : IN std_logic;				--Input feature vector's label	
		  PRED_OUT : out std_logic				--Prediction made
	);
end entity final_IP_integration_1;

architecture DATAFLOW of final_IP_integration_1 is
	signal D_VEC_INT,SUB_ARR_INT, SQR_ARR_INT : STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
	signal ADD_VEC_INT : std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
	signal EXCH_VEC_INT: std_logic_vector(K-1 downto 0);
	signal D_LAB_INT,PRED_INT   : std_logic;
	begin
	process(CLK)
		begin
		if(CLK'EVENT and CLK='1')then   		--positive edge, strobe inputs
			D_VEC_INT <= D_VEC_IN;
			D_LAB_INT <= D_LAB_IN;
		end if;
		if (CLK'EVENT and CLK='0')then 			--negative edge, put output
			PRED_OUT <= PRED_INT;
		end if;
	end process;
	SUB_LAYER_INST :  SUBTRACTOR_ARRAY port map(D_VEC_INT,D_STORED_IN,SUB_ARR_INT,CLK);
	SQR_LAYER_INST :  SQUARE_ARRAY     port map(SUB_ARR_INT,SQR_ARR_INT,CLK);
	ADD_LAYER_INST :  M_ADDER 		   port map(SQR_ARR_INT,ADD_VEC_INT,CLK);
	EXCH_LAYER_INST:  EXCH_CHAIN	   port map(ADD_VEC_INT,D_LAB_INT,CLK,open,EXCH_VEC_INT);
	RES_LAYER_INST :  FINAL_RES_CALC   port map(EXCH_VEC_INT,PRED_INT);
end architecture;
	