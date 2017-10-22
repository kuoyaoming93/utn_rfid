/*------------------------------------------------------------------------
--                     Decodificador Miller Modificado                  --
-- * 1.0                                                          	    --
-- Descripcion:                                                   	    --
--    	Decodificador Miller Modificado	                          	    --
--Ingresa el frame recibido en codificacion miller mod y sale en NRZ-L	--
--	Test bench de este archivo en tb_mill_modif_demod.v		--
------------------------------------------------------------------------*/

module mill_modif_demod #(parameter N = 5)(clk, in_PoR, in_data, out_data);
  input clk;					      //Clock de fc/4 en RFID (3.39 MHz)
  wire in_clk;				      //Clock de fc/4 en RFID (3.39 MHz) modulado- Para la simulación
  input in_data;			      //Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
  input in_PoR;		          //Power on reset
  
  reg in_pause;			        //Registro que viene desde el detector de pause
  reg out_pause;		        //Salida que resetea el detector  de pausa
  
  output reg out_data;	  	//Salida del decodificador miller modificado

  reg  [N-1:0] reg_count;		//Cuento los clock para estar en la mitad del ETU
  reg reg_mitad_etu;				//1 cuando se contó la primer mitad del ETU
  reg reg_etu;              //1 cuando se contó un ETU completo
  reg reg_flag;				      //Flag usado cuando viene primero la pausa y, luego, la mitad de ETU
  reg flag_pause;				    //Usado para resetear el Módulo Detector de Pausa
  reg flag_count_end;       //Usado para contar 3 clock al final de una pausa
  reg [1:0] count_end;      //Contador para contar 3 clocks       
  
  wire [1:0]aux = {in_data, out_pause};
  
/*------------Quitar este assign. Es solamente para simulacion------------*/
  assign in_clk = (clk & in_data);  //Para simular cuando nos quedamos sin clock
/*------------------------------------------------------------------------*/
  
//Módulo que analiza los datos de entrada (in_data) y un flag que lo "habilita" (out_pause) y devuelve si hay una pausa o no  
  always @(negedge in_data, posedge out_pause) begin
    if(in_PoR) begin
    if(aux == 2'b00) begin    //Cuando hay una pausa y el bloque está habilitado
      in_pause <= 1'b1;       //Pongo en 1 el reg de "pausa detectada"
      end else begin
      in_pause <= 1'b0;       //Pongo en 0 el reg de "pausa detectada"
      out_pause <= 1'b0;      //Habilito el bloque detector de pausa
      end      
    end
  end
  
  //-----Módulo encargado de contar clocks dentro de ETU's y de setear un flag (flag_pause) ante una pausa-----
	always @(negedge in_clk, negedge in_PoR) begin
		
    if(~in_PoR) begin	//Cuando esta desabilitado el módulo, pongo la salida, los registros y el contador en 0 (cero)
			out_data <= 1'b0;
      out_pause <= 1'b0;
			reg_etu <= 1'b0;
      reg_mitad_etu <= 1'b0;
      reg_count <= {N{1'b0}};
			reg_flag <= 1'b0;
			flag_pause <= 1'b0;
      in_pause <= 1'b0;
      flag_count_end <= 1'b0;
      count_end <= 2'b0;
		end else begin
     
      if(~flag_count_end) begin
        
        	if(in_data) begin
          		reg_count <= reg_count +1;  //Cuento los clock que entran en los ETUS
        	end
      
      //-Bloque para detectar, mediante un contador, la mitad de un ETU y un ETU completo-
      if(reg_count == {(N){1'b1}}) begin	//Cuando cuento los 32 clocks que entran en un etu
        reg_etu <= 1'b1;			//Cambio a estado alto el registro de detección de un ETU
        reg_mitad_etu <= 1'b0;   
			end else begin
        if(reg_count == {{1'b0},{(N-1){1'b1}}}) begin	//Cuando cuento la mitad de los clocks que entran en un etu
         reg_mitad_etu <= 1'b1;			//Cambio a estado alto el registro de detección de la mitad de un ETU		          
        end
      end
 
      //---------------------------------------------------------------------------------
      
      //-Bloque para resetear el módulo Detector de Pausa-//
        if(in_pause) begin        //Si hubo una pausa
          if(~flag_pause) begin    
					flag_count_end <= 1'b1;     //Levanto el flag para contar 3 clocks luego de la pausa  
          reg_count <= {N{1'b0}};   //Me aseguro que, despues de contar esos 3 clocks, el contador arranque en 0  

				end else begin
          flag_pause <= 1'b0;     
					out_pause <= 1'b1;	//Reseteo el detector de pausa
				end
			end else begin
				out_pause <= 1'b0;
        
			end				
      //--------------------------------------------------//
      end else begin  //Cuando hay una pausa, tengo que contar algunos clocks que quedan "espurios"
        if(count_end == 2'b1) begin   //Cuando cuento los tres clock posteriores a la pausa, salgo de esta condición
          flag_count_end <= 1'b0;
          count_end <= 2'b0;
          flag_pause <= 1'b1;   //Levanto el flag de pausa detectada
        end else begin
          count_end <= count_end + 1; //Cuento clocks
        end
        
      end
		end
	end
	
	
  always @(posedge flag_pause, posedge reg_etu, posedge reg_mitad_etu) begin
		
    if(reg_flag & reg_mitad_etu)  begin
			out_data <= 1'b0;
      reg_flag  <= 1'b0;
			reg_mitad_etu<= 1'b0;
      reg_count <= {N{1'b0}};

		end	
		if(flag_pause) begin		//Hubo una pausa
      if(reg_mitad_etu) begin	    //Hubo una primer mitad del ETU
			  reg_mitad_etu<= ~ reg_mitad_etu;
				reg_flag <= 1'b0;

        reg_count <= {N{1'b0}};       
        out_data <= 1'b1;
			end else begin 		    //Vino primero la pausa que la mitad del ETU
				reg_flag <= 1'b1;
			end
		end else begin
			if(reg_etu) begin	//Si conté un ETU completo
        out_data <= 1'b0;
        reg_etu <= ~reg_etu;        
        reg_count <= {N{1'b0}};     
			end
		end
	end
endmodule