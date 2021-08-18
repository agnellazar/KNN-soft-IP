-- read_file_ex.vhd


library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

library WORK;
use Work.design_lib.all;

entity read_file_ex is
end read_file_ex;

architecture tb of read_file_ex is
	component final_IP_integration_1 is
		port( D_VEC_IN,D_STORED_IN : IN STD_ARR(INPUT_PORT_NUMBER-1 downto 0);				--Input feature vector
			  D_LAB_IN,CLK : IN std_logic;				--Input feature vector's label	
			  PRED_OUT : out std_logic				--Prediction made
		);
	end component final_IP_integration_1;

	--signal DB_SAM : DB(M downto 0);
	--signal DB_LAB : std_logic_vector(M downto 0);
	signal VEC_IN,DB_SAM_IN : STD_ARR(7 downto 0);
	signal DB_LAB_IN : std_logic;
	signal PRED: std_logic;
	signal CLK: STD_LOGIC:='0';
    file input_buf : text;  -- text is keyword
	
	begin
		DUT_INST : final_IP_integration_1 port map(VEC_IN, DB_SAM_IN ,DB_LAB_IN, CLK, PRED);
		CLK <= not(CLK) after 50ps;
tb1 : process
    variable read_col_from_input_buf : line; -- read lines one by one from input_buf

    --variable val_col1, val_col2 : std_logic; -- to save col1 and col2 values of 1 bit
    variable val1,val2,val3,val4,val5,val6,val7,val8: std_logic_vector(7 downto 0); -- to save col3 value of 2 bit
    variable val_COMMA : character;  -- for spaces between data in file
	variable val9 : std_logic;

    begin
		VEC_IN <= ("11111110","00000000","11111111","11111110","11111110","11111110","11111101","00000000");
        -- if modelsim-project is created, then provide the relative path of 
        -- input-file (i.e. read_file_ex.txt) with respect to main project folder
        file_open(input_buf, "pima_norm.txt",  read_mode); 
        -- else provide the complete path for the input file as show below 
        -- file_open(input_buf, "E:/VHDLCodes/input_output_files/read_file_ex.txt", read_mode); 

        while not endfile(input_buf) loop
          readline(input_buf, read_col_from_input_buf);
          read(read_col_from_input_buf, val1);
          read(read_col_from_input_buf, val_COMMA);           -- read in the space character

          read(read_col_from_input_buf, val2);
          read(read_col_from_input_buf, val_COMMA); 
          read(read_col_from_input_buf, val3);
          read(read_col_from_input_buf, val_COMMA); 
          read(read_col_from_input_buf, val4);
          read(read_col_from_input_buf, val_COMMA); 
		  
		  
          read(read_col_from_input_buf, val5);
          read(read_col_from_input_buf, val_COMMA); 
          read(read_col_from_input_buf, val6);
          read(read_col_from_input_buf, val_COMMA); 
          read(read_col_from_input_buf, val7);
          read(read_col_from_input_buf, val_COMMA); 
          read(read_col_from_input_buf, val8);
          read(read_col_from_input_buf, val_COMMA); 
		  read(read_col_from_input_buf, val9);
		  report "val9 value is" & std_logic'image(val9);
          -- Pass the read values to signals
        --  a <= val1;
        --  b <= val2;
        --  c <= val3;
		--  d <= val4;
		--  e <= val5;
		--  f <= val6;
		--  g <= val7;
		--  h <= val8;
		
		  DB_SAM_IN(0) <= val1;
          DB_SAM_IN(1) <= val2;
          DB_SAM_IN(2) <= val3;
		  DB_SAM_IN(3) <= val4;
		  DB_SAM_IN(4) <= val5;
		  DB_SAM_IN(5) <= val6;
		  DB_SAM_IN(6) <= val7;
		  DB_SAM_IN(7) <= val8;
		  DB_LAB_IN <= val9;
          wait for 100 ps;  --  to display results for 20 ns
        end loop;

        file_close(input_buf);             
        wait;
    end process;
end tb ; -- tb