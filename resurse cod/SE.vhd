library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SumatorElementar is
    Port ( Tin : in STD_LOGIC;
           Yi : in STD_LOGIC;
           Xi : in STD_LOGIC;
           tout : out STD_LOGIC;
           S : out STD_LOGIC);
end SumatorElementar;

architecture Behavioral of SumatorElementar is
signal c_g,c_p :std_logic;

begin
    c_g<= Xi and Yi;
    c_p<= Xi xor Yi;
    S<= c_p xor Tin;
    Tout<= c_g or (c_p and Tin);
    
    
end Behavioral;


        