/*------------------------------------------------------------------
--                     Decodificador Miller                       --
--                                                                --
-- Author:                                                        --
-- * Yao-Ming Kuo,   yaomingk@inti.gob.ar                         --
--                                                                --
-- Date:                                                          --
-- * 06/03/2017                                                   --
--                                                                --
-- Version:                                                       --
-- * 1.0                                                          --
--                                                                --
-- Copyright (c) 2017 						UTN.BA				  --
--                                                                --
--                                                                --
-- Descripcion:                                                   --
--    Decodificador Miller   		                              --
------------------------------------------------------------------*/


module miller_demod(clk,in_data,out_data);

input clk,in_data;
output out_data;

reg out_data;
reg aux;				// Registro auxiliar que me permite saber el estado anterior
reg out_aux;			// Salida auxiliar

always @(posedge clk) begin
	if () begin 
		out_data 	<= clk;
	end

	else begin
		out_data 	<= ~clk;
	end
end

always @(negedge in_data) begin
	if (rst) begin
		// reset
		
	end
	else if () begin
		
	end
end

endmodule