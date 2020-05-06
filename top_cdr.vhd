--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY cdr_top IS
PORT
    (
		Din 		:IN STD_LOGIC;
		Ref_clk		:IN STD_LOGIC;
		RST			:IN	STD_LOGIC;
		
		Dout		:OUT STD_LOGIC;
		recov_clk	:OUT STD_LOGIC
    );

END TOP; 

ARCHITECTURE Behaviour of  TOP IS
	--signals
	Q_late_clk	:STD_LOGIC;
	Q_clk_div	:STD_LOGIC;
	Q_recov_clk	:STD_LOGIC;
	clk_div		:STD_LOGIC;
	clk_early	:STD_LOGIC;
	clk_edge	:STD_LOGIC;
	clk_late	:STD_LOGIC;
	up			:STD_LOGIC;
	down		:STD_LOGIC;
	out_p		:STD_LOGIC;
	out_n		:STD_LOGIC;
	
	--components
	 COMPONENT divider
	 
        PORT
            (
                --inputs
                clk     :IN STD_LOGIC; --system clock
                rst         :IN STD_LOGIC;
                --outputs
                clk_out     :IN STD_LOGIC --divided clock
                
            );
    END COMPONENT;
	

	COMPONENT PHASE_ROTATOR
	PORT
    (
        INC     :IN STD_LOGIC; 
        DEC     :IN STD_LOGIC;  
        rst     :IN STD_LOGIC;  
        clk     :IN STD_LOGIC; 
        --outputs
        clk_early           :OUT STD_LOGIC;
        clk_edge            :OUT STD_LOGIC;
        clk_late            :OUT STD_LOGIC
     );
	END COMPONENT;
	
	
	COMPONENT BB
	PORT
    (
        Din     	:IN STD_LOGIC;  
        clk_early   :IN STD_LOGIC;
        clk_edge    :IN STD_LOGIC;
        clk_late    :IN STD_LOGIC;
        --outputs
        down 			:OUT STD_LOGIC;
		up		:OUT STD_LOGIC
    );
	END COMPONENT;
	
	
	COMPONENT DIGITAL_FILTER
	PORT
    (
		clk		:IN STD_LOGIC;
		In_P	:IN STD_LOGIC;
		In_N	:IN STD_LOGIC;
		--outputs
		Out_P	:OUT STD_LOGIC;
		Out_N	:OUT STD_LOGIC
    );
	END COMPONENT;
	
	begin
		recov_clk <= Q_recov_clk;
		process(ref_clk)
			if rising_edge(ref_clk) then
				Q_clk_div <= clk_div;
				Q_late_clk <= clk_late;
				Q_recov_clk <= Q_late_clk;
			end if;
		end process;
		
		process(Q_recov_clk)begin
			if rising_edge(Q_recov_clk) then
				Dout <= Din;
			end if;
		end process;
	
	
	--clock divider
	clk_div_4 : divider 
		GENERIC MAP (4)
		PORT MAP 
			(
				Q_late_clk,
				rst,
				clk_div
			);
	
			
	phase_rot : phase_rotator
		PORT MAP
			(			
			    out_n,
			    out_p,
			    RST,
			    Q_clk_div,
			    
			    clk_early,
                clk_edge,
                clk_late								
			);
			
	phase_dect : BB
		PORT MAP
			(
				Din,  
				clk_early,
				clk_edge, 
				clk_late,
				up, 
				down,	
			);
			
	dig_filter : DIGITAL_FILTER
		PORT MAP
			(
				Q_late_clk,
				up,
				down,
				out_p,
				out_n
			);
END Behaviour;
