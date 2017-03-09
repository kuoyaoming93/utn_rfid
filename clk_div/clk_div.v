module frequency_divider_by2 ( in_clk ,in_rst,out_clk );
output reg out_clk;
input in_clk ;
input in_rst;
always @(posedge in_clk)
begin
if (~in_rst)
     out_clk <= 1'b0;
else
     out_clk <= ~out_clk;	
end
endmodule