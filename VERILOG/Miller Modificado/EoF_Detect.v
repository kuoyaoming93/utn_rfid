/*------------------------------------------------------------------------
--                     Detector End of File Miller                 	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	EoF Detect	                          						--
--  Detecta el simbolo de EoF y finaliza la detección				--
------------------------------------------------------------------------*/

module EoF_Detect #(parameter N = 7)(in_clk, in_PoR, in_z_detected, in_data, out_data);

input in_clk;			// Clock de fc/16 en RFID (847,5 KHz).
input in_z_detected;	// Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU).
input in_data;			// Bit de habilitacion del modulo.
input in_PoR;			// Power on Reset.
output reg out_data;	// Salida del decodificador miller modificado.

reg [N-1:0] reg_count;	// Cuento los cuatro clock para estar en la mitad del ETU.
reg reg_y_detected;		// Cuando se detecta el simbolo, el modulo se desactiva.

always @ (negedge in_clk)
begin
	if(~in_PoR)					// Con el PoR inicializo los registros y la salida.
	begin
		reg_count <= {N{1'b0}};
		out_data <= 1'b0;
		reg_y_detected <= 1'b0;
	end

	if(~reg_y_detected)			// Mientras no se detecte el simbolo "Y" el modulo esta activo.
	begin
		if(~in_data)			// Los datos siempre son '1' durante el simbolo "Y".
		begin
			reg_count <= {N{1'b0}};
		end

	   	if(in_z_detected)		// Funciona solo si ya se detecto el SoF (Start of Frame)
	   	begin
			reg_count <= reg_count + 1;
			if(reg_count == 7'b1000000 )	// Si cuenta 64 pulsos de clock (2 ETU's), es un simbolo "Y".
			begin
				out_data <= 1'b1;			// Salida en '1'.
				reg_count <= {N{1'b0}};		// Contador en '0'
				reg_y_detected <= 1'b1;		// Bandera para detectar el simbolo "Y".
			end
	   	end
	end
end
endmodule