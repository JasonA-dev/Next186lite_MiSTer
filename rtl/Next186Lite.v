
module Next186Lite
(
	input         clk,
	input         reset,
	
	input         pal,
	input         scandouble,

	output reg    ce_pix,

	output reg    HBlank,
	output reg    HSync,
	output reg    VBlank,
	output reg    VSync,

	output  [7:0] video,

	input  wire CLK_50MHZ,
	input  wire clk_28_636,
	input  wire clk_25,
	input  wire clk_14_318,

	output wire [5:0]VGA_R,
	output wire [5:0]VGA_G,
	output wire [5:0]VGA_B,
	output wire VGA_HSYNC,
	output wire VGA_VSYNC,

	output wire SRAM_WE_n,
	output wire [20:0]SRAM_A,
	inout  wire [7:0]SRAM_D,

	output wire LED,

	output wire AUDIO_L,
	output wire AUDIO_R,

	inout  wire PS2CLKA,
	inout  wire PS2CLKB,
	inout  wire PS2DATA,
	inout  wire PS2DATB,

	output wire SD_nCS,
	output wire SD_DI,
	output wire SD_CK,
	input  wire SD_DO,

	input  wire P_A,
	input  wire P_U,
	input  wire P_D,
	input  wire P_L,
	input  wire P_R,
	input  wire P_tr	
);

reg   [9:0] hc;
reg   [9:0] vc;
reg   [9:0] vvc;
reg  [63:0] rnd_reg;

wire  [5:0] rnd_c = {rnd_reg[0],rnd_reg[1],rnd_reg[2],rnd_reg[2],rnd_reg[2],rnd_reg[2]};
wire [63:0] rnd;

lfsr random(rnd);

/*
always @(posedge clk) begin
	if(scandouble) ce_pix <= 1;
		else ce_pix <= ~ce_pix;

	if(reset) begin
		hc <= 0;
		vc <= 0;
	end
	else if(ce_pix) begin
		if(hc == 637) begin
			hc <= 0;
			if(vc == (pal ? (scandouble ? 623 : 311) : (scandouble ? 523 : 261))) begin 
				vc <= 0;
				vvc <= vvc + 9'd6;
			end else begin
				vc <= vc + 1'd1;
			end
		end else begin
			hc <= hc + 1'd1;
		end

		rnd_reg <= rnd;
	end
end

always @(posedge clk) begin
	if (hc == 529) HBlank <= 1;
		else if (hc == 0) HBlank <= 0;

	if (hc == 544) begin
		HSync <= 1;

		if(pal) begin
			if(vc == (scandouble ? 609 : 304)) VSync <= 1;
				else if (vc == (scandouble ? 617 : 308)) VSync <= 0;

			if(vc == (scandouble ? 601 : 300)) VBlank <= 1;
				else if (vc == 0) VBlank <= 0;
		end
		else begin
			if(vc == (scandouble ? 490 : 245)) VSync <= 1;
				else if (vc == (scandouble ? 496 : 248)) VSync <= 0;

			if(vc == (scandouble ? 480 : 240)) VBlank <= 1;
				else if (vc == 0) VBlank <= 0;
		end
	end
	
	if (hc == 590) HSync <= 0;
end

reg  [7:0] cos_out;
wire [5:0] cos_g = cos_out[7:3]+6'd32;
cos cos(vvc + {vc>>scandouble, 2'b00}, cos_out);

assign video = (cos_g >= rnd_c) ? {cos_g - rnd_c, 2'b00} : 8'd0;
*/

	//wire [5:0] r, g, b;	
	reg [5:0] raux, gaux, baux;
	wire [1:0] monochrome_switcher;
	
/*		
	reg [5:0]red_weight[0:63] = { // 0.2126*R
	6'h00, 6'h01, 6'h01, 6'h01, 6'h01, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h04,
	6'h04, 6'h04, 6'h04, 6'h05, 6'h05, 6'h05, 6'h05, 6'h05, 6'h06, 6'h06, 6'h06, 6'h06, 6'h06, 6'h07, 6'h07, 6'h07,
	6'h07, 6'h08, 6'h08, 6'h08, 6'h08, 6'h08, 6'h09, 6'h09, 6'h09, 6'h09, 6'h09, 6'h0a, 6'h0a, 6'h0a, 6'h0a, 6'h0a,
	6'h0b, 6'h0b, 6'h0b, 6'h0b, 6'h0c, 6'h0c, 6'h0c, 6'h0c, 6'h0c, 6'h0d, 6'h0d, 6'h0d, 6'h0d, 6'h0d, 6'h0e, 6'h0e
	};
	
	reg [5:0]green_weight[0:63] = { // 0.7152*G
	6'h00, 6'h01, 6'h02, 6'h03, 6'h03, 6'h04, 6'h05, 6'h06, 6'h06, 6'h07, 6'h08, 6'h08, 6'h09, 6'h0a, 6'h0b, 6'h0b,
	6'h0c, 6'h0d, 6'h0d, 6'h0e, 6'h0f, 6'h10, 6'h10, 6'h11, 6'h12, 6'h12, 6'h13, 6'h14, 6'h15, 6'h15, 6'h16, 6'h17,
	6'h17, 6'h18, 6'h19, 6'h1a, 6'h1a, 6'h1b, 6'h1c, 6'h1c, 6'h1d, 6'h1e, 6'h1f, 6'h1f, 6'h20, 6'h21, 6'h21, 6'h22,
	6'h23, 6'h24, 6'h24, 6'h25, 6'h26, 6'h26, 6'h27, 6'h28, 6'h29, 6'h29, 6'h2a, 6'h2a, 6'h2a, 6'h2b, 6'h2b, 6'h2b
	};
	
	reg [5:0]blue_weight[0:63] = { // 0.0722*B
	6'h00, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h01, 6'h02, 6'h02,
	6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h02, 6'h03, 6'h03, 6'h03, 6'h03,
	6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h03, 6'h04, 6'h04, 6'h04, 6'h04, 6'h04, 6'h04,
	6'h04, 6'h04, 6'h04, 6'h04, 6'h04, 6'h04, 6'h04, 6'h04, 6'h05, 6'h05, 6'h05, 6'h05, 6'h05, 6'h05, 6'h05, 6'h05
	};
*/

	system_2MB sys_inst
	(	
		.clk_vga(clk_28_636),		// i
		.clk_cpu_base(clk_14_318),	// i
		.clk_sdr(clk_14_318), 		// i
		.clk_sram(clk_28_636), 		// i
		.clk_25(clk_25),			// i
		
		.VGA_R(VGA_R),					// o 5
		.VGA_G(VGA_G),					// o 5
		.VGA_B(VGA_B),					// o 5

		.VGA_HSYNC(HSync),		// o
		.VGA_VSYNC(VSync),		// o

		.HBlank(HBlank),	// o
		.VBlank(VBlank),	// o

		.SRAM_ADDR(SRAM_A),			// o 20
		.SRAM_DATA(SRAM_D),			// io 7
		.SRAM_WE_n(SRAM_WE_n),		// o

		.LED(LED),					// o

		.SD_n_CS(SD_nCS),			// o
		.SD_DI(SD_DI),				// o
		.SD_CK(SD_CK),				// o
		.SD_DO(SD_DO),				// i

		.AUD_L(AUDIO_L),			// o
		.AUD_R(AUDIO_R),			// o

	 	.PS2_CLK1(PS2CLKA),			// io
		.PS2_CLK2(PS2CLKB),			// io
		.PS2_DATA1(PS2DATA),		// io
		.PS2_DATA2(PS2DATB),		// io

		.monochrome_switcher(monochrome_switcher),		// o 1

		.joy_up(P_U),				// i
		.joy_down(P_D),				// i
		.joy_left(P_L),				// i
		.joy_right(P_R),			// i
		.joy_fire1(P_tr),			// i
		.joy_fire2(P_A)				// i
);

/*
	always @ (monochrome_switcher, r, g, b) begin
		case(monochrome_switcher)
			// Verde
			2'b01	: begin
				raux = 6'b0;
				gaux = red_weight[r] + green_weight[g] + blue_weight[b];				
				baux = 6'b0;
			end
			// Ambar
			2'b10	: begin
				raux = red_weight[r] + green_weight[g] + blue_weight[b];
				gaux = (red_weight[r] + green_weight[g] + blue_weight[b]) >> 1;
				baux = 6'b0;
			end
			// Blanco y negro
			2'b11	: begin
				raux = red_weight[r] + green_weight[g] + blue_weight[b];
				gaux = red_weight[r] + green_weight[g] + blue_weight[b];
				baux = red_weight[r] + green_weight[g] + blue_weight[b];
			end
			// Color
			default: begin
				raux = r;
				gaux = g;
				baux = b;
			end
		endcase
	end

	assign VGA_R = raux[5:3];
	assign VGA_G = gaux[5:3];
	assign VGA_B = baux[5:3];
*/

endmodule
