/*--------------------------------------------------------------------------------
--                     Detector del Start of Frame                 				--
-- * 1.0                                                          				--
-- Descripcion:                                                   				--
--    	SoF Detect	                          									--
--Analiza la información en Miller modificado y detecta el simbolo "Z"(SoF)	--	
--------------------------------------------------------------------------------*/

module SoF_Detect #(parameter N = 5)(in_clk, in_data, out_enable, in_pause, in_PoR, in_y_detected);

	input in_clk;			//Clock a fc/4 = 13.56MHz/4
	input in_data;			//Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
	input in_pause;			//Entrada que viene desde el detector de pause
	input in_PoR;			//Power On Reset
	input in_y_detected;	//Cuando el Detector de End of Frame detecta el EoF, pone en 1
	output reg out_enable;	//Cuando detecto el simbolo "Z", habilito el decodificador Miller
	
	reg  [N-1:0] reg_count;		//Cuento los clock para estar en la mitad del ETU
	reg reg_pause;			
	reg reg_flag;				//Bandera para manejar cuando detectar el simbolo "Z" y cuando mandar a dormir el modulo
	
	always @(negedge in_clk, posedge in_pause, posedge in_y_detected) begin
		if(~in_PoR) begin	//Inicializo todo	
			reg_pause <= 1'b0;
			reg_flag <= 1'b0;
			reg_count <= {N{1'b0}};		
			out_enable <= 1'b0;
		end else begin
	if(in_pause) begin		//Tomo el valor de la entrada y lo pongo en un registro
	reg_pause <= in_pause;
      end	
		if(~reg_flag) begin	//Si el flag esta en 0, busco detectar el simbolo Z
			if(reg_pause) begin
				reg_count <= reg_count +1;	//Pasó la pausa y tengo que contar medio ETU para detectar el "Z"
				if(reg_count == {N-1{1'b1}}) begin
					out_enable <= 1'b1;				//Pongo la salida en 1
					reg_flag <= 1'b1;				//Cambio el flag
				end		
			end		
		end else begin
			if(in_y_detected == 1'b1) begin
				out_enable <= 1'b0;
				reg_pause <= 1'b0;
				reg_flag <= 1'b0;
				reg_count <= {N{1'b0}};	
			end
		end
		end
	end
endmodule
	

