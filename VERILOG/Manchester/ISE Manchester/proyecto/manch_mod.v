/*------------------------------------------------------------------------
--                     Codificador Manchester                     	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Codificador manchester 		                          	--
--Ingresa el frame a enviar y sale codificado (codificacion manchester) --
--	Test bench de este archivo en tb_manch_mod.v			--
------------------------------------------------------------------------*/

module man_mod #(parameter N = 3)(clk, in_enable, in_data, out_data);

input clk;			//Clock de fc/16 en RFID (847,5 KHz)
input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output out_data;	//Salida del codificador manchester

/*reg in_aux =0;*/
reg  [N-1:0] count;	//Cuento los cuatro clock para estar en la mitad del ETU
reg etu;					//0 si se está en la primer mitad del etu - 1 si se está en la segunda mitad
wire [2:0]aux = {in_enable,etu,in_data};

always @ (negedge clk, negedge in_enable) begin
	/*in_aux <= in_data; */  
   if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida y el contador en 0 (cero)
		etu <= 1'b0;
		count <= {N{1'b0}};
	end 
	else begin
		count <= count +1'b1;
		if(count == 3'b100) begin	//Cuando cuento la mitad de los clocks que entran en un etu
			etu <= ~etu;					//invierto el etu
			count <= 3'b001;			//reseteo el contador
		end    	
	end
end

assign out_data = (aux == 3'b100) ?1'b1:
						(aux == 3'b101) ?clk:
						(aux == 3'b110) ?clk:
						(aux == 3'b111) ?1'b1:
						(aux == 3'b000) ?1'b0:
						(aux == 3'b001) ?1'b0:
						(aux == 3'b010) ?1'b0:
												1'b0;  

endmodule