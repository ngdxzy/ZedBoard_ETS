`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2019 12:16:29 PM
// Design Name: 
// Module Name: ETS_Core
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


module ETS_Core#(
	parameter integer DATA_WIDTH = 8
	)(
	input clock,
	input reset,
	input start,
	input sync,
	input [DATA_WIDTH -1:0] adc_data,

	input [31:0]TIME_REQUIRED,

	output [31:0] data_out_00,
	output [31:0] data_out_01,
	output [31:0] data_out_02,
	output [31:0] data_out_03,
	output [31:0] data_out_04,
	output [31:0] data_out_05,
	output [31:0] data_out_06,
	output [31:0] data_out_07,

	output [31:0] data_out_10,
	output [31:0] data_out_11,
	output [31:0] data_out_12,
	output [31:0] data_out_13,
	output [31:0] data_out_14,
	output [31:0] data_out_15,
	output [31:0] data_out_16,
	output [31:0] data_out_17,	
	

	
	output [31:0] letf_aver,
	output done,
	output signal_generate_en

    );
 	localparam IDLE      = 4'd0;
	localparam INIT      = 4'd1;
	localparam WAIT      = 4'd2;
	localparam START     = 4'd3;
	localparam OUT       = 4'd4;
	localparam CHECK       = 4'd5;
	localparam DoubleCheck = 4'd6;
	localparam AVER_LOAD = 4'd9;
	localparam AVER_WAIT_CALM = 4'd10;
	localparam AVER_WAIT_SAMPLE = 4'd11;
	localparam AVER_DONE = 4'd12;
	localparam SYNC = 4'd15;
	
	reg [3:0] state,next_state;
	reg [31:0] TIME_COUNTER;
	reg [7:0] CALM_DONE_CNT;
	reg [1:0] en_bubble;
	wire ad_finished;
	reg load_timec_en;
	reg globle_en;
	reg impulse_en;
	reg load_en_bubble;
	reg ready;
	reg clear_data;
	always @ (posedge clock or posedge reset) begin
		if(reset) begin
			state <= SYNC;
		end
		else begin
			state <= next_state;
		end
	end

	always @ (*) begin
		next_state = state;
		load_timec_en = 0;
		ready = 0;
		clear_data = 0;
		globle_en = 0;
		impulse_en = 1;
		load_en_bubble = 0;
		case(state)
		SYNC:begin
			load_en_bubble = 1;
			if(sync) begin
				next_state = IDLE;
			end
		end
		IDLE:begin
			clear_data = 1;
			if(start) begin
				next_state <= INIT;
			end
		end
		INIT:begin
			load_timec_en = 1;
			clear_data = 1;
			next_state = CHECK;
		end
		CHECK:begin
			if(TIME_COUNTER != TIME_REQUIRED - 1) begin
				next_state = INIT;
			end
			else begin
				next_state = WAIT;
			end
		end
		WAIT:begin
			load_timec_en = 1;
			if(en_bubble[0] == 1)
				next_state = START;
		end
		START:begin
			globle_en = 1;
			if(ad_finished) begin
				next_state = OUT;
			end
		end
		OUT:begin
			ready = 1;
			if(~start) begin
				next_state = IDLE;
			end
		end
		default:begin
			next_state = IDLE;
		end
		endcase
	end
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			// reset
			en_bubble <= 2'b10;
		end
		else if(load_en_bubble)begin
			en_bubble <= 2'b10;
		end
		else begin
			en_bubble <= {en_bubble[0],en_bubble[1]};
		end
	end
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			// reset
			TIME_COUNTER <= 0;
		end
		else if (load_timec_en) begin
			TIME_COUNTER <= TIME_REQUIRED - 1;
		end
		else if(globle_en && (TIME_COUNTER > 0) && en_bubble[0])begin
			TIME_COUNTER <= TIME_COUNTER - 1;
		end
	end
	
	assign ad_finished = (TIME_COUNTER == 0) & en_bubble[0];
	assign letf_aver = TIME_COUNTER;

	
	(* ASYNC_REG = "TRUE"*)reg [DATA_WIDTH-1:0] adc_data_tree01;
	(* ASYNC_REG = "TRUE"*)reg [DATA_WIDTH-1:0] adc_data_tree02;

	always @ (posedge clock) begin
		adc_data_tree01 <= adc_data;
		adc_data_tree02 <= adc_data;
	end
	



	Package_Adder inst_Package_Adder_0(
		.clk        (clock),
		.reset      (reset),
		.enable     (globle_en & en_bubble[0]),
		.clr        (clear_data),
		.data_in    (adc_data_tree01),
		.data_out_7 (data_out_07),
		.data_out_6 (data_out_06),
		.data_out_5 (data_out_05),
		.data_out_4 (data_out_04),
		.data_out_3 (data_out_03),
		.data_out_2 (data_out_02),
		.data_out_1 (data_out_01),
		.data_out_0 (data_out_00)
	);
	Package_Adder inst_Package_Adder_1(
		.clk        (clock),
		.reset      (reset),
		.enable     (globle_en & en_bubble[1]),
		.clr        (clear_data),
		.data_in    (adc_data_tree02),
		.data_out_7 (data_out_17),
		.data_out_6 (data_out_16),
		.data_out_5 (data_out_15),
		.data_out_4 (data_out_14),
		.data_out_3 (data_out_13),
		.data_out_2 (data_out_12),
		.data_out_1 (data_out_11),
		.data_out_0 (data_out_10)
	);

	assign signal_generate_en = impulse_en;
	assign done = ready;
endmodule
