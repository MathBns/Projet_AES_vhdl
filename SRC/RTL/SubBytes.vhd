library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity SubBytes is
    port(
        SubBytes_i : in type_state;
        SubBytes_o : out type_state
    );
end entity SubBytes;
    
architecture SubBytes_arch of SubBytes is
    --component part
    component SBox is
        port(
            SBox_i : in bit8;
            SBox_o : out bit8
        );
    end component;

begin
    --generate arch
    G1 : for i in 0 to 3 generate
        G2 : for j in 0 to 3 generate
            inter : SBox 
                port map (
                    SBox_i => SubBytes_i(i)(j),
                    SBox_o => SubBytes_o(i)(j)
                );
        end generate G2;
    end generate G1;     

end architecture SubBytes_arch;