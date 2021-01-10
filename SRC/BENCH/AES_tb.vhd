library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;
library RTL;
use RTL.all;

entity AES_tb is
end entity AES_tb;
  
architecture AES_tb_arch of AES_tb is
    --component part
    component AES is
        port(
            clock_i	: in  std_logic;
            reset_i	: in  std_logic;
            start_i	: in  std_logic;
            key_i	: in  bit128;
            data_i	: in  bit128;
            data_o	: out bit128;
            aes_on_o : out std_logic
        );
        end component AES;

    --signal part
    signal clock_is  : std_logic := '0';
    signal reset_is	 : std_logic := '0';
    signal start_is	 : std_logic := '0';
    signal key_is	 : bit128;
    signal data_is	 : bit128;
    signal data_os	 : bit128;
    signal aes_on_os : std_logic := '0';

begin
    DUT : AES
    port map (
        clock_i	 => clock_is,
        reset_i	 => reset_is,
        start_i	 => start_is,
        key_i	 => key_is,
        data_i	 => data_is,
        data_o	 => data_os,
        aes_on_o => aes_on_os
    );

    P0 : process
    begin
        data_is <= X"45732d747520636f6e66696ee865203f";
        key_is  <= X"2b7e151628aed2a6abf7158809cf4f3c";
        wait;
    end process;

    P1 : process --Reset process
    begin
        reset_is <= '1';
        wait for 10 ns;
        reset_is <= '0';
        wait;
    end process;

    P2 : process --Start process
    begin
        start_is <= '0';
        wait for 100 ns;
        start_is <= '1';
        wait for 120 ns;
        start_is <= '0';
        wait for 3000 ns;
        start_is <= '1';
        wait for 120 ns;
        start_is <= '0';
        wait for 3000 ns;
        start_is <= '1';
        wait for 120 ns;
    end process;

    P3 : process --Clock process
    begin
        wait for 50 ns;
        clock_is <= not clock_is;
    end process;

end architecture AES_tb_arch;