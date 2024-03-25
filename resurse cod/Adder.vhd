library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder is
    Port ( SemnA : in STD_LOGIC;
           SemnB : in STD_LOGIC;
           MA : in STD_LOGIC_VECTOR (22 downto 0);
           MB : in STD_LOGIC_VECTOR (22 downto 0);
           A_S : in STD_LOGIC;
           Comp : in STD_LOGIC_VECTOR(1 downto 0);
           p:out std_logic;
           S : out STD_LOGIC_VECTOR (22 downto 0);
           CO : out STD_LOGIC;
           SO : out STD_LOGIC);
end Adder;

architecture Behavioral of Adder is


signal S_aux: STD_LOGIC_VECTOR (22 downto 0);
signal AS_aux,SO_aux,Co_aux:std_logic:='0';

begin
    comp1:entity WORK.signout port map (SemnA => SemnA, SemnB => SemnB, A => MA, B => MB, A_S => A_S, Comp => Comp,
                            AS => AS_aux, SO => SO_aux);
    
    comp2:entity WORK.FractionAdd port map(A => MB,B => MA, A_S => AS_aux,Comp => Comp,p=>p, S => S_aux, Cout => Co_aux);
    
    s<=  S_aux;
    Co<='0' when ((SemnB xor A_S)/=SemnA) else Co_aux;
    So<=So_aux;
    
end Behavioral;


       