----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2020 04:48:36 PM
-- Design Name: 
-- Module Name: 8-way_mux - Behavioral
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

entity mux is
Port (

a : in std_logic_vector(7 downto 0); 
sel : in std_logic_Vector (2 downto 0);
b : out std_logic
 );
end mux;

architecture Behavioral of mux is

begin

PROCESS(a,sel) 
begin 

case sel is 

    when "000" => b <= a(0);
    when "001" => b <= a(1);
    when "010" => b <= a(2);
    when "011" => b <= a(3);
    when "100" => b <= a(4);
    when "101" => b <= a(5);
    when "110" => b <= a(6);
    when "111" => b <= a(7);
    
end case;
end PROCESS;

end Behavioral;
