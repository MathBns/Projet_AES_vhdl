library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity KeyExpansion_I_O_tb is
end entity KeyExpansion_I_O_tb;

architecture KeyExpansion_I_O_tb_arch of KeyExpansion_I_O_tb is
    --component part
    component KeyExpansion_I_O is
        port(
            key_i		    : in	bit128;
            clock_i	        : in	std_logic;
            resetb_i	    : in    std_logic;
            start_i	        : in    std_logic;
            expansion_key_o : out   bit128
        );
    end component;

    --signal list to set and display
    signal key_is		    : bit128;
    signal clock_is	        : std_logic := '0';
    signal resetb_is	    : std_logic;
    signal start_is	        : std_logic;
    signal expansion_key_os : bit128;

begin
    --modelisation part
    DUT : KeyExpansion_I_O
    port map (
        key_i		    => key_is,
        clock_i	        => clock_is,
        resetb_i	    => resetb_is,
        start_i	        => start_is,
        expansion_key_o => expansion_key_os
    );

    P0 : process (clock_is) --Clock process
    begin
        clock_is <= not clock_is after 50 ns;
    end process;

key_is    <= X"2B7E151628AED2A6ABF7158809CF4F3C";

resetb_is <= '0', '1' after 10 ns;

start_is  <= '1';

end architecture KeyExpansion_I_O_tb_arch;