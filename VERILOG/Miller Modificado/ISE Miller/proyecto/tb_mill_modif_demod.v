`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:03:44 04/04/2017
// Design Name:   mill_modif_demod
// Module Name:   C:/Users/FlavioTG/Desktop/PROYECTO FINAL/verilog/ISE Miller/proyecto/tb_mill_modif_demod.v
// Project Name:  proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mill_modif_demod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_mill_modif_demod;

	// Inputs
	reg clk;
	reg in_enable;
	reg in_data;

	// Outputs
	wire out_data;

	// Instantiate the Unit Under Test (UUT)
	mill_modif_demod uut (
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
        
		// Add stimulus here

	end
 //----------------------------------------------------------
// Creo un clock de 500khz
    always
      #1 clk = ~clk;   // Cada 1 us invierto
	 
//-----------------------------------------------------------

    initial
      begin
//      forever #10 clk = ~clk; // generate a clock	
	#10 repeat(4) #8 in_data = ~in_data;		//10us del arranque, switcheo in_data cada 8us
	#36 in_enable=1'b1; 				//200us despues de la instruccion anterior habilito el dispositivo
// 	#16 repeat(4) #16 in_data = ~in_data;		//8us despues de la instruccion anterior switcheo in_data cada 24us
	in_data = 1'b1;					//Pongo a 1 in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	#16 in_data = ~in_data;				//Switcheo a los 4us in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	#16 in_data = ~in_data;				//Switcheo a los 4us in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	#8 in_data = ~in_data;				//Switcheo a los 4us in_data
	
// 	#16 in_enable=1'b0; 	
// 	#32 in_enable=1'b1; 
//  	#560 repeat(10) #10 in_data = ~in_data;
	#32 in_enable=1'b0; 				//Deshabilito el dispositivo
	#16 $finish;					//Finalizo la simulación
      end
 
//     initial	
//       $monitor("clk=%b,in_data=%b,in_enable=%b",clk,in_data,in_enable);	//Imprimo en consola los datos
 

endmodule

