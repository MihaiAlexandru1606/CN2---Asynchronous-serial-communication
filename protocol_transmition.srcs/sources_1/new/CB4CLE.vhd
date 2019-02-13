library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity CB4CLE is
    Port (
            D : in std_logic_vector(3 downto 0);
            L : in std_logic;
            CE: in std_logic;
            C : in std_logic;
            CLR : in std_logic;
            Q : out std_logic_vector(3 downto 0);
            CEO : out std_logic;
            TC : out std_logic
           );
end CB4CLE;
    
architecture Behavioral of CB4CLE is

signal Qsave: std_logic_vector(3 downto 0);
signal TCS: std_logic;

signal nrC,new_nrC: std_logic_vector(3 downto 0);
begin
new_nrC <= std_logic_vector(unsigned(nrC) + 1);

    process(C)
    begin
        if (CLR = '1') then
            Qsave <= "0000";
        elsif(C' event and C = '1') then
            if (L = '1' ) then
                --Qsave <= D;
                Q <= D;
            else
                if (CE = '1') then
                   --QSave <= new_nrC;
                    Q <= std_logic_vector(unsigned(Q) + 1);
                end if;
            end if;
        end if;
    end process;
    
    nrC <= Qsave;
    new_nrC <= std_logic_vector(unsigned(nrC) + 1);
    --Q <= Qsave;
    TCS <= and Qsave;
    
    TC <= TCS;
    CEO <= TCS and CE;
    
end Behavioral;
