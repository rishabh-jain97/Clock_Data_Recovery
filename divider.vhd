library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity divider is
    port ( 
    clk : in std_logic;
    rst : in std_logic;
    clk_out : out std_logic);
end divider;
  
architecture behav of divider is
  
    signal cnt: integer:=0;
    signal tmp : std_logic := '0';
  
begin
  clk_out <= tmp;
  
    process(clk,rst)
    begin
        if(rst='1') then
            cnt<=0;
            tmp<='0';
        --increment the counter and change the sign of output every 2 cycles
        elsif(clk'event and clk='1') then
            cnt <=cnt+1;
        if (cnt = 2) then
            tmp <= NOT tmp;
            cnt <= 0;
        end if;
        end if;
    
    end process;
  
end behav;
