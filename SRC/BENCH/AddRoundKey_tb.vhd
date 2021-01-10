library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity AddRoundKey_tb is
end entity AddRoundKey_tb;

architecture AddRoundKey_tb_arch of AddRoundKey_tb is
    --component part
    component AddRoundKey is
        port(
            state_i        : in type_state; --tableau 4x4 -> message
            currentkey_i   : in type_state;   --tableau 4x4 -> la clé
            state_o        : out type_state --tableau 4x4 -> message xor clé
        );
    end component;

    --signal part
    signal state_is        : type_state;
    signal currentkey_is   : type_state;
    signal state_os        : type_state;

begin
    --modelisation part
    DUT : AddRoundKey
    port map (
        state_i        => state_is,
        currentkey_i   => currentkey_is,
        state_o        => state_os
    );

    state_is <= ((X"45", X"75", X"6E", X"E8"),
                 (X"73", X"20", X"66", X"65"),
                 (X"2D", X"63", X"69", X"20"),
                 (X"74", X"6F", X"6E", X"3F")
                );

    currentkey_is  <= ((X"2B", X"28", X"AB", X"09"),
                       (X"7E", X"AE", X"F7", X"CF"),
                       (X"15", X"D2", X"15", X"4F"),
                       (X"16", X"A6", X"88", X"3C")
                      );
end architecture AddRoundKey_tb_arch;