library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity AddRoundKey is
    port(
        state_i        : in  type_state; --tableau 4x4 -> message
        currentkey_i   : in  type_state; --tableau 4x4 -> la clé
        state_o        : out type_state --tableau 4x4 -> message xor clé
    );
end entity AddRoundKey;
    
architecture AddRoundKey_arch of AddRoundKey is

begin
    --generate arch
    G1 : for i in 0 to 3 generate
        G2 : for j in 0 to 3 generate
            state_o(i)(j) <= state_i(i)(j) xor currentkey_i(i)(j);
        end generate G2;
    end generate G1;     

end architecture AddRoundKey_arch;