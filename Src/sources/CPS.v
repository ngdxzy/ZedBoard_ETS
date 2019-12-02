`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 10:20:46 AM
// Design Name: 
// Module Name: CPS
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


module CPS#(
	parameter integer MULTI = 12,
	parameter integer DIV = 1,
	parameter integer CLOCK_DIV = 12,
	parameter integer PULSE_DIV = 120,
	parameter integer CLK8DIV = 6,
	parameter integer SWEEP_DIV = 119,
	parameter integer CLK_IN_PERIOD = 10
	)(
	
	input clock_in,
	input reset,
	output shift_clock_out,
	output shift_clock_out_inv,
	output clock_out,
	output clock_out_inv,
	output clock8_out,
	output clock8_out_inv,
	output pulse_out,
	output sweep,
	output locked,
	output sync,

	input [15:0] drp_din,
	output [15:0] drp_dout,
	input [6:0] drp_addr,
	input drp_en,
	input drp_we,
	input drp_clk,
	output drp_ready,
	
	input pulse_switch,
	input ps_clk,
	input ps_shift,
	input ps_incdec,
	output reg ps_done
    );
	wire PULSE,PULSE_INV;
	wire CLKFBOUT,CLKFBIN;
	wire CLKOUT0,CLKOUT0B;
	wire CLKOUT1,CLKOUT1B;
	wire CLKOUT2,CLKOUT2B;
	wire CLKOUT5;
	reg shift_r;
	wire shift_start = ps_shift & (~shift_r);
	wire psdone;
	wire shifting_clock;
	wire shifting_clock_inv;
	reg shift_en;
	MMCME2_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (OPTIMIZED, HIGH, LOW)
		.CLKFBOUT_MULT_F(MULTI),          // Multiply value for all CLKOUT (2.000-64.000).
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000).
		// CLKIN_PERIOD: Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_IN_PERIOD),
		.CLKIN2_PERIOD(0.0),
		// CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
		.CLKOUT1_DIVIDE(CLOCK_DIV),
		.CLKOUT2_DIVIDE(CLK8DIV),
		.CLKOUT3_DIVIDE(PULSE_DIV),
		.CLKOUT4_DIVIDE(PULSE_DIV),
		.CLKOUT5_DIVIDE(SWEEP_DIV),
		.CLKOUT6_DIVIDE(PULSE_DIV),
		.CLKOUT0_DIVIDE_F(CLOCK_DIV),         // Divide amount for CLKOUT0 (1.000-128.000).
		// CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
		.CLKOUT0_DUTY_CYCLE(0.5),
		.CLKOUT1_DUTY_CYCLE(0.5),
		.CLKOUT2_DUTY_CYCLE(0.5),
		.CLKOUT3_DUTY_CYCLE(0.5),
		.CLKOUT4_DUTY_CYCLE(0.5),
		.CLKOUT5_DUTY_CYCLE(0.5),
		.CLKOUT6_DUTY_CYCLE(0.5),
		// CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
		.CLKOUT0_PHASE(0),
		.CLKOUT1_PHASE(0.0),
		.CLKOUT2_PHASE(0.0),
		.CLKOUT3_PHASE(0.0),
		.CLKOUT4_PHASE(3.750),
		.CLKOUT5_PHASE(0),
		.CLKOUT6_PHASE(0.0),
		.CLKOUT4_CASCADE("FALSE"),      // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
		.COMPENSATION("ZHOLD"),         // ZHOLD, BUF_IN, EXTERNAL, INTERNAL
		.DIVCLK_DIVIDE(DIV),              // Master division value (1-106)
		// REF_JITTER: Reference input jitter in UI (0.000-0.999).
		.REF_JITTER1(0.0),
		.REF_JITTER2(0.0),
		.STARTUP_WAIT("FALSE"),         // Delays DONE until MMCM is locked (FALSE, TRUE)
		// Spread Spectrum: Spread Spectrum Attributes
		.SS_EN("FALSE"),                // Enables spread spectrum (FALSE, TRUE)
		.SS_MODE("CENTER_HIGH"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
		.SS_MOD_PERIOD(10000),          // Spread spectrum modulation period (ns) (VALUES)
		// USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
		.CLKFBOUT_USE_FINE_PS("FALSE"),
		.CLKOUT0_USE_FINE_PS("FALSE"),
		.CLKOUT1_USE_FINE_PS("TRUE"),
		.CLKOUT2_USE_FINE_PS("TRUE"),
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE")
	)
	MMCME2_ADV_inst (
		// Clock Outputs: 1-bit (each) output: User configurable clock outputs
		.CLKOUT0(CLKOUT0),           // 1-bit output: CLKOUT0
		.CLKOUT0B(CLKOUT0B),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT1),           // 1-bit output: CLKOUT1
		.CLKOUT1B(CLKOUT1B),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(CLKOUT2),           // 1-bit output: CLKOUT2
		.CLKOUT2B(CLKOUT2B),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(PULSE),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(PULSE_INV),           // 1-bit output: CLKOUT4
		.CLKOUT5(CLKOUT5),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
		.DO(drp_dout),                     // 16-bit output: DRP data
		.DRDY(drp_ready),                 // 1-bit output: DRP ready
		// Feedback Clocks: 1-bit (each) output: Clock feedback ports
		.CLKFBOUT(CLKFBOUT),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports: 1-bit (each) output: MMCM status ports
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(locked),             // 1-bit output: LOCK
		// Clock Inputs: 1-bit (each) input: Clock inputs
		.CLKIN1(clock_in),             // 1-bit input: Primary clock
		.CLKIN2(0),             // 1-bit input: Secondary clock
		// Control Ports: 1-bit (each) input: MMCM control ports
		.CLKINSEL(1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(0),             // 1-bit input: Power-down
		.RST(0),                   // 1-bit input: Reset
		// DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
		.DADDR(drp_addr),               // 7-bit input: DRP address
		.DCLK(drp_clk),                 // 1-bit input: DRP clock
		.DEN(drp_en),                   // 1-bit input: DRP enable
		.DI(drp_din),                     // 16-bit input: DRP data
		.DWE(drp_we),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
		// Dynamic Phase Shift Ports: 1-bit (each) output: Ports used for dynamic phase shifting of the outputs
		.PSDONE(psdone),             // 1-bit output: Phase shift done
		.PSCLK(ps_clk),               // 1-bit input: Phase shift clock
		.PSEN(shift_en),                 // 1-bit input: Phase shift enable
		.PSINCDEC(ps_incdec),         // 1-bit input: Phase shift increment/decrement
		// Feedback Clocks: 1-bit (each) input: Clock feedback ports
		.CLKFBIN(CLKFBIN)            // 1-bit input: Feedback clock
	);
	
	wire pulse_p,pulse_n;
	BUFG BUFG_PULSE(
	.O(pulse_p), // 1-bit output: Clock output
	.I(PULSE)  // 1-bit input: Clock input
	);
	BUFG BUFG_PULSE_INV(
	.O(pulse_n), // 1-bit output: Clock output
	.I(PULSE_INV)  // 1-bit input: Clock input
	);

	BUFG BUFG_FEEDBACK(
	.O(CLKFBIN), // 1-bit output: Clock output
	.I(CLKFBOUT)  // 1-bit input: Clock input
	);

	BUFG BUFG_OUT0(
	.O(clock_out), // 1-bit output: Clock output
	.I(CLKOUT0)  // 1-bit input: Clock input
	);
	BUFG BUFG_OUT0B(
	.O(clock_out_inv), // 1-bit output: Clock output
	.I(CLKOUT0B)  // 1-bit input: Clock input
	);

	BUFG BUFG_OUT2(
	.O(clock8_out), // 1-bit output: Clock output
	.I(CLKOUT2)  // 1-bit input: Clock input
	);
	BUFG BUFG_OUT2B(
	.O(clock8_out_inv), // 1-bit output: Clock output
	.I(CLKOUT2B)  // 1-bit input: Clock input
	);

	BUFG BUFG_OUT1(
	.O(shift_clock_out), // 1-bit output: Clock output
	.I(CLKOUT1)  // 1-bit input: Clock input
	);
	BUFG BUFG_OUT1B(
	.O(shift_clock_out_inv), // 1-bit output: Clock output
	.I(CLKOUT1B)  // 1-bit input: Clock input
	);
	BUFG BUFG_OUT5(
	.O(sweep), // 1-bit output: Clock output
	.I(CLKOUT5)  // 1-bit input: Clock input
	);

	always @(posedge ps_clk) begin
		shift_r <= ps_shift;
	end
	localparam IDLE = 2'b00;
	localparam SHIFT = 2'b01;
	localparam WAIT = 2'b11;
	localparam ACK = 2'b10;
	reg [1:0] state,next_state;

	always @ (posedge ps_clk or posedge reset) begin
		if(reset) begin
			state <= IDLE;
		end
		else begin
			state <= next_state;
		end
	end
	always @ (*) begin
		next_state = state;
		shift_en = 0;
		ps_done = 0;
		case(state)
		IDLE:begin
			if(shift_start) begin
				next_state = SHIFT;
			end
		end
		SHIFT:begin
			next_state = WAIT;
			shift_en = 1;
		end
		WAIT:begin
			if(psdone == 1) begin
				next_state = ACK;
			end
		end
		ACK:begin
			if(~ps_shift) begin
				next_state = IDLE;
			end
			ps_done = 1;
		end
		endcase
	end

	assign pulse_out = pulse_switch?(pulse_p & pulse_n):pulse_p;
	reg [1:0] sync_reg;
	always @(posedge shift_clock_out) begin
		sync_reg <= {sync_reg[0],pulse_p};
	end
	assign sync = sync_reg == 2'b10;
endmodule

