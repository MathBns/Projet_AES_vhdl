library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity MixColumns_tb is
end entity MixColumns_tb;

architecture MixColumns_tb_arch of MixColumns_tb is
    --component part
    component MixColumns is
        port(
            state_i : in type_state;
            state_o : out type_state
        );
    end component;

    --signal list to set and display
    signal state_is : type_state;
    signal state_os : type_state;

begin
    --modelisation part
    DUT : MixColumns
    port map (
        state_i => state_is,
        state_o => state_os
    );

    state_is <= ((X"9F", X"4C", X"A6", X"F8"),
                 (X"19", X"81", X"AC", X"D7"),
                 (X"10", X"A8", X"07", X"C8"),
                 (X"7B", X"AA", X"DD", X"8E")
                );

end architecture MixColumns_tb_arch;