// Graphics Gremlin
//
// Copyright (c) 2021 Eric Schlaepfer
// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
// International License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.
//

`timescale 1 ps / 1 ps

module cga_vgaport(
    input clk,

    input[3:0] video,

    // Analog outputs
    output[5:0] red,
    output[6:0] green,
    output[5:0] blue
    );

    reg[17:0] c;

    assign blue = c[5:0];
    assign green = {c[11:6], 1'b1}; // FIXME: 1?
    assign red = c[17:12];

    initial begin
        $display("cga_vgaport");
    end

    always @(posedge clk)
    begin
        case(video)
            4'h0: begin c <= 18'b000000_000000_000000; $display("video %h", video); end
            4'h1: begin c <= 18'b000000_000000_101010; $display("video %h", video); end
            4'h2: begin c <= 18'b000000_101010_000000; $display("video %h", video); end
            4'h3: begin c <= 18'b000000_101010_101010; $display("video %h", video); end
            4'h4: begin c <= 18'b101010_000000_000000; $display("video %h", video); end
            4'h5: begin c <= 18'b101010_000000_101010; $display("video %h", video); end
            4'h6: begin c <= 18'b101010_010101_000000; $display("video %h", video); end // Brown!
            4'h7: begin c <= 18'b101010_101010_101010; $display("video %h", video); end
            4'h8: begin c <= 18'b010101_010101_010101; $display("video %h", video); end
            4'h9: begin c <= 18'b010101_010101_111111; $display("video %h", video); end
            4'hA: begin c <= 18'b010101_111111_010101; $display("video %h", video); end
            4'hB: begin c <= 18'b010101_111111_111111; $display("video %h", video); end
            4'hC: begin c <= 18'b111111_010101_010101; $display("video %h", video); end
            4'hD: begin c <= 18'b111111_010101_111111; $display("video %h", video); end
            4'hE: begin c <= 18'b111111_111111_010101; $display("video %h", video); end
            4'hF: begin c <= 18'b111111_111111_111111; $display("video %h", video); end
            default: $display("video %h", video);
        endcase
    end
endmodule
