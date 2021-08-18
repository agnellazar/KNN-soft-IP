library ieee;
use ieee.std_logic_1164.all;
library work;
use work.design_lib.all;

entity m_adder is
	generic( INPUT_PORT_NUMBER : NATURAL := 8;
			 INPUT_PORT_SIZE   : NATURAL := 8
			);
	port( M0  : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
		  SUM : out std_logic_vector(INPUT_PORT_NUMBER-1 downto 0);
		  CLK :	IN std_logic
		);
end entity m_adder;

-- architecture ripple of m_adder is
	-- signal INT_SIG,M0_INT : STD_ARR(INPUT_PORT_SIZE-1 downto 0);
	-- component Adder_8bit is 
		-- generic(BIT_LENGTH: INTEGER :=8);
		-- port (  A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
				-- Cin : in std_logic; 
				-- Sum : out std_logic_vector(BIT_LENGTH-1 downto 0)
			  -- ); 
	-- end component Adder_8bit;
	-- begin
	-- INT_SIG(0) <= M0_INT(0);
	-- ADDER_GEN :
	-- for I in 0 to INPUT_PORT_NUMBER-2 generate
		-- ADDER_INST : Adder_8bit port map(M0_INT(I+1),INT_SIG(I),'0',INT_SIG(I+1));
	-- end generate ADDER_GEN;
	-- SUM <= INT_SIG(INPUT_PORT_NUMBER-1);
	
	-- process(CLK)
	-- begin
		-- if(CLK='0')then
			-- M0_INT <= M0;
		-- end if;
	-- end process;
	-- --ADDER_1 : Adder_8bit port map(INT_SIG(0),M0(2),'0',SUM);
-- end ripple;

architecture tree_adder of m_adder is
	signal M0_INT : STD_ARR(INPUT_PORT_SIZE-1 downto 0);
	signal INT_SIG_L1 :STD_ARR(3 downto 0);
	signal INT_SIG_L2 :STD_ARR(1 downto 0);
	signal INT_SIG_L3 :STD_ARR(0 downto 0);
	component Adder_8bit is 
		generic(BIT_LENGTH: INTEGER :=8);
		port (  A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
				Cin : in std_logic; 
				Sum : out std_logic_vector(BIT_LENGTH-1 downto 0)
			  ); 
	end component Adder_8bit;
	begin
	ADDER_GEN_L1 :
	for I in 0 to 3 generate
		ADDER_INST_L1 : Adder_8bit port map(M0_INT(2*I),M0_INT(2*I+1),'0',INT_SIG_L1(I));
	end generate ADDER_GEN_L1;
	
	ADDER_GEN_L2 :
	for I in 0 to 1 generate
		ADDER_INST_L2 : Adder_8bit port map(INT_SIG_L1(2*I),INT_SIG_L1(2*I+1),'0',INT_SIG_L2(I));
	end generate ADDER_GEN_L2;
	
	ADDER_GEN_L3 :
	for I in 0 to 0 generate
		ADDER_INST_L3 : Adder_8bit port map(INT_SIG_L2(2*I),INT_SIG_L2(2*I+1),'0',INT_SIG_L3(I));
	end generate ADDER_GEN_L3;
	
	SUM <= INT_SIG_L3(0);
	
	process(CLK)
	begin
		if(CLK='0')then
			M0_INT <= M0;
		end if;
	end process;
	--ADDER_1 : Adder_8bit port map(INT_SIG(0),M0(2),'0',SUM);
end tree_adder;
	
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.design_lib.all;
entity m_adder_async is
	generic( INPUT_PORT_NUMBER : NATURAL := 8;
			 INPUT_PORT_SIZE   : NATURAL := 8
			);
	port( M0  : in STD_ARR(INPUT_PORT_NUMBER-1 downto 0);
		  SUM : out std_logic_vector(INPUT_PORT_NUMBER-1 downto 0)
		);
end entity m_adder_async;

-- architecture ripple of m_adder_async is
	-- signal INT_SIG,M0_INT : STD_ARR(INPUT_PORT_SIZE-1 downto 0);
	-- component Adder_8bit is 
		-- generic(BIT_LENGTH: INTEGER :=8);
		-- port (  A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
				-- Cin : in std_logic; 
				-- Sum : out std_logic_vector(BIT_LENGTH-1 downto 0)
			  -- ); 
	-- end component Adder_8bit;
	-- begin
	-- INT_SIG(0) <= M0_INT(0);
	-- ADDER_GEN :
	-- for I in 0 to INPUT_PORT_NUMBER-2 generate
		-- ADDER_INST : Adder_8bit port map(M0_INT(I+1),INT_SIG(I),'0',INT_SIG(I+1));
	-- end generate ADDER_GEN;
	-- SUM <= INT_SIG(INPUT_PORT_NUMBER-1);
	-- M0_INT <= M0;
	-- --ADDER_1 : Adder_8bit port map(INT_SIG(0),M0(2),'0',SUM);
-- end ripple;

architecture tree_adder of m_adder_async is
	signal M0_INT : STD_ARR(INPUT_PORT_SIZE-1 downto 0);
	signal INT_SIG_L1 :STD_ARR(3 downto 0);
	signal INT_SIG_L2 :STD_ARR(1 downto 0);
	signal INT_SIG_L3 :STD_ARR(0 downto 0);
	component Adder_8bit is 
		generic(BIT_LENGTH: INTEGER :=8);
		port (  A,B : in std_logic_vector(BIT_LENGTH-1 downto 0);
				Cin : in std_logic; 
				Sum : out std_logic_vector(BIT_LENGTH-1 downto 0)
			  ); 
	end component Adder_8bit;
	begin
	ADDER_GEN_L1 :
	for I in 0 to 3 generate
		ADDER_INST_L1 : Adder_8bit port map(M0_INT(2*I),M0_INT(2*I+1),'0',INT_SIG_L1(I));
	end generate ADDER_GEN_L1;
	
	ADDER_GEN_L2 :
	for I in 0 to 1 generate
		ADDER_INST_L2 : Adder_8bit port map(INT_SIG_L1(2*I),INT_SIG_L1(2*I+1),'0',INT_SIG_L2(I));
	end generate ADDER_GEN_L2;
	
	ADDER_GEN_L3 :
	for I in 0 to 0 generate
		ADDER_INST_L3 : Adder_8bit port map(INT_SIG_L2(2*I),INT_SIG_L2(2*I+1),'0',INT_SIG_L3(I));
	end generate ADDER_GEN_L3;
	
	SUM <= INT_SIG_L3(0);
	M0_INT <= M0;

end tree_adder;