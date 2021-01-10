library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity SBox_tb is
end entity SBox_tb;

architecture SBox_tb_arch of SBox_tb is
    --component part
    component SBox is
        port(
            SBox_i : in bit8;
            SBox_o : out bit8
        );
    end component;

    --signal list to set and display
        signal SBox_is : bit8;
        signal SBox_os : bit8;

begin
    --modelisation part
    DUT : SBox
    port map (
        SBox_i => SBox_is,
        SBox_o => SBox_os
    );

    SBox_is <= X"01", X"54" after 40 ns, X"B1" after 80 ns, X"FF" after 120 ns, X"98" after 160 ns, X"AE" after 200 ns;

end architecture SBox_tb_arch;