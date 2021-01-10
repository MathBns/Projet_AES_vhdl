library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL; 
library PACKAGES;
use PACKAGES.Crypt_Pack.ALL;
library RTL; --using for the configuration

entity KeyExpansion_I_O is
    port(
        key_i		    : in	bit128;
	    clock_i	        : in	std_logic;
	    resetb_i	    : in    std_logic;
	    start_i	        : in    std_logic;
        expansion_key_o : out   bit128
    );
end entity KeyExpansion_I_O;

architecture KeyExpansion_I_O_arch of KeyExpansion_I_O is
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

    component Counter is
        port (
            reset_i     : in std_logic;
            enable_i    : in std_logic;
            clock_i     : in std_logic;
            count_o     : out bit4
        );
    end component;
    
    component KeyExpander is
        port(
            currentKey_i  : in bit128;
            keyExpander_o : out bit128;
            rcon_i        : in bit8
        );
    end component;

    --signal part
    signal keyState_s       : bit128;
    signal keyExpander_s    : bit128;
    signal enable_s         : std_logic;
    signal resetb_s         : std_logic;
    signal count_s          : bit4;
    signal rcon_is          : bit8;
    signal reg_s            : bit128;

begin
    --multilexeur de sortie
    keyState_s <= key_i when count_s = X"0" else reg_s;
    expansion_key_o <= keyState_s;

    --rcon instance / conversion of count_s
    rcon_is <= Rcon(to_integer(unsigned(count_s)));

    --counter instance
    UCounter : Counter
    port map (
        reset_i  => resetb_s,
        enable_i => enable_s,
        clock_i  => clock_i,
        count_o  => count_s
    );

    --FSM instance
    UFSM : KeyExpansion_FSM
    port map(
        count_i  => count_s, 
        start_i  => start_i,
        clock_i  => clock_i,
        resetb_i => resetb_i,    
        enable_i => enable_s,
        resetb_o => resetb_s
    );

    --keyExpander instance
    UKeyExp : KeyExpander
    port map(
        currentKey_i  => keyState_s,
        rcon_i        => rcon_is,
        keyExpander_o => keyExpander_s
    );
    
    --register instance
    P0 : process(resetb_i, clock_i, enable_s, keyExpander_s)
    begin  
        if (resetb_i = '0') then
            reg_s <= (others => '0');
        elsif (clock_i 'event and clock_i ='1') then
            reg_s <= keyExpander_s;
        end if;
    end process P0;

end architecture KeyExpansion_I_O_arch;

--configuration KeyExpansion_I_O
configuration KeyExpansion_I_O_conf of KeyExpansion_I_O is
    for KeyExpansion_I_O_arch
        for UCounter : Counter
        use entity RTL.Counter(Counter_arch);
        end for;
        for UFSM : KeyExpansion_FSM
            use entity RTL.KeyExpansion_FSM(KeyExpansion_FSM_Moore_arch);
        end for;
        for UKeyExp : KeyExpander
            use entity RTL.KeyExpander(KeyExpander_arch);
        end for;
    end for;
  end configuration KeyExpansion_I_O_conf;