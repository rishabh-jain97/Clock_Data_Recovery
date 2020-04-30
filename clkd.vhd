--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.math_real.all;
ENTITY CLKD IS
GENERIC
    (
        divide :integer:=2
    );
PORT
    (  
         --inputs
         sys_clk :IN STD_LOGIC; --system clock
         rst :IN STD_LOGIC; --rst divided clock(active low)
         --outputs
         div_clk :OUT STD_LOGIC
     );
END CLKD;


ARCHITECTURE Behaviour of CLKD IS

    signal div_cnt :integer range 0 to divide-1;
    signal div_clk_reg :STD_LOGIC;
    begin
        div_clk <= div_clk_reg;
        process(sys_clk,rst)
        begin
             if(rst = '0') then
                div_cnt <= 0;
                div_clk_reg <= '0';
             elsif falling_edge(sys_clk) then
                if div_cnt = divide-1 then
                    div_clk_reg <= not div_clk_reg;
                    div_cnt <= 0;
                else
                    div_cnt <= div_cnt + 1;
             end if;
             end if;
       end process;
END Behaviour;