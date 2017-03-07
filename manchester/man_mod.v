/*------------------------------------------------------------------
--                     Codificador Manchester                     --
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
--    Codificador manchester 		                              --
------------------------------------------------------------------*/


module man_mod(clk,in_enable,in_data,out_data);

input clk,in_data,in_enable;
output out_data;

reg out_data;

always @(posedge clk or posedge in_enable) begin
	if (~in_enable) begin
		// reset
		out_data	<= 1'b0;
	end

	else if (in_data) begin 
		out_data 	<= clk;
	end

	else begin
		out_data 	<= ~clk;
	end
end

always @(negedge clk) begin
	// En el flanco negativo se invierte la senial, al ser un manchester
	if (~in_enable) begin
		out_data	<= 1'b0;
	end
	else begin 
		out_data <= ~out_data;
	end
end

endmodule