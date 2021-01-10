library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity SubBytes_tb is
end entity SubBytes_tb;

architecture SubBytes_tb_arch of SubBytes_tb is
    --component part
    component SubBytes is
        port(
            SubBytes_i : in type_state;
            SubBytes_o : out type_state
        );
    end component;

    --signal list to set and display
    signal SubBytes_is : type_state;
    signal SubBytes_os : type_state;

begin
    --modelisation part
    DUT : SubBytes
    port map (
        SubBytes_i => SubBytes_is,
        SubBytes_o => SubBytes_os
    );

    SubBytes_is <= ((X"45", X"75", X"6E", X"E8"),
                    (X"73", X"20", X"66", X"65"),
                    (X"2D", X"63", X"69", X"20"),
                    (X"74", X"6F", X"6E", X"3F")
                   );

end architecture SubBytes_tb_arch;