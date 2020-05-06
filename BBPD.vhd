----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2020 07:57:17 PM
-- Design Name: 
-- Module Name: BB - Behavioral
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

entity BB is
    Port ( 
    Din : in STD_LOGIC;
    clk_early : in STD_LOGIC;
    clk_edge : in STD_LOGIC;
    clk_late : in STD_LOGIC;
    down   : out STD_LOGIC;
    up     : out STD_LOGIC
    );
end BB;

architecture Behavioral of BB is
    signal ff1 : STD_LOGIC;
    signal ff2 : STD_LOGIC;
    signal ff3 : STD_LOGIC;
    signal ff4 : STD_LOGIC;
    signal ff5 : STD_LOGIC;
    signal xor1 : STD_LOGIC;
    signal xor2 : STD_LOGIC;

begin

    xor1 <= ff1 xor ff2;
    xor2 <= ff2 xor ff3;
    up <= ff4;
    down <= ff5;
    
        PROCESS(clk_early) begin


            if (rising_edge(clk_early)) then
                ff1 <= Din;
            end if;
        end process;

        PROCESS(clk_edge) begin
            if (rising_edge(clk_edge)) then
                ff2 <= Din;
            end if;
        end process;

        PROCESS(clk_late) begin
            if (rising_edge(clk_late)) then
                ff3 <= Din;
            
            elsif (falling_edge(clk_late)) then
                ff4 <= xor1;
                ff5 <= xor2;
            end if;
        end process;


end Behavioral;
