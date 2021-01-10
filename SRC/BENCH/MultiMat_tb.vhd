library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library RTL;
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity MultiMat_tb is
end entity MultiMat_tb;

architecture MultiMat_tb_arch of MultiMat_tb is
    --component part
    component MultiMat is
        port(
            column_i : in  column_state;
            column_o : out column_state
        );
    end component;

    --signal list to set and display
    signal column_is : column_state;
    signal column_os : column_state;

begin
    --modelisation part
    DUT : MultiMat
    port map (
        column_i => column_is,
        column_o => column_os
    );

    column_is <= (X"9F", X"19", X"10", X"7B");

end architecture MultiMat_tb_arch;