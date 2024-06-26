library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CompExp is
    Port ( ExpA : in STD_LOGIC_VECTOR (7 downto 0);
           ExpB : in STD_LOGIC_VECTOR (7 downto 0);
           DExp : out STD_LOGIC_VECTOR (4 downto 0);
           Comp : out STD_LOGIC_vector(1 downto 0));
end CompExp;

architecture Behavioral of CompExp is
signal dif:std_logic_vector(7 downto 0);
signal C:std_logic_vector(1 downto 0);

    
begin
    C<="00" when (ExpA>ExpB) else 
       "01" when (ExpA<ExpB) else                 
       "10" when (ExpA=ExpB) else
       "11";
       
    Comp<=C;
    
    dif<=ExpA-ExpB when C="00" else
        ExpB-ExpA when C="01" else
        "00000000";
            
    process(dif)
    begin
        if dif<=x"16" then
            Dexp<=dif(4 downto 0);
        else
            Dexp<="10110";
        end if;
    end process;

end Behavioral;
