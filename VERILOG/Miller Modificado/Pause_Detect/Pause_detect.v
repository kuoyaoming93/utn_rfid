/*------------------------------------------------------------------------
/*------------------------------------------------------------------------
--                     Codificador Manchester                     	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Codificador manchester 		                          	--
--Ingresa el frame a enviar y sale codificado (codificacion manchester) --
--	Test bench de este archivo en tb_manch_mod.v			--
------------------------------------------------------------------------*/
module man_mod #(clk, in_enable, in_miller, out_pause_detected);

input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_miller;	//Bit de habilitacion del modulo
output out_pause_detected;	//Salida del codificador manchester

wire [1:0]aux = {in_data, in_miller};

assign out_pause_detected = (aux == 3'b00) ?1'b1:
											1'b0;  

endmodule