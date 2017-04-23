/*--------------------------------------------------------------------------------
--                     Detector del Start of Frame                 		--
-- * 1.0                                                          		--
-- Descripcion:                                                   		--
--    	SoF Detect	                          				--
--Analiza la información en Miller modificado y detecta el simbolo "Z"(SoF)	--
--	Test bench de este archivo en tb_mill_modif_demod.v			--
--------------------------------------------------------------------------------*/

module SoF_Detect #(parameter N = 6)(in_clk, in_data, out_enable, in_pause, in_PoR, in_y_detected);

	input in_clk;			//Clock a fc/4 = 13.56MHz/4
	input in_data;			//Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
	input in_pause;			//Entrada que viene desde el detector de pause
	input in_PoR;			//Power On Reset
	input in_y_detected;	//Cuando el Detector de End of Frame detecta el EoF, pone en 1
	output reg out_enable;	//Cuando detecto el simbolo "Z", habilito el decodificador Miller
	
	reg  [N-1:0] reg_count;		//Cuento los clock para estar en la mitad del ETU
	reg reg_pause;			
	reg reg_flag;				//Bandera para manejar cuando detectar y cuando mandar a dormir el modulo
	
	always @(negedge in_clk, posedge in_pause) begin
		if(~in_PoR) begin	//Inicializo todo	
			reg_pause <= 1'b0;
			reg_flag <= 1'b0;
			reg_count <= {N-1{1'b0}};		
			out_enable <= 1'b0;
		end
	if(in_pause) begin		//Tomo el valor de la entrada y lo pongo en un registro
	reg_pause <= in_pause;
      end	
		if(~reg_flag) begin	//Si el flag esta en 0, busco detectar el simbolo Z
			if(in_pause) begin
				reg_count <= reg_count +1;
				if(reg_count == {1'b1,{N-1{1'b0}}}) begin
					out_enable <= 1'b1;				//Pongo la salida en 1
					reg_flag <= 1'b1;				//Cambio el flag
				end		
			end		
		end else begin
			if(in_y_detected == 1'b1) begin
				reg_flag <= 1'b0;
			end
			
		end
	end
endmodule
	

