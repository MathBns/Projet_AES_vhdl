library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;
library RTL; --using for the configuration 

entity AESRound is
    port(
        text_i                  : in  bit128;
        currentkey_i            : in  bit128;
        data_o                  : out bit128;
        clock_i                 : in  std_logic;
        enableMixcolumns_i      : in  std_logic;
        enableRoundcomputing_i  : in  std_logic;
        resetb_i                : in  std_logic
    );

end entity AESRound;
    
architecture AESRound_arch of AESRound is
     --compenment part
    component SubBytes is
        port(
            SubBytes_i : in  type_state;
            SubBytes_o : out type_state
        );
    end component;

    component ShiftRows is
        port(
            state_i : in type_state;
            state_o : out type_state
        );
    end component;

    component MixColumns is
        port(
            state_i  : in  type_state;
            state_o  : out type_state
        );
    end component;

    component AddRoundKey is
        port(
            currentkey_i   : in  type_state;
            state_i        : in  type_state;
            state_o        : out type_state
        );
    end component;

    --signal part
    signal data_s : type_state; --data de sortie
    signal text_state_is, currentkey_state_is : type_state; -- signaux pour la conversion de 128 bits -> type_state
    signal multiplex_s, inter_s, subBytes_s, shiftRows_s, mixColumns_s, interMixColumns_s, addRoundKey_s : type_state; --signaux de sorties des blocs

begin
    --conversion in part
    CONV1 : for col in 0 to 3 generate
        CONV2 : for row in 0 to 3 generate
            text_state_is(row)(col) <= text_i(127 - 32 * col - 8 * row downto 120 - 32 * col - 8 * row);
            currentkey_state_is(row)(col) <= currentkey_i(127 - 32 * col - 8 * row downto 120 - 32 * col - 8 * row);
        end generate CONV2;
    end generate CONV1;

    --multiplexeur enableRoundComputing
    multiplex_s <= text_state_is when enableRoundComputing_i = '0' else mixColumns_s;

    --multiplexeur enableMuxColumns
    mixColumns_s <= shiftRows_s when enableMixColumns_i = '0' else interMixColumns_s;
 
    --addRoundKey instance
    PAddRoundKey : AddRoundKey 
    port map (
        currentkey_i => currentkey_state_is,
        state_i      => multiplex_s,
        state_o      => addRoundKey_s
    );

    --register instance
    PRegister : process (clock_i, resetb_i)
    begin --process PRegister
        if resetb_i = '0' then --reset : renvoie NULL
            data_s <=  ((X"00", X"00", X"00", X"00"),
                        (X"00", X"00", X"00", X"00"),
                        (X"00", X"00", X"00", X"00"),
                        (X"00", X"00", X"00", X"00")
                       );
        elsif clock_i 'event and clock_i = '1' then
            inter_s <= addRoundKey_s;
            data_s  <= addRoundKey_s;
        end if;
    end process PRegister;

    --subBytes instance
    PSubBytes : SubBytes 
    port map (
        SubBytes_i => inter_s,
        SubBytes_o => subBytes_s
    );    

    --shiftRows intance
    PShiftRows : ShiftRows
    port map(
        state_i => subBytes_s,
        state_o => shiftRows_s
    );

    --mixColumns instance
    PMC : MixColumns 
    port map (
        state_i => shiftRows_s,
        state_o => interMixColumns_s --stockage
    );

    --conversion out part
    CONV3 : for col in 0 to 3 generate
        CONV4 : for row in 0 to 3 generate
             data_o(127 - 32 * col - 8 * row downto 120 - 32 * col - 8 * row) <= data_s(row)(col);   
        end generate CONV4;
    end generate CONV3;

end architecture AESRound_arch;

-- Configuration de l'aesround.
configuration AESRound_conf of AESRound is
    for AESRound_arch
        for PAddRoundKey : AddRoundKey 
            use entity RTL.AddRoundKey(AddRoundKey_arch);
        end for;
        for PSubBytes : SubBytes 
            use entity RTL.SubBytes(SubBytes_arch);
        end for;
        for PShiftRows : ShiftRows
            use entity RTL.ShiftRows(ShiftRows_arch);
        end for;
        for PMC : MixColumns
            use entity RTL.MixColumns(MixColumns_arch);
        end for;
    end for;
  end configuration AESRound_conf;