library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;

entity MultiMat is
    port(
        column_i : in  column_state;
        column_o : out column_state
    );
end entity MultiMat;
    
architecture MultiMat_arch of MultiMat is
    --declarative part
    signal s01_s :  bit8;  signal s02_s :  bit8;  signal s03_s :  bit8;
    signal s11_s :  bit8;  signal s12_s :  bit8;  signal s13_s :  bit8;
    signal s21_s :  bit8;  signal s22_s :  bit8;  signal s23_s :  bit8;
    signal s31_s :  bit8;  signal s32_s :  bit8;  signal s33_s :  bit8;

begin
    --structural part
    s01_s <= column_i(0);
    s02_s <= column_i(0)(6 downto 0) & '0' when column_i(0)(7) = '0' else column_i(0)(6 downto 0) & '0' xor X"1B";
    s03_s <= s01_s xor s02_s;

    s11_s <= column_i(1);
    s12_s <= column_i(1)(6 downto 0) & '0' when column_i(1)(7) = '0' else column_i(1)(6 downto 0) & '0' xor X"1B";
    s13_s <= s11_s xor s12_s;

    s21_s <= column_i(2);
    s22_s <= column_i(2)(6 downto 0) & '0' when column_i(2)(7) = '0' else column_i(2)(6 downto 0) & '0' xor X"1B";
    s23_s <= s21_s xor s22_s;

    s31_s <= column_i(3);
    s32_s <= column_i(3)(6 downto 0) & '0' when column_i(3)(7) = '0' else column_i(3)(6 downto 0) & '0' xor X"1B";
    s33_s <= s31_s xor s32_s;

    column_o(0) <= s02_s xor s13_s xor s21_s xor s31_s;
    column_o(1) <= s01_s xor s12_s xor s23_s xor s31_s;
    column_o(2) <= s01_s xor s11_s xor s22_s xor s33_s;
    column_o(3) <= s03_s xor s11_s xor s21_s xor s32_s;

end architecture MultiMat_arch;