`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:28:55 04/03/2017
// Design Name:   man_mod
// Module Name:   C:/Users/FlavioTG/Desktop/PROYECTO FINAL/verilog/ISE/proyecto/tb_man_mod.v
// Project Name:  proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: man_mod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_man_mod;

	// Inputs
	reg clk;
	reg in_enable;
	reg in_data;

	// Outputs
	wire out_data;

	// Instantiate the Unit Under Test (UUT)
	man_mod uut (
		.clk(clk), 
		.in_enable(in_enable), 
		.in_data(in_data), 
		.out_data(out_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		in_enable = 0;
		in_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
	end
	
	// Add stimulus here
		always
      #1 clk = ~clk;   // Cada 1 us invierto  

      initial
    begin
        //      forever #10 clk = ~clk; // generate a clock	
        #10 repeat(4) #8 in_data = ~in_data;		//10us del arranque, switcheo in_data cada 8us
        #36 in_enable=1'b1; 				//36us despues de la instruccion anterior habilito el dispositivo
        #16 repeat(4) #16 in_data = ~in_data;		//16us despues de la instruccion anterior switcheo in_data cada 24us
        in_data=1'b0;					//Pongo a 0 in_data
        #16	in_data = 1'b1;				//16us despues, lo pngo a 1

        // 	#16 in_enable=1'b0; 	
        // 	#32 in_enable=1'b1; 
        //  	#560 repeat(10) #10 in_data = ~in_data;
        #26 in_enable=1'b0; 				//Deshabilito el dispositivo
        #4  in_enable=1'b1; 				//Habilito el dispositivo
        #40 $finish;					//Finalizo la simulación
    end
 
		
endmodule

