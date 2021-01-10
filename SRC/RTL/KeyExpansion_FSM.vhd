library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.crypt_pack.all;

entity KeyExpansion_FSM is
    port(
        count_i     : in bit4;
        start_i     : in std_logic;
        clock_i     : in std_logic;
        resetb_i    : in std_logic;  
        enable_i    : out std_logic;
        resetb_o    : out std_logic
    );
end entity KeyExpansion_FSM;

architecture KeyExpansion_FSM_Moore_arch of KeyExpansion_FSM is
    --signal part
    type type_state is (init, count, done);
    signal pstate, nstate : type_state;

begin

    --init
    sequentiel : process(clock_i, resetb_i)
    begin
        if resetb_i = '0' then
            pstate <= init;
        elsif clock_i 'event and clock_i = '1' then
            pstate <= nstate;
        end if;
    end process;

    --Process d'état
    P0 : process(pstate, start_i, count_i)
    begin
        case pstate is
        when init=>
            if start_i = '0' then --premier round
                nstate <= init;
            else
                nstate <= count;
            end if;
        when count =>   
            if count_i = "1001" then --jusqu'au 9ème round
                nstate <= done;
            else 
                nstate <= count;        
        end if;
        when done =>
            if start_i='1' then --dernier round
                nstate <= init;
            else
                nstate <= done;
            end if;
        when others =>
            nstate <= init;
        end case;
    end process P0;


    --Combinaison Process
    P1 : process(pstate)
    begin
        case pstate is
            when init =>
                enable_i <= '0';
                resetb_o <= '0';
            when count =>
                enable_i <= '1';
                resetb_o <= '1';
            when done =>
                enable_i <= '0';
                resetb_o <= '1';
        end case;
    end process;

end architecture KeyExpansion_FSM_Moore_arch;