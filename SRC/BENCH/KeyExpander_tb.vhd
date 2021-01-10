library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity KeyExpander_tb is
end entity KeyExpander_tb;

architecture KeyExpander_tb_arch of KeyExpander_tb is
    --component part
    component KeyExpander is
        port(
            currentKey_i  : in  bit128;
            keyExpander_o : out bit128;
            rcon_i        : in  bit8
        );
    end component;

    --signal list to set and display
    signal currentKey_is  : bit128;
    signal keyExpander_os : bit128;
    signal rcon_is        : bit8;

begin
    --modelisation part
    DUT : KeyExpander
    port map (
        currentKey_i  => currentKey_is,
        keyExpander_o => keyExpander_os,
        rcon_i        => rcon_is
    );

currentKey_is <= X"2B7E151628AED2A6ABF7158809CF4F3C";

rcon_is       <= X"01";

end architecture KeyExpander_tb_arch;