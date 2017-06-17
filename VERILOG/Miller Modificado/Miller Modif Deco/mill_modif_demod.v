/*------------------------------------------------------------------------
--                     Decodificador Miller Modificado              --
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Decodificador Miller Modificado	                          	--
--Ingresa el frame recibido en codificacion miller mod y sale en NRZ-L	--
--	Test bench de este archivo en tb_mill_modif_demod.v		--
------------------------------------------------------------------------*/

module mill_modif_demod #(parameter N = 5)(clk, in_PoR, in_data, out_data, in_pause, out_pause);
  input clk;					    //Clock de fc/4 en RFID (3.39 MHz)
  wire in_clk;				    //Clock de fc/4 en RFID (3.39 MHz) modulado- Para la simulación
  input in_data;			    //Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
  input in_PoR;		        //Power on reset
  input in_pause;			    //Registro que viene desde el detector de pause
  output reg out_pause;		//Salida que resetea el detector  de pausa
  output reg out_data;	  	//Salida del decodificador miller modificado

  reg  [N-1:0] reg_count;		//Cuento los clock para estar en la mitad del ETU
  reg reg_mitad_etu;				//1 cuando se contó la primer mitad del ETU
  reg reg_etu;              //1 cuando se contó un ETU completo
  reg reg_flag;				      //Flag usado cuando viene primero la pausa y, luego, la mitad de ETU
  reg flag_pause;				    //Usado para resetear el Módulo Detector de Pausa
  
/*------------Quitar este assign. Es solamente para simulacion------------*/
  assign in_clk = (clk & in_data);  //Para simular cuando nos quedamos sin clock
  
	
	
	always @(negedge in_clk, negedge in_PoR) begin
		
    if(~in_PoR) begin	//Cuando esta desabilitado el módulo, pongo la salida, los registros y el contador en 0 (cero)
			out_data <= 1'b0;
      out_pause <= 1'b0;
			reg_etu <= 1'b0;
      reg_mitad_etu <= 1'b0;
      reg_count <= {N{1'b0}};
			reg_flag <= 1'b0;
			flag_pause <= 1'b0;
		end else begin
        	if(in_data) begin
          		reg_count <= reg_count +1;  //Cuento los clock que entran en los ETUS
        	end
      
      //-Boque para detectar, mediante un contador, la mitad de un ETU y un ETU completo-
      if(reg_count == {{(N-1){1'b1}},{1'b0}}) begin	//Cuando cuento los 32 clocks que entran en un etu
        reg_etu <= 1'b1;			//Cambio a estado alto el registro	
        reg_mitad_etu <= 1'b0;               
			end else begin
        if(reg_count == {{{{1'b0},{(N-3){1'b1}}},{1'b0}},{1'b1}}) begin	//Cuando cuento la mitad de los clocks que entran en un etu (tomo un margen)
         reg_mitad_etu <= 1'b1;			//Cambio a estado alto el registro		          
        end
      end
      //---------------------------------------------------------------------------------
      
      //-Bloque para resetear el módulo Detector de Pausa-//
			if(in_pause) begin
				if(~flag_pause) begin
					flag_pause <= 1'b1;
				end else begin
					out_pause <= 1'b1;	//Reseteo el detector de pausa
				end
			end else begin
				flag_pause <= 1'b0;
				out_pause <= 1'b0;
			end				
      //--------------------------------------------------//
		end
	end
	
	
  always @(posedge flag_pause or posedge reg_etu or posedge reg_mitad_etu) begin
		
    if(reg_mitad_etu & reg_flag)  begin
			out_data <= 1'b0;
			reg_flag <= 1'b0;
			reg_mitad_etu<= ~ reg_mitad_etu;
      reg_count <= {{(N-1){1'b0}},1'b1};
		end	
		if(flag_pause) begin		//Hubo una pausa
      if(reg_mitad_etu) begin	    //Hubo una primer mitad del ETU
				out_data <= 1'b1;		//Uno a la salida para resetear el Detector de Pausa
			  reg_mitad_etu<= ~ reg_mitad_etu;
				reg_flag <= 1'b0;
        reg_count <= {{(N-1){1'b0}},1'b1};
			end else begin 		    //Vino primero la pausa que la mitad del ETU
				reg_flag <= 1'b1;
			end
		end else begin
			if(reg_etu) begin	//Si conté un ETU completo
				out_data <= 1'b0;
        reg_etu <= ~reg_etu;
        reg_count <= {{(N-1){1'b0}},1'b1};        
			end
		end
	end
endmodule