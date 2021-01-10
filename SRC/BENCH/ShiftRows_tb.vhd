library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity ShiftRows_tb is
end entity ShiftRows_tb;

architecture ShiftRows_tb_arch of ShiftRows_tb is
    --component part
    component ShiftRows is
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
    DUT : ShiftRows
    port map (
        state_i => state_is,
        state_o => state_os
    );

    state_is <= ((X"9F", X"D7", X"07", X"AA"),
                 (X"4C", X"19", X"C8", X"DD"),
                 (X"A6", X"81", X"10", X"8E"),
                 (X"F8", X"AC", X"A8", X"7B")
                );

end architecture ShiftRows_tb_arch;