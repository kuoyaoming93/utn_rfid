
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity tb_man_mod is
end tb_man_mod;


architecture behavior of tb_man_mod is 
component man_mod is
   port(
      clk,in_data,in_enable:        in std_logic;
      out_data:                     out std_logic
   );
end component;

--declare inputs and initialize them
signal clk:	  std_logic := '0';
signal in_data: std_logic := '0';
signal out_data: std_logic := '0';
signal in_enable: std_logic := '0';


constant clk_period : time := 10 us;

begin

dut: man_mod PORT MAP(
                        clk       =>  clk,
                        in_enable =>  in_enable,
                        in_data   =>  in_data,
					              out_data  =>  out_data
				 	);


clk_process :process
   	begin
        clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   	end process;


stim_proc: process
	begin        
        -- Reset
    wait for 5 us;
	wait for 20 us;
    in_enable       <='1';
    in_data         <='1';
    wait for 20 us;
    in_enable       <='1';
    in_data         <='0';

    wait for 20 us;
    in_enable       <='0';
    in_data         <='0';
    wait for 20 us;
    in_data         <='1';

    wait for 20 us;
    in_data         <='1';
    wait for 20 us;
    in_enable       <='1';
    in_data         <='1';

    wait for 20 us;
    in_data         <='1';
    in_enable       <='0';
    wait for 20 us;
    in_data         <='0';
    wait for 20 us;
    in_data         <='1';

    wait;

  	end process;
end behavior;
