//-------------------------------------------------------------------------------------------------
module rom
//-------------------------------------------------------------------------------------------------
#
(
	parameter DW = 8,
	parameter AW = 14,
	parameter FN = ""
)
(
	input  wire         clock,
	input  wire         ce,
	output reg [DW-1:0] data_out,
	input  wire[AW-1:0] a
);
//-------------------------------------------------------------------------------------------------

reg[DW-1:0] d[(2**AW)-1:0];
initial $readmemb(FN, d, 0);

always @(posedge clock) if(ce) data_out<= d[a];

//-------------------------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------------------------
