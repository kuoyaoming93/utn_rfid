/*------------------------------------------------------------------------
--                                   MODULOS                            --
-- * 1.0                                                          	    --
-- Descripcion:                                                   	    --
--    	Se encarga de leer la información que decodificó el modulo      -- 
--      Miller y de identificar que comando es.                         --
------------------------------------------------------------------------*/

module modulos(clk, in_data, out_REQA, out_WUPA, out_ANTC, out_RATS, out_HLTA);
  input clk;					            //Clock de fc/4 en RFID (3.39 MHz)
  wire in_clk;				            //Clock de fc/4 en RFID (3.39 MHz) modulado- Para la simulación
  input [255:0]in_data;			      //Informacion decodificada del módulo MILLER

  
  output reg out_REQA;  	  	//Salida REQA
  output reg out_WUPA;        //Salida REQA
  output reg out_ANTC;        //Salida REQA
  output reg out_RATS;        //Salida REQA
  output reg out_HLTA;        //Salida REQA
  
/*------------Quitar este assign. Es solamente para simulacion------------*/
  assign in_clk = (clk & in_data);  //Para simular cuando nos quedamos sin clock
/*------------------------------------------------------------------------*/
  
//Módulo que analiza los datos de entrada (in_data) y un flag que lo "habilita" (out_pause) y devuelve si hay una pausa o no  
  always @(negedge in_clk) 
  begin
    begin
        out_REQA <= 1'b0;
        out_WUPA <= 1'b0;
        out_ANTC <= 1'b0;
        out_RATS <= 1'b0;
        out_HLTA <= 1'b0;
        //REQA
        if(in_data == 7'b1010010)
        begin
          out_REQA <= 1'b1;
        end
        //WUPA
        if(in_data == 7'b0100110)
        begin
          out_WUPA <= 1'b1;
        end
        //ANTICOLLISION CL1
        if(in_data == 8'b10010011)
        begin
          out_ANTC <= 1'b1;
        end
        //RATS
        if(in_data == 8'b11100000)
        begin
          out_RATS <= 1'b1;
        end
        //HLTA
        if(in_data == 16'b0111000000000000)
        begin
          out_HLTA <= 1'b1;
        end
    end
  end
endmodule