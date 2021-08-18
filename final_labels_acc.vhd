library IEEE;
use IEEE.std_logic_1164.all;

entity FINAL_RES_CALC is 
	generic(K : NATURAL := 5);
	port(LAB_VEC_IN :in std_logic_vector(K-1 downto 0);
		PRED_OUT    :out std_logic
		--COUNT_OUT   :out INTEGER
	);
end entity FINAL_RES_CALC;

architecture BEHAVIOURAL of FINAL_RES_CALC is 
	begin
	process(LAB_VEC_IN)
	variable COUNT : INTEGER := 0;
	begin
		COUNT:=0;
		for I in 0 to K-1 loop
			if(LAB_VEC_IN(I)='1')then
				COUNT:=COUNT+1;
			end if;
		end loop;
		--COUNT_OUT <= COUNT;
		if (COUNT<=K/2) then
			PRED_OUT <= '0';
		else 
			PRED_OUT <= '1';
		end if;
	end process;
end architecture BEHAVIOURAL;
		