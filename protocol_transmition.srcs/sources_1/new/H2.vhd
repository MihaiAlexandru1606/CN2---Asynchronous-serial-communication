library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity H2 is
    Port (
            START : in std_logic;
            RXRDY : in std_logic;
            RESET : in std_logic;
            NUM12 : in std_logic;
            DREQ : in std_logic;
            CEAS : in std_logic;
            TXRDY : out std_logic;
            RDY : out std_logic;
            INCARCA : out std_logic;
            DEPL : out std_logic;
            DDISP : out std_logic
          );
end H2;

architecture Behavioral of H2 is

    type state_type is (S0, S1, S2, S3, S4, S5);
    signal state : state_type := S0;
    
begin
    --report "this is a message"; 
    process(RESET, CEAS)
    begin
        
        if( RESET = '1') then
            state <= S0;
            TXRDY <= '0';
            RDY <= '0';
            INCARCA <= '0';
            DEPL <= '0';
            DDISP <= '0';
            report "sunt in reset";
        elsif(state = S0 and START = '1') then
            state <= S1;
            
            -- semnale din starea S1
            TXRDY <= '0';
            RDY <= '0';
            INCARCA <= '1';
            DEPL <= '0';
            DDISP <= '0';
            report "starea S0 si in START 1";
        elsif( state = S2 and DREQ = '1') then
            state <= S3;
            
            --semnale din starea S3
            TXRDY <= '0';
            RDY <= '0';
            INCARCA <= '0';
            DEPL <= '1';
            DDISP <= '0';
        elsif(state = S5 and RXRDY = '1') then
            state <= S0;
            
            -- semnale din starea S0
            TXRDY <= '0';
            RDY <= '1';
            INCARCA <= '0';
            DEPL <= '0';
            DDISP <= '0';    
        elsif(CEAS'event and CEAS = '1') then 
            case state is
                when S0 =>
                    TXRDY <= '0';
                    RDY <= '1';
                    INCARCA <= '0';
                    DEPL <= '0';
                    DDISP <= '0';
                                          
                when S1 =>
                     TXRDY <= '0';
                     RDY <= '0';
                     INCARCA <= '1';
                     DEPL <= '0';
                     DDISP <= '0';
                     
                     state <= S2;                   
                when S2 =>
                     TXRDY <= '0';
                     RDY <= '0';
                     INCARCA <= '0';
                     DEPL <= '1';
                     DDISP <= '1';
                                                 
                when S3 =>
                     TXRDY <= '0';
                     RDY <= '0';
                     INCARCA <= '0';
                     DEPL <= '1';
                     DDISP <= '0';
                                        
                     state <= S4;
                                         
                when S4 =>
                     TXRDY <= '0';
                     RDY <= '0';
                     INCARCA <= '0';
                     DEPL <= '1';
                     DDISP <= '0';
                
                    if(NUM12 = '1') then
                        state <= S5;
                    end if;
                    
                when S5 =>
                    TXRDY <= '1';
                    RDY <= '0';
                    INCARCA <= '0';
                    DEPL <= '0';
                    DDISP <= '0';
                    
                when others => NULL;
            end case;
        end if;
    end process;

end Behavioral;
