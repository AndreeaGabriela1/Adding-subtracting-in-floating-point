library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Normalizare is
    Port ( MS : in STD_LOGIC_VECTOR (22 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           normEnable:in std_logic;
           M : out STD_LOGIC_VECTOR (22 downto 0);
           E : out STD_LOGIC_VECTOR (7 downto 0);
           DepInf:out std_logic);
end Normalizare;

architecture Behavioral of Normalizare is 

signal Zcount_aux: std_logic_vector(4 downto 0);
signal shift1: std_logic_vector(4 downto 0);

begin
    comp1:entity Work.CountLeadingZeroes port map (M => MS, Zcount => Zcount_aux);
    
    shift1<=(Zcount_aux + '1') when Zcount_aux<"10111" else "00000";
    
    comp2:entity WORK.ShiftLeft port map(inp => MS, shift1=>shift1,normEnable=>(normEnable ) ,outp =>M);
    
    DepInf<='1' when ES<shift1 else '0';
    E<=ES-shift1 when normEnable='1' else ES;
    

end Behavioral;
