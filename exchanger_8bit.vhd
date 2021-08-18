-- library IEEE;
-- use IEEE.std_logic_1164.all;

-- entity comp_sync is 
	-- generic(INPUT_PORT_SIZE :NATURAL := 8);
	-- port ( A,B : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		   -- CLK : in std_logic;
		   -- SEL : out std_logic	
	-- );
-- end entity comp_sync;

-- architecture BEHAVIOURAL of COMP_SYNC is
	-- signal A_HOLD,B_HOLD : std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
	
	-- component comp_array is
	-- port( A_ARR,B_ARR : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 -- A_G,E,B_G : out std_logic	
		-- );
	-- end component COMP_ARRAY;
	-- begin
		-- COMP_INST : COMP_ARRAY port map(A_HOLD,B_HOLD,open,open,SEL);
		-- process(CLK)
		-- begin
			-- if(CLK'EVENT and CLK='1') then
				-- A_HOLD <= A;
				-- B_HOLD <= B;
			-- end if;
		-- end process;
-- end architecture BEHAVIOURAL;

-- library IEEE;
-- use IEEE.std_logic_1164.all;
-- entity EXCH_SYNC is
	-- generic(INPUT_PORT_SIZE : NATURAL :=8);
	-- port (D_IN : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		  -- SEL,CLK : in std_logic;
		  -- EXCH_OUT_VEC,D_PREV :out std_logic_vector(INPUT_PORT_SIZE-1 downto 0)
		  -- --EXCH_OUT_LAB, STR_OUT_LAB : std_logic
		-- );
-- end entity EXCH_SYNC;	
-- architecture BEHAVIOURAL of EXCH_SYNC is
	-- signal D_STR, D_STR_TEMP : std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
	-- begin
	-- process(CLK)
	-- begin
		-- if(CLK'EVENT and CLK='0') then
			-- if(SEL='1') then
				-- EXCH_OUT_VEC <= D_STR;
				-- D_STR <= D_IN;
			-- else
				-- EXCH_OUT_VEC <= D_IN;
			-- end if;
		-- end if;
	-- end process;
	-- D_PREV <= D_STR;
-- end architecture BEHAVIOURAL;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity EXCH_2 is
	generic(INPUT_PORT_SIZE : NATURAL := 8);
	port(D_VEC_IN : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 D_LAB_IN,CLK : in std_logic;
		 D_VEC_OUT  : out std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 D_LAB_OUT,D_STR_OUT : out std_logic
	);
end entity EXCH_2;

architecture MIXED of EXCH_2 is
	component comp_array is
	port( A_ARR,B_ARR : in std_logic_vector(INPUT_PORT_SIZE-1 downto 0);
		 A_G,E,B_G : out std_logic	
		);
	end component COMP_ARRAY;
	
	signal COMP_A,COMP_B,MUX_VEC_OUT,MUX_VEC_STR,STR_D_VEC,D_VEC_OUT_TEMP : std_logic_vector(INPUT_PORT_SIZE-1 downto 0):=(0=>'1',others=>'1');
	-- signal STR_D_VEC : std_logic_vector(INPUT_PORT_SIZE-1 downto 0):=(0=>'1',others=>'1');
	signal SEL,STR_D_LAB,COMP_A_LAB,COMP_B_LAB,MUX_LAB_OUT,MUX_LAB_STR,D_LAB_OUT_TEMP : std_logic:='0';
	begin
		COMP_INST : COMP_ARRAY port map(COMP_A,COMP_B,open,open,SEL);
		MUX : process(SEL,COMP_A,COMP_B,COMP_A_LAB,COMP_B_LAB)
		begin
			if(SEL='1') then
				MUX_VEC_OUT <= COMP_B;
				MUX_VEC_STR <= COMP_A;
				MUX_LAB_OUT <= COMP_B_LAB;
				MUX_LAB_STR <= COMP_A_LAB;
			else
				MUX_VEC_OUT <= COMP_A;
				MUX_VEC_STR <= COMP_B;
				MUX_LAB_OUT <= COMP_A_LAB;
				MUX_LAB_STR <= COMP_B_LAB;
			end if;
		end process;
		
		CLK_POS : process(CLK,COMP_A,COMP_A_LAB,COMP_B,COMP_B_LAB,D_VEC_IN,D_LAB_IN,STR_D_VEC,STR_D_LAB,
						  MUX_VEC_OUT,MUX_LAB_OUT,MUX_VEC_STR,MUX_LAB_STR,D_VEC_OUT_TEMP,D_LAB_OUT_TEMP)
		begin
			if (CLK'EVENT and CLK='1')then --positive edge
				COMP_A     <= D_VEC_IN;
				COMP_A_LAB <= D_LAB_IN;
				COMP_B     <= STR_D_VEC;
				COMP_B_LAB <= STR_D_LAB;
			end if;
			if (CLK'EVENT and CLK='0')then --negative edge
				D_VEC_OUT_TEMP <= MUX_VEC_OUT;
				D_LAB_OUT_TEMP <= MUX_LAB_OUT;
				STR_D_VEC <= MUX_VEC_STR;
				STR_D_LAB <= MUX_LAB_STR;
			end if;
		end process;
		D_STR_OUT <= STR_D_LAB;
		D_VEC_OUT <= D_VEC_OUT_TEMP;
		D_LAB_OUT <= D_LAB_OUT_TEMP;
end architecture MIXED; 