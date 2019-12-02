`timescale 10ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2019 19:00:08
// Design Name: 
// Module Name: HP_CMP
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


module HP_CMP(
	input reset_n,
	input clk_8,
	input clk_8_inv,
	input adc_clk,
	input data_in,
	input ce,
	output [7:0] data_out
    );


	ISERDESE2 #(
		.DATA_RATE("DDR"),           // DDR, SDR
		.DATA_WIDTH(4),              // Parallel data width (2-8,10,14)
		.DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
		.DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
		// INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
		.INIT_Q1(1'b0),
		.INIT_Q2(1'b0),
		.INIT_Q3(1'b0),
		.INIT_Q4(1'b0),
		.INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
		.IOBDELAY("NONE"),           // NONE, BOTH, IBUF, IFD
		.NUM_CE(1),                  // Number of clock enables (1,2)
		.OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
		.SERDES_MODE("MASTER"),      // MASTER, SLAVE
		// SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
		.SRVAL_Q1(1'b0),
		.SRVAL_Q2(1'b0),
		.SRVAL_Q3(1'b0),
		.SRVAL_Q4(1'b0)
		)ISERDESE2_inst (
		// Q1 - Q8: 1-bit (each) output: Registered data outputs
		.Q1(data_out[0]),
		.Q2(data_out[1]),
		.Q3(data_out[2]),
		.Q4(data_out[3]),
		.Q5(data_out[4]),
		.Q6(data_out[5]),
		.Q7(data_out[6]),
		.Q8(data_out[7]),

		// CE1, CE2: 1-bit (each) input: Data register clock enable inputs
		// Clocks: 1-bit (each) input: ISERDESE2 clock input ports
		.CLK(clk_8_inv),                   // 1-bit input: High-speed clock
		.CLKB(~clk_8_inv),                 // 1-bit input: High-speed secondary clock
		.CLKDIV(adc_clk),             // 1-bit input: Divided clock
		// Input Data: 1-bit (each) input: ISERDESE2 data input ports
		.D(data_in),                       // 1-bit input: Data input
		.DDLY(1'b0),                 // 1-bit input: Serial data from IDELAYE2
		.RST(~reset_n),                   // 1-bit input: Active high asynchronous reset_n
		// SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1(1'b0),
		.SHIFTIN2(1'b0),
		.BITSLIP(1'b0),    
		.OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
		// Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
		.DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
		.DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
		.OFB(),                   // 1-bit input: Data feedback from OSERDESE2
		.CE1(ce),
		.CE2(1'b1),
		.OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
		.SHIFTOUT1(),
		.SHIFTOUT2(),
		.O(),                       // 1-bit output: Combinatorial output
		.CLKDIVP(1'b0)           // 1-bit input: TBD
	);


	
endmodule
