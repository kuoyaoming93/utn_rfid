/*------------------------------------------------------------------------
--                     Codificador Manchester                     	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Codificador manchester 		                          	--
--Ingresa el frame a enviar y sale codificado (codificacion manchester) --
--	Test bench de este archivo en tb_manch_mod.v			--
------------------------------------------------------------------------*/

module man_mod #(parameter N = 3)(clk, in_enable, in_data, out_data);

input clk;		//Clock de fc/16 en RFID (847,5 KHz)
input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output   out_data;	//Salida del codificador manchester

reg etu;		//0 si se está en la primer mitad del etu - 1 si se está en la segunda mitad
reg [N-1:0]count;		//Cuento los 8 flancos para estar en la mitad del ETU
reg in_aux;
wire [2:0]aux = {in_enable,etu,in_aux};
//Cuando viene un cero  ----||||, cuando hay un uno ||||----

always @(posedge clk) begin//sincronizo los datos con el flanco ascendente
    in_aux <= in_data;
end

always @(posedge clk,negedge in_enable) begin
    if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida y el contador en 0 (cero)
      count <= 3'b000;
      etu <= 1'b0;
    end
    else begin
      count <= count + 1'b1;
      if(count == 3'b100) begin	//Llego hasta 8 (dos veces por clock, en vez de 4 cuenta 8
	count<= 3'b001;		//Vuelvo a 1
	etu =  ~etu;			//Invierto el ETU
      end
    end
end
    
/*
always @ (negedge clk,negedge etu,negedge in_enable) begin
    if(in_enable) begin
	if(~etu) begin		//Si estoy en la primera mitad del ETU
            if(in_aux) begin	//Si estoy en presencia de un 1 como dato
                out_data <= clk;	//Copio el clk
            end 
            else begin 		//Si estoy en presencia de un 0 como dato
                out_data <= 1'b1;	//Pongo en 1 la salida
            end
        end 
        else begin		//Si estoy en la segunda mitad de ETU
            if(~in_aux) begin	//Si estoy en presencia de un 0 como dato
                out_data <= clk;	//Copio el clk
            end
            else begin 		//Si estoy en presencia de un 1 como dato
                out_data <= 1'b1;	//Pongo en 1 la salida
            end
        end
   end
   else begin
	out_data <= 0'b0;	//Si deshabilito el modulo, la salida va a cero
   end
end
*/

assign out_data = (aux == 3'b100) ?1'b1:
		  (aux == 3'b101) ?clk:
		  (aux == 3'b110) ?clk:
		  (aux == 3'b111) ?1'b1:
		  (aux == 3'b000) ?1'b0:
		  (aux == 3'b001) ?1'b0:
		  (aux == 3'b010) ?1'b0:
				   1'b0;

endmodule