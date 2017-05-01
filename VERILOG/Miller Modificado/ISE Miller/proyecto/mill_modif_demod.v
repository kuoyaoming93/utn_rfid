/*------------------------------------------------------------------------
--                     Decodificador Miller Modificado                 	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Decodificador manchester	                          	--
--Ingresa el frame recibido en codificacion miller mod y sale en NRZ-L	--
--	Test bench de este archivo en tb_mill_modif_demod.v		--
------------------------------------------------------------------------*/

module mill_modif_demod #(parameter N = 3)(clk, in_enable, in_data, out_data);

input clk;		//Clock de fc/16 en RFID (847,5 KHz)
input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output reg out_data;	//Salida del decodificador miller modificado

reg  [N-1:0] count;	//Cuento los cuatro clock para estar en la mitad del ETU
reg etu;		//0 si se está en la primer mitad del etu / 1 si se está en la segunda mitad
reg pre_out;		//Usado para ir haciendole AND a cada bit que llega por in_data

always @ (negedge clk, negedge in_enable) begin
	if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida, los registros y el contador en 0 (cero)
		out_data <= 1'b0;
		etu <= 1'b0;	
		count <= {N{1'b0}};
		pre_out <= 1'b1;
	end 
	else begin
		count <= count +1'b1;     
      if(count == 3'b100) begin		//Cuando cuento la mitad de los clocks que entran en un etu
			if(etu) begin			//Cuando estoy en el segunda mitad del ETU es porque estoy en el final del mismo
				out_data <= pre_out;		//Le cargo el valor obtenido en el registro
				pre_out <= 1'b1;		//Reseteo el registro
			end
			etu = ~ etu;			//invierto el etu
			count <= 3'b001;		//reseteo el contador
      end 
		else begin			//Va a entrar cuando sea menor a 3'b001
			if(~etu) begin
				pre_out = pre_out & in_data;	//Voy haciendo AND con los datos que llegan
			end 
			else begin
				pre_out = pre_out & ~in_data;	//Voy haciendo AND con los datos que llegan negados
			end
      end
	end
end
	 	    
/*always @ (posedge clk, negedge in_enable) begin
	if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida, los registros y el contador en 0 (cero)
		out_data <= 1'b0;
		etu <= 1'b0;
		count <= {N{1'b0}};	
		pre_out <= 1'b1;
	end 
end  */
endmodule