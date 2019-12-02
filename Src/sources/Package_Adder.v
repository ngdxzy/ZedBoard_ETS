`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2019 09:46:11 AM
// Design Name: 
// Module Name: Package_Adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Package_Adder(
	input clk,
	input reset,
	input enable,
	input clr,
	input [7:0] data_in,
	output reg [31:0] data_out_7,
	output reg [31:0] data_out_6,
	output reg [31:0] data_out_5,
	output reg [31:0] data_out_4,
	output reg [31:0] data_out_3,
	output reg [31:0] data_out_2,
	output reg [31:0] data_out_1,
	output reg [31:0] data_out_0
    );

	always @ (posedge clk or posedge reset) begin
		if(reset) begin
			data_out_7 <= 0;
			data_out_6 <= 0;
			data_out_5 <= 0;
			data_out_4 <= 0;
			data_out_3 <= 0;
			data_out_2 <= 0;
			data_out_1 <= 0;
			data_out_0 <= 0;
		end
		else if (clr)begin
			data_out_7 <= 0;
			data_out_6 <= 0;
			data_out_5 <= 0;
			data_out_4 <= 0;
			data_out_3 <= 0;
			data_out_2 <= 0;
			data_out_1 <= 0;
			data_out_0 <= 0;
		end
		else if(enable) begin
			data_out_7 <= data_out_7 + data_in[7];
			data_out_6 <= data_out_6 + data_in[6];
			data_out_5 <= data_out_5 + data_in[5];
			data_out_4 <= data_out_4 + data_in[4];
			data_out_3 <= data_out_3 + data_in[3];
			data_out_2 <= data_out_2 + data_in[2];
			data_out_1 <= data_out_1 + data_in[1];
			data_out_0 <= data_out_0 + data_in[0];
		end
	end
endmodule
