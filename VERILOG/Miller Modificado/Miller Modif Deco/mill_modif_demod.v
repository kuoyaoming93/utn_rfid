/*------------------------------------------------------------------------
--                     Decodificador Miller Modificado                 	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Decodificador Miller Modificado	                          	--
--Ingresa el frame recibido en codificacion miller mod y sale en NRZ-L	--
--	Test bench de este archivo en tb_mill_modif_demod.v		--
------------------------------------------------------------------------*/

module mill_modif_demod #(parameter N = 4)(clk, in_PoR, in_data, out_data, in_pause);
input clk;
wire in_clk;				    //Clock de fc/4 en RFID (3.39 MHz)
input in_data;			    //Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
input in_PoR;		        //Power on reset
output reg out_data;	  //Salida del decodificador miller modificado
input in_pause;			    //Registro que viene desde el detector de pause

reg  [N-1:0] reg_count;		//Cuento los clock para estar en la mitad del ETU
reg reg_etu;				      //0 si se está en la primer mitad del etu - 1 si se está en la segunda mitad
reg pre_out;			        //Usado para ir haciendole AND a cada bit que llega por in_data
reg reg_pause;

  assign in_clk = (clk & in_data);  //Para simular cuando nos quedamos sin clock
  
  always @ (negedge in_clk, negedge in_PoR, posedge in_pause) begin
      
      
      if(~in_PoR) begin	//Cuando esta desabilitado el modulo, pongo la salida, los registros y el contador en 0 (cero)
        out_data <= 1'b0;
        reg_etu <= 1'b0;	
        reg_count <= {N{1'b0}};
        pre_out <= 1'b1;
        reg_pause <= 1'b0;
      end else begin
 	      reg_pause <= in_pause;

        if(in_data) begin
          reg_count <= reg_count +1;
        end
              
      if(reg_pause && reg_etu) begin
        out_data <= 1'b1;
        reg_count <= {{(N-1){1'b0}},1'b1};		//reseteo el contador
        reg_etu <= ~reg_etu;			//Reseteo el registro
      end  
        
  
        if(reg_count == {N{1'b1}}) begin	//Cuando cuento la mitad de los clocks que entran en un etu
          if(reg_pause) begin		//Hubo una pausa
              if(~reg_etu) begin			//No se conto una primer mitad del ETU 
                out_data <= 1'b0;		//Cero a la salida
                reg_count <= {{(N-1){1'b0}},1'b1};		//reseteo el contador  
              end
          end else begin
            if(~reg_etu) begin			//Es el primer ETU que cuento
              reg_etu <= ~reg_etu;
            end else begin          //Conte un ETU completo, es decir, un cero
              reg_etu <= ~reg_etu;			//Reseteo el registro
              out_data <= 1'b0;			//Cero a la salida              
            end             
            reg_count <= {{(N-1){1'b0}},1'b1};		//reseteo el contador 
          end
      end
    end
  end
endmodule