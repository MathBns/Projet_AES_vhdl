library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity MixColumns is
    port(
        state_i : in type_state;
        state_o : out type_state
    );
end entity MixColumns;
    
architecture MixColumns_arch of MixColumns is
    --compenment part
    component MultiMat is
        port(
            column_i : in  column_state;
            column_o : out column_state
        );
    end component;

    --signal part
    signal column0_is : column_state;
    signal column1_is : column_state;
    signal column2_is : column_state;
    signal column3_is : column_state;
    signal column0_os : column_state;
    signal column1_os : column_state;
    signal column2_os : column_state;
    signal column3_os : column_state;

begin
    --generate arch
    --TRAITEMENT COLONNE 1
    C0_i : for i in 0 to 3 generate
        column0_is(i) <= state_i(i)(0);
    end generate C0_i;
   C0 : MultiMat
   port map (
        column_i => column0_is,
        column_o => column0_os
    );
    C0_s : for i in 0 to 3 generate
        state_o(i)(0) <= column0_os(i);
    end generate C0_s;

    --TRAITEMENT COLONNE 2
    C1_i : for i in 0 to 3 generate
        column1_is(i) <= state_i(i)(1);
    end generate C1_i;
    C1 : MultiMat
    port map (
        column_i => column1_is,
        column_o => column1_os
    );
    C1_s : for i in 0 to 3 generate
        state_o(i)(1) <= column1_os(i);
    end generate C1_s;

    --TRAITEMENT COLONNE 3
    C2_i : for i in 0 to 3 generate
        column2_is(i) <= state_i(i)(2);
    end generate C2_i;
   C2 : MultiMat
   port map (
        column_i => column2_is,
        column_o => column2_os
    );
    C2_s : for i in 0 to 3 generate
        state_o(i)(2) <= column2_os(i);
    end generate C2_s;

    --TRAITEMENT COLONNE4
    C3_i : for i in 0 to 3 generate
        column3_is(i) <= state_i(i)(3);
    end generate C3_i;
    C3 : MultiMat
    port map (
        column_i => column3_is,
        column_o => column3_os
    );
    C3_s : for i in 0 to 3 generate
        state_o(i)(3) <= column3_os(i);
    end generate C3_s;

end architecture MixColumns_arch;