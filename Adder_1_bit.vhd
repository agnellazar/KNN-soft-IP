library ieee;
use ieee.std_logic_1164.all;

entity FullAdd is port ( 
A, B, Cin: in std_logic; 
Sum, Cout: out std_logic 
); 
end FullAdd;

architecture behavioral of FullAdd is
	begin
	Sum <= Cin xor (A xor B);
	Cout <= (A and B) or (Cin and (A xor B));
end behavioral;