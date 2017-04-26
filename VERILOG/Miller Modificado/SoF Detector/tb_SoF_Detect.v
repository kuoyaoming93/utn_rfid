/*----------------------------------------------------------------
--          Test Bench						                              --
-- Archivo a testear: 	SoF_Detect.v			                      --
-- Descripcion:		SoF Detect	                                  --
-- Observacion:							                                    --
--	                                                            --
----------------------------------------------------------------*/

//Frecuencia in_clk = 3.39MHz
//Frecuencia ETU = 106KHz
// Entran 32 clock's dentro de cada ETU

 `timescale 1us/1us	//Dividir el eje de tiempo en unidades de 1us

module SoF_Detect_tb;	//Modulo de test bench

// Entradas del DUT son reg
  reg in_clk;
  reg in_data;
  reg in_PoR;
  reg in_pause;
  reg in_y_detected;
//   Las salidas del DUT son wire
  wire out_enable;
  
  SoF_Detect u1(in_clk, in_data, out_enable, in_pause, in_PoR, in_y_detected);	//DUT a testear
//----------------------------------------------------------
// Inicializo
// Inicializar todo para que no quede en estados "fantasmas"
    initial
    begin
      in_PoR= 1'b0;   //Arrancando con el Power on reset en cero, hago que el DUT inicialice sus registros  
	  in_clk = 1'b0;
		in_data = 1'b0;
      end
//----------------------------------------------------------
// Creo un clock de 500khz
    always
      #1 in_clk = ~in_clk;   // Cada 1 us invierto
	 
//-----------------------------------------------------------

    initial
      begin
        
	#10 repeat(4) #8 in_data = ~in_data;		//10us del arranque, switcheo in_data cada 8us
  	#50 in_PoR = 1'b1;
// 	#16 repeat(4) #16 in_data = ~in_data;		//8us despues de la instruccion anterior switcheo in_data cada 24us
	#2in_data = 1'b1;					//Pongo a 1 in_data
	#32 in_data = ~in_data;				
	#32 in_data = ~in_data;				
	in_pause = 1'b1;
	#64 in_data = ~in_data;				
	#32 in_data = ~in_data;				
	in_pause = ~in_pause;
	in_y_detected = 1'b1;
	#4 in_y_detected = ~in_y_detected;
	#64 in_data = ~in_data;				
	#32 in_data = ~in_data;				
	in_pause = ~in_pause;
	#32 in_data = ~in_data;
  #8in_y_detected = 1'b1;
  #4 in_y_detected = ~in_y_detected;
	#32 in_data = ~in_data;				
	
//  	#560 repeat(10) #10 in_data = ~in_data;
	#16 $finish;					//Finalizo la simulación
      end
 
//     initial	
//       $monitor("in_clk=%b,in_data=%b,in_enable=%b",in_clk,in_data,in_enable);	//Imprimo en consola los datos
 
    initial
    begin
      $dumpfile("SoF_Detect_tb.vcd");	//Creo el archivo para simular con GTKWave
      $dumpvars(0, SoF_Detect_tb);
    end
endmodule