/*----------------------------------------------------------------
--          Test Bench						--
-- Archivo a testear: 	mill_modif_demod.v			--
-- Descripcion:		DUT decodificador miller modificado	--
-- Observacion:							--
--	Se va a ver la salida con un delay de 1 (uno) ETU	--
----------------------------------------------------------------*/

//Frecuencia clk = 3.39MHz
//Frecuencia ETU = 106KHz
// Entran 32 clock's dentro de cada ETU

 `timescale 1us/1us	//Dividir el eje de tiempo en unidades de 1us

module mill_modif_demod_tb;	//Modulo de test bench

	parameter M = 256;
// Entradas del DUT son reg
  	reg clk;
  	reg in_data;
  	reg in_PoR;
	reg in_enable;
//   Las salidas del DUT son wire
	wire [M-1:0] out_data;
	wire out_pause;  
	mill_modif_demod u1(clk, in_PoR, in_enable, in_data, out_data);	//DUT a testear
//----------------------------------------------------------
// Inicializo
// Inicializar todo para que no quede en estados "fantasmas"
    initial
    begin
      clk= 1'b0; 
      in_data= 1'b0;
      in_PoR=1'b0; 
	  in_enable=1'b0;
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
	#36 in_PoR=1'b1; 				//200us despues de la instruccion anterior habilito el dispositivo
// 	#16 repeat(4) #16 in_data = ~in_data;		//8us despues de la instruccion anterior switcheo in_data cada 24us
	in_data = 1'b1;					//Pongo a 1 in_data
	#32 in_data = ~in_data;				//Switcheo a los 4us in_data
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	#70 in_data = ~in_data;				//Switcheo a los 4us in_data
		in_enable = ~in_enable;
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	#70 in_data = ~in_data;				//Switcheo a los 4us in_data
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	#38 in_data = ~in_data;				//Switcheo a los 4us in_data
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	#134 in_data = ~in_data;			//Switcheo a los 4us in_data
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	#70 in_data = ~in_data;				//Switcheo a los 4us in_data
	#26 in_data = ~in_data;				//Switcheo a los 4us in_data
	
// 	#16 in_PoR=1'b0; 	
// 	#32 in_PoR=1'b1; 
//  	#560 repeat(10) #10 in_data = ~in_data;
	//#32 in_PoR=1'b0; 				//Deshabilito el dispositivo
	#16 $finish;					//Finalizo la simulación
      end
 
//     initial	
//       $monitor("clk=%b,in_data=%b,in_PoR=%b",clk,in_data,in_PoR);	//Imprimo en consola los datos
 
    initial
    begin
      $dumpfile("mill_modif_demod_tb.vcd");	//Creo el archivo para simular con GTKWave
      $dumpvars(0, mill_modif_demod_tb);
    end
endmodule