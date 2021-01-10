library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity ShiftRows is
    port(
        state_i : in type_state;
        state_o : out type_state
    );
end entity ShiftRows;
    
architecture ShiftRows_arch of ShiftRows is

begin
    --generate arch
    G1 : for i in 0 to 3 generate
        G2 : for j in 0 to 3 generate
            state_o(i)(j) <= state_i(i)((j+i) MOD 4);
        end generate;
    end generate;

end architecture ShiftRows_arch;