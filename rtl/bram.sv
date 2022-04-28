`timescale 1ns / 1ps

module bram #(
    parameter width_a = 8,
    parameter widthad_a = 10,
    parameter init_file= ""
) (
    // Port A
    input   wire                    clock_a,
    input   wire                    wren_a,
    input   wire    [widthad_a-3:0] address_a, // 15 - 3 = 12
    input   wire    [width_a-1:0]   data_a,    // 32 - 1 = 31
    output  reg     [width_a-1:0]   q_a,       // 32 - 1 = 31
     
    // Port B
    input   wire                    clock_b,
    input   wire                    wren_b,
    input   wire    [widthad_a-1:0] address_b, // 15 - 1 = 14
    input   wire    [width_a-25:0]  data_b,    // 32 - 25 = 7
    output  reg     [width_a-25:0]  q_b,       // 32 - 25 = 7

    input wire byteena_a,
    input wire byteena_b

/*
input clka;
input ena;
input [3 : 0] wea;
input [12 : 0] addra;
input [31 : 0] dina;
output [31 : 0] douta;
input clkb;
input enb;
input [0 : 0] web;
input [14 : 0] addrb;
input [7 : 0] dinb;
output [7 : 0] doutb;
*/

);

    initial begin
        $display("Loading rom.");
        $display(init_file);
        if (init_file>0)
        	$readmemh(init_file, mem);
    end

 
// Shared memory
reg [width_a-1:0] mem [(2**widthad_a)-1:0];
// Port A
always @(posedge clock_a) begin
	/* verilator lint_off WIDTH */      
    q_a      <= mem[address_a];
    if(wren_a) begin
        q_a      <= data_a;
        mem[address_a] <= data_a;
    end
	/* verilator lint_on WIDTH */     
end
 
// Port B
always @(posedge clock_b) begin
	/* verilator lint_off WIDTH */      
    q_b      <= mem[address_b];
    if(wren_b) begin
        q_b      <= data_b;
        mem[address_b] <= data_b;
    end
	/* verilator lint_on WIDTH */     
end
 
endmodule