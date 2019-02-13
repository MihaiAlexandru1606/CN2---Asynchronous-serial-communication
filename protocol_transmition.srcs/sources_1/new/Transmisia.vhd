----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 16:51:55
-- Design Name: 
-- Module Name: Transmisia - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Transmisia is
    Port (
            D : in std_logic_vector(7 downto 0);
            CEAS : in std_logic;
            START : in std_logic;
            RESET : in std_logic;
            RXRDY : in std_logic;
            DREQ: in std_logic;
            DATE_SERIALE : out std_logic;
            GATA_OPERATIE: out std_logic
          );
end Transmisia;

architecture Behavioral of Transmisia is

    component FDCE is
        Port (
                D : in std_logic;
                CE : in std_logic;
                C : in std_logic;
                CLR : in std_logic;
                Q : out std_logic
            );
    end component FDCE;
    
    component CB4CLE is
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
    end component CB4CLE;
    
    component FDRSE is
        Port (
            D : in std_logic;
            CE : in std_logic;
            C : in std_logic;
            R : in std_logic;
            S : in std_logic;
            Q : out std_logic
          );
    end component FDRSE;

    component x74_194 is
    Port(
           SLI : in std_logic;
           A : in std_logic;
           B : in std_logic;
           C : in std_logic;
           D : in std_logic;
           SRI : in std_logic;
           S0: in std_logic;
           S1 : in std_logic;
           CK : in std_logic;
           CLR : in std_logic;
           QA : out std_logic;
           QB : out std_logic;
           QC : out std_logic;
           QD : out std_logic
         );
    end component x74_194;
    
    component H1 is
        Port (
                D : in std_logic_vector(7 downto 0);
                PARITATE : out std_logic
            );
    end component H1;
    
    component H2 is
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
    end component H2;
    
    signal paritate : std_logic;
    constant zero : std_logic := '0'; 
    signal Q : std_logic_vector(3 downto 0);
    signal DEPL : std_logic;
    signal CLR_aux : std_logic;
    signal NUM12 : std_logic;
    signal TXRDY : std_logic;
    signal LOAD : std_logic;
    signal aux_gata : std_logic;
    signal S1 : std_logic;
    signal R1 : std_logic;
    signal Q1 : std_logic;
    signal D2 : std_logic;
    signal S1_x1 : std_logic;
    signal Q_x1 : std_logic;
    
begin

    CIRC_GEN_PARTT : H1 port map(D => D, PARITATE => paritate);
                                
    CB4CLE_comp : CB4CLE port map(D => "0000",L => '0', CE => DEPL,C => CEAS, CLR => CLR_aux,
                                  Q => Q,CEO => open,TC => open);
                                  
    H2_comp : H2 port map(START => START,RXRDY => RXRDY,RESET => RESET, NUM12 => NUM12,DREQ => DREQ,
                          CEAS => CEAS,TXRDY => TXRDY, RDY => open,INCARCA => LOAD,DEPL => DEPL,DDISP => open);
                          
    FDCE_comp : FDCE port map(D => '1',CE => TXRDY, C => CEAS,CLR => RESET,Q => aux_gata);
                              
    FDRSE_comp1 : FDRSE port map(D => '1',CE => DEPL,C => CEAS,R => R1,S => S1,Q => Q1);                                                                                                                           
    FDRSE_comp2 : FDRSE port map(D => D2, CE => DEPL,C => CEAS,R => LOAD,S => RESET,Q => DATE_SERIALE);                                                                                                                           
    
    x74_194_comp1 : x74_194 port map(SLI => Q1,A => D(4), B => D(5),C => D(6),D => D(7),SRI => '0',
                                     S0 => LOAD,S1 => S1_x1,CK => CEAS,CLR => RESET,QA => Q_x1,
                                     QB => open,QC => open, QD => open);
    x74_194_comp2 : x74_194 port map(SLI => Q_x1,A => D(0), B => D(1),C => D(2),D => D(3),SRI => '0',
                                     S0 => LOAD,S1 => S1_x1, CK => CEAS,CLR => RESET,QA => D2,
                                     QB => open,QC => open,QD => open);
                                     
   S1_x1 <= DEPL or LOAD;                               
   CLR_aux <= RESET or aux_gata;
   NUM12 <= ((not(Q(0))) and (not(Q(1)))) and (Q(2) and Q(3));
   R1 <= (not(paritate)) and LOAD;
   S1 <=  paritate and LOAD;
   GATA_OPERATIE <= not(aux_gata);
   
end Behavioral;
