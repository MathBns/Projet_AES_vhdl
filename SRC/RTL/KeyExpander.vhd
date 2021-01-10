library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.crypt_pack.all;

entity KeyExpander is
    port(
        currentKey_i  : in bit128;
        keyExpander_o : out bit128;
        rcon_i        : in bit8
    );
end entity KeyExpander;

architecture KeyExpander_arch of KeyExpander is
    type state is array(0 to 3) of column_state;

    component SBox is
        port(
            Sbox_i : in bit8;
            Sbox_o : out bit8
        );
    end component;
    
    signal wi_s : state;
    signal wo_s : state;
    signal wrotword_s : column_state;
    signal wsubword_s : column_state;
    signal rcon_s : column_state;

    begin
        --Rcon application
        rcon_s(0) <= rcon_i;
        rcon_s(1) <= X"00";
        rcon_s(2) <= X"00";
        rcon_s(3) <= X"00"; 

        --Transformation in type_state
        U0 : for i in 0 to 3 generate
            U01 : for j in 0 to 3 generate
                wi_s(i)(j) <= currentKey_i(127 - 32*i - 8*j  downto  120 - 32*i - 8*j);
            end generate;
        end generate;

        --Rotation
        U1 : for i in 0 to 3 generate
            wrotword_s(i) <= wi_s(3)((i+1) mod 4);
        end generate;

        --SubBytes application        
        U2 : for i in 0 to 3 generate
            U2x : SBox 
            port map (wrotword_s(i), wsubword_s(i));
        end generate;

        --Rcon application
        wo_s(0) <= wi_s(0) xor wsubword_s xor rcon_s;


        U3 : for i in 1 to 3 generate
            wo_s(i) <= wo_s(i-1) xor wi_s(i);
        end generate;

        --Définition of keyExpansion in 128bits
        U4 : for i in 0 to 3 generate
            U5 : for j in 0 to 3 generate
                keyExpander_o(127 - 32*i - 8*j  downto  120 - 32*i - 8*j) <= wo_s(i)(j);
            end generate U5;
        end generate U4;
        
    end architecture KeyExpander_arch;