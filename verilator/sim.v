`timescale 1ns/1ns

module top (

   input clk_28_636, // i
   input clk_25,     // i
   input clk_14_318, // i
	input reset,

   //.pal(),        // i
   //.scandouble(), // i

   output ce_pix,     // o

   output HBlank,     // o
   output HSync,      // o
   output VBlank,     // o
   output VSync,      // o

   output VGA_R,      // o 5:0  ?? 7:0
   output VGA_G,      // o 5:0  ?? 7:0
   output VGA_B,      // o 5:0  ?? 7:0

   output SRAM_WE_n,  // o
   output SRAM_A,     // o 20:0
   inout SRAM_D,     // io 7:0

   output LED,        // o

   output AUDIO_L,    // o
   output AUDIO_R,    // o

   inout PS2CLKA,    // io
   inout PS2CLKB,    // io
   inout PS2DATA,    // io
   inout PS2DATB,    // io

   output SD_nCS,     // o
   output SD_DI,      // o
   output SD_CK,      // o
   output SD_DO,      // o

   input P_A,        // i
   input P_U,        // i
   input P_D,        // i
   input P_L,        // i
   input P_R,        // i
   input P_tr,        // i	

	input			   ioctl_download,
	input			   ioctl_wr,
	input [24:0]	ioctl_addr,
	input [7:0]		ioctl_dout,
	input [7:0]		ioctl_index,
	output reg		ioctl_wait=1'b0
);
   
next186 next186 (
   .clk_28_636(), // i
   .clk_25(),     // i
   .clk_14_318(), // i
   .reset(),      // i
	
   .pal(),        // i
   .scandouble(), // i

   .ce_pix(),     // o

   .HBlank(),     // o
   .HSync(),      // o
   .VBlank(),     // o
   .VSync(),      // o

   .VGA_R(),      // o 5:0
   .VGA_G(),      // o 5:0
   .VGA_B(),      // o 5:0

   .SRAM_WE_n(),  // o
   .SRAM_A(),     // o 20:0
   .SRAM_D(),     // io 7:0

   .LED(),        // o

   .AUDIO_L(),    // o
   .AUDIO_R(),    // o

   .PS2CLKA(),    // io
   .PS2CLKB(),    // io
   .PS2DATA(),    // io
   .PS2DATB(),    // io

   .SD_nCS(),     // o
   .SD_DI(),      // o
   .SD_CK(),      // o
   .SD_DO(),      // o

   .P_A(),        // i
   .P_U(),        // i
   .P_D(),        // i
   .P_L(),        // i
   .P_R(),        // i
   .P_tr()        // i	
);
   
endmodule
