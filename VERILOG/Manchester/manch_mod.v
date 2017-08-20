/*------------------------------------------------------------------------
--                     Codificador Manchester                     	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Codificador manchester 		                          	--
--Ingresa el frame a enviar y sale codificado (codificacion manchester) --
--	Test bench de este archivo en tb_manch_mod.v			--
------------------------------------------------------------------------*/
module man_mod #(parameter N = 4)(clk, in_enable, in_data, out_data);

input clk;			//Clock de fc/4 en RFID (3.39 MHz)
input in_data;		//Informacion - ETU de 106Kb/s (32 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output out_data;	//Salida del codificador manchester

reg  [N-1:0] count;	//Cuento los 16 clock para estar en la mitad del ETU
reg etu;	//0 si se está en la primer mitad del etu - 1 si se está en la segunda mitad
reg start;	//Flag para no contar el primer clock y quedar defasados con respecto a in_data
wire [2:0]aux = {in_enable, etu, in_data};

always @ (negedge clk, negedge in_enable) begin
	/*in_aux <= in_data; */
   if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida y el contador en 0 (cero)
		etu <= 1'b0;
		count <= {N{1'b0}};
	   start <= 1'b0;
	end 
	else begin
		if(start == 1'b1) begin
		count <= count +1'b1;
		if(count == {N{1'b1}}) begin	//Cuando cuento la mitad de los clocks que entran en un etu
			etu <= ~ etu;			//invierto el etu
			count <= {N{1'b0}};		//reseteo el contador
		end    	
		end begin
			start <= 1'b1;
		end
	end
end

assign out_data = 		(aux == 3'b000) ?1'b0:
						(aux == 3'b001) ?1'b0:
						(aux == 3'b010) ?1'b0:
						(aux == 3'b100) ?1'b1:
						(aux == 3'b101) ?clk:
						(aux == 3'b110) ?clk:
						(aux == 3'b111) ?1'b1:						
										 1'b0;  

endmodule