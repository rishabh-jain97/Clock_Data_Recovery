----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2020 05:10:07 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
Port ( 

INC : in std_logic;
DEC : in std_logic;
clk : in std_logic;
rst : in std_logic; 
count : out std_logic_vector (2 downto 0)
);
end counter;



architecture Behavioral of counter is

signal count_buf : STD_LOGIC_VECTOR (2 downto 0);

begin
count <= count_buf;
PROCESS(clk,rst) begin 

if rst = '0' then 
  count_buf <= "000";
    
elsif (rising_edge(clk)) then

    if INC = '1' and DEC = '0' then 
    count_buf <= count_buf + 1;
    
    elsif INC = '0' and DEC = '1' then 
     count_buf <= count_buf -1;
    end if;
END IF;
END PROCESS;

end Behavioral;
