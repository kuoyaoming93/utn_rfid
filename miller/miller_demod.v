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


module miller_demod(clk,in_enable,in_data,out_data);

input clk,in_enable,in_data;
output out_data;

reg out_data;

parameter [1:0] 	IDLE_S 		= 1,
					S1_S		= 2,
					S2_S		= 3;
reg 	[1:0]		state_reg, state_next;


always @(posedge clk) begin : sec
	if(!in_enable) begin
		state_reg <= IDLE_S;
	end else begin
		state_reg <= state_next;
	end
end

always @(in_data or state_reg) 
begin : fsm
	case (state_reg)
		IDLE_S:
		begin
			if ((!in_data)&&(in_enable)) begin
				state_next 	<= S1_S;
			end
			else begin
				state_next	<= S2_S;
			end
			out_data		<= 1'b0;
		end
		S1_S:
		begin
			out_data		<= 1'b1;
			
			if ((!in_data)&&(in_enable)) begin
				state_next	<= S1_S;
			end
			else begin
				state_next		<= S2_S;
			end
		end
		S2_S:		
		begin
			out_data		<= 1'b0;
			if ((!in_data)&&(in_enable)) begin
				state_next	<= S1_S;
			end
		end
	endcase
end

endmodule