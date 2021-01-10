library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity KeyExpansion_FSM_tb is
end entity KeyExpansion_FSM_tb;

architecture KeyExpansion_FSM_tb_arch of KeyExpansion_FSM_tb is
    --component part
    component KeyExpansion_FSM is
        port(
            count_i     : in bit4;
            start_i     : in std_logic;
            clock_i     : in std_logic;
            resetb_i    : in std_logic;  
            enable_i    : out std_logic;
            resetb_o    : out std_logic
        );
    end component;

    --signal list to set and display
    signal count_is     : bit4;
    signal start_is     : std_logic;
    signal clock_is     : std_logic := '1';
    signal resetb_is    : std_logic;  
    signal enable_is    : std_logic;
    signal resetb_os    : std_logic;

begin
    --modelisation part
    DUT : KeyExpansion_FSM
    port map (
        count_i     => count_is,
        start_i     => start_is,
        clock_i     => clock_is,
        resetb_i    => resetb_is,  
        enable_i    => enable_is,
        resetb_o    => resetb_os
    );

    P0 : process (clock_is) --Clock process
    begin
        clock_is <= not clock_is after 50 ns;
    end process;

count_is  <= X"0", X"1" after 300 ns, X"2" after 400 ns, X"3" after 500 ns,
             X"4" after 600 ns, X"5" after 700 ns, X"6" after 800 ns, X"7" after 900 ns, 
             X"8" after 1000 ns, X"9" after 1100 ns, X"A" after 1200 ns;

resetb_is <= '0', '1' after 100 ns;

start_is  <= '0', '1' after 100 ns, '0' after 200 ns;

end architecture KeyExpansion_FSM_tb_arch;