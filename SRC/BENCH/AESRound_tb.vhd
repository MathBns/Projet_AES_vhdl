library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity AESRound_tb is
end entity AESRound_tb;

architecture AESRound_tb_arch of AESRound_tb is
    --component part
    component AESRound is
        port(
            text_i                  : in  bit128;
            currentkey_i            : in  bit128;
            data_o                  : out bit128;
            clock_i                 : in  std_logic;
            enableMixcolumns_i      : in  std_logic;
            enableRoundcomputing_i  : in  std_logic;
            resetb_i                : in  std_logic
        );
    end component;

    --signal list to set and display
    signal text_is                  : bit128;
    signal currentkey_is            : bit128;
    signal data_os                  : bit128;
    signal clock_is                 : std_logic;
    signal enableMixcolumns_is      : std_logic;
    signal enableRoundcomputing_is  : std_logic;
    signal resetb_is                : std_logic;

begin
    --modelisation part
    DUT : AESRound
    port map (
        text_i                  => text_is,
        currentkey_i            => currentkey_is,
        data_o                  => data_os,
        clock_i                 => clock_is,
        enableMixcolumns_i      => enableMixcolumns_is,
        enableRoundcomputing_i  => enableRoundcomputing_is,
        resetb_i                => resetb_is
    );

text_is <= X"45732D747520636F6E66696EE865203F";

currentkey_is <= X"2B7E151628AED2A6ABF7158809CF4F3C",
                 X"a0fafe1788542cb123a339392a6c7605" after 350 ns;

clock_is <= '0', '1' after 50 ns, '0' after 100 ns, '1' after 150 ns, '0' after 200 ns, '1' after 250 ns, '0' after 300 ns, '1' after 350 ns, '0' after 400 ns, '1' after 450 ns, '0' after 500 ns;

resetb_is <= '0', '1' after 10 ns;

enableMixcolumns_is <= '1';

enableRoundcomputing_is <= '0', '1' after 350 ns;

end architecture AESRound_tb_arch;