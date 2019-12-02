`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2019 10:49:20 PM
// Design Name: 
// Module Name: ETS_System
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


module ETS_System#
	(
		// Users to add parameters here

		parameter integer MULTI = 12,
		parameter integer DIV = 1,
		parameter integer CLOCK_DIV = 12,
		parameter integer PULSE_DIV = 120,
		parameter integer CLK_IN_PERIOD = 10,
		parameter integer DATA_WIDTH = 4,
		parameter integer CLK8DIV = 6,
			// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 9
	)(
	//clock system
	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 sys_clock_in CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
	input sys_clock_in,

	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 locked_sys_clock CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
	output locked_sys_clock,
	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 locked_sys_clock_inv CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
	output locked_sys_clock_inv,

	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 shifting_clk CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
	output shifting_clk,
	output locked,
	//adc data
	input adc_clock,
	input [DATA_WIDTH-1:0] adc_data,
	output sleep,
	output sweep,
	input LVDS_CMP,
	input CMP_CMP,
	//Output Pulse
	output impulse_out,
	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clock8_out CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 400000000" *)
	output clock8_out,
	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clock8_out_inv CLK" *)
	(* X_INTERFACE_PARAMETER = "FREQ_HZ 400000000" *)
	output clock8_out_inv,

	//pll no

	input [15:0] drp_din,
	output [15:0] drp_dout,
	input [6:0] drp_addr,
	input drp_en,
	input drp_we,
	input drp_clk,
	output drp_ready,
	
	//AXI LITE PORTS
	input wire  S_AXI_ACLK,
	input wire S_AXI_ARESETN,
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
	input wire [2 : 0] S_AXI_AWPROT,
	input wire  S_AXI_AWVALID,
	output wire  S_AXI_AWREADY,
	input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
	input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
	input wire  S_AXI_WVALID,
	output wire  S_AXI_WREADY,
	output wire [1 : 0] S_AXI_BRESP,
	output wire  S_AXI_BVALID,
	input wire  S_AXI_BREADY,
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
	input wire [2 : 0] S_AXI_ARPROT,
	input wire  S_AXI_ARVALID,
	output wire  S_AXI_ARREADY,
	output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
	output wire [1 : 0] S_AXI_RRESP,
	output wire  S_AXI_RVALID,
	input wire  S_AXI_RREADY
    );
    
   
		
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg30;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg31;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg32;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg33;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg34;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg35;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg36;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg37;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg38;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg39;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg40;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg41;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg42;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg43;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg44;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg45;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg46;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg47;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg48;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg49;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg50;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg51;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg52;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg53;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg54;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg55;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg56;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg57;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg58;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg59;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg60;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg61;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg62;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg63;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg64;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg65;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg66;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg67;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg68;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg69;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg70;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg71;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg72;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg73;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg74;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg75;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg76;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg77;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg78;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg79;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg80;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg81;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg82;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg83;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg84;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg85;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg86;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg87;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg88;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg89;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg90;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg91;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg92;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg93;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg94;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg95;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg96;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg97;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg98;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg99;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg100;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg101;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg102;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg103;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg104;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg105;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg106;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg107;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg108;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg109;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg110;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg111;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg112;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg113;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg114;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg115;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg116;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg117;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg118;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg119;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg120;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg121;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg122;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg123;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg124;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg125;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg126;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg127;

		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire0 = slv_reg0;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire1 = slv_reg1;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire2 = slv_reg2;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire3 = {'d0,done_reg};
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire4 = slv_reg4;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire5 = slv_reg5;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire6 = slv_reg6;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire7 = slv_reg7;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire8 = {'d0,ps_done};
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire9 = slv_reg9;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire10 ;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire11;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire12;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire13;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire14;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire15;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire16;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire17;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire18;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire19;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire20;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire21;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire22;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire23;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire24;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire25;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire26;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire27;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire28;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire29;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire30;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire31;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire32;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire33;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire34;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire35;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire36;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire37;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire38;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire39;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire40;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire41;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire42;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire43;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire44;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire45;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire46;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire47;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire48;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire49;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire50;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire51;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire52;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire53;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire54;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire55;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire56;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire57;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire58;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire59;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire60;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire61;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire62;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire63;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire64;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire65;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire66;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire67;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire68;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire69;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire70;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire71;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire72;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire73;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire74;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire75;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire76;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire77;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire78;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire79;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire80;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire81;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire82;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire83;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire84;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire85;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire86;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire87;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire88;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire89;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire90 = slv_reg90;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire91 = slv_reg91;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire92 = slv_reg92;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire93 = slv_reg93;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire94 = slv_reg94;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire95 = slv_reg95;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire96 = slv_reg96;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire97 = slv_reg97;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire98 = slv_reg98;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire99 = slv_reg99;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire100 = slv_reg100;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire101 = slv_reg101;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire102 = slv_reg102;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire103 = slv_reg103;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire104 = slv_reg104;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire105 = slv_reg105;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire106 = slv_reg106;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire107 = slv_reg107;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire108 = slv_reg108;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire109 = slv_reg109;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire110 = slv_reg110;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire111 = slv_reg111;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire112 = slv_reg112;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire113 = slv_reg113;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire114 = slv_reg114;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire115 = slv_reg115;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire116 = slv_reg116;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire117 = slv_reg117;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire118 = slv_reg118;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire119 = slv_reg119;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire120 = slv_reg120;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire121 = slv_reg121;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire122 = slv_reg122;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire123 = slv_reg123;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire124 = slv_reg124;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire125 = slv_reg125;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire126 = slv_reg126;
		wire [C_S_AXI_DATA_WIDTH-1:0]	slv_wire127 = slv_reg127;


		AXI_LITE_CODE_v1_0_S__AXIL #(
			.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
			.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
		) inst_AXI_LITE_CODE_v1_0_S__AXIL (
			.slv_reg0      (slv_reg0),
			.slv_reg1      (slv_reg1),
			.slv_reg2      (slv_reg2),
			.slv_reg3      (slv_reg3),
			.slv_reg4      (slv_reg4),
			.slv_reg5      (slv_reg5),
			.slv_reg6      (slv_reg6),
			.slv_reg7      (slv_reg7),
			.slv_reg8      (slv_reg8),
			.slv_reg9      (slv_reg9),
			.slv_reg10     (slv_reg10),
			.slv_reg11     (slv_reg11),
			.slv_reg12     (slv_reg12),
			.slv_reg13     (slv_reg13),
			.slv_reg14     (slv_reg14),
			.slv_reg15     (slv_reg15),
			.slv_reg16     (slv_reg16),
			.slv_reg17     (slv_reg17),
			.slv_reg18     (slv_reg18),
			.slv_reg19     (slv_reg19),
			.slv_reg20     (slv_reg20),
			.slv_reg21     (slv_reg21),
			.slv_reg22     (slv_reg22),
			.slv_reg23     (slv_reg23),
			.slv_reg24     (slv_reg24),
			.slv_reg25     (slv_reg25),
			.slv_reg26     (slv_reg26),
			.slv_reg27     (slv_reg27),
			.slv_reg28     (slv_reg28),
			.slv_reg29     (slv_reg29),
			.slv_reg30     (slv_reg30),
			.slv_reg31     (slv_reg31),
			.slv_reg32     (slv_reg32),
			.slv_reg33     (slv_reg33),
			.slv_reg34     (slv_reg34),
			.slv_reg35     (slv_reg35),
			.slv_reg36     (slv_reg36),
			.slv_reg37     (slv_reg37),
			.slv_reg38     (slv_reg38),
			.slv_reg39     (slv_reg39),
			.slv_reg40     (slv_reg40),
			.slv_reg41     (slv_reg41),
			.slv_reg42     (slv_reg42),
			.slv_reg43     (slv_reg43),
			.slv_reg44     (slv_reg44),
			.slv_reg45     (slv_reg45),
			.slv_reg46     (slv_reg46),
			.slv_reg47     (slv_reg47),
			.slv_reg48     (slv_reg48),
			.slv_reg49     (slv_reg49),
			.slv_reg50     (slv_reg50),
			.slv_reg51     (slv_reg51),
			.slv_reg52     (slv_reg52),
			.slv_reg53     (slv_reg53),
			.slv_reg54     (slv_reg54),
			.slv_reg55     (slv_reg55),
			.slv_reg56     (slv_reg56),
			.slv_reg57     (slv_reg57),
			.slv_reg58     (slv_reg58),
			.slv_reg59     (slv_reg59),
			.slv_reg60     (slv_reg60),
			.slv_reg61     (slv_reg61),
			.slv_reg62     (slv_reg62),
			.slv_reg63     (slv_reg63),
			.slv_reg64     (slv_reg64),
			.slv_reg65     (slv_reg65),
			.slv_reg66     (slv_reg66),
			.slv_reg67     (slv_reg67),
			.slv_reg68     (slv_reg68),
			.slv_reg69     (slv_reg69),
			.slv_reg70     (slv_reg70),
			.slv_reg71     (slv_reg71),
			.slv_reg72     (slv_reg72),
			.slv_reg73     (slv_reg73),
			.slv_reg74     (slv_reg74),
			.slv_reg75     (slv_reg75),
			.slv_reg76     (slv_reg76),
			.slv_reg77     (slv_reg77),
			.slv_reg78     (slv_reg78),
			.slv_reg79     (slv_reg79),
			.slv_reg80     (slv_reg80),
			.slv_reg81     (slv_reg81),
			.slv_reg82     (slv_reg82),
			.slv_reg83     (slv_reg83),
			.slv_reg84     (slv_reg84),
			.slv_reg85     (slv_reg85),
			.slv_reg86     (slv_reg86),
			.slv_reg87     (slv_reg87),
			.slv_reg88     (slv_reg88),
			.slv_reg89     (slv_reg89),
			.slv_reg90     (slv_reg90),
			.slv_reg91     (slv_reg91),
			.slv_reg92     (slv_reg92),
			.slv_reg93     (slv_reg93),
			.slv_reg94     (slv_reg94),
			.slv_reg95     (slv_reg95),
			.slv_reg96     (slv_reg96),
			.slv_reg97     (slv_reg97),
			.slv_reg98     (slv_reg98),
			.slv_reg99     (slv_reg99),
			.slv_reg100    (slv_reg100),
			.slv_reg101    (slv_reg101),
			.slv_reg102    (slv_reg102),
			.slv_reg103    (slv_reg103),
			.slv_reg104    (slv_reg104),
			.slv_reg105    (slv_reg105),
			.slv_reg106    (slv_reg106),
			.slv_reg107    (slv_reg107),
			.slv_reg108    (slv_reg108),
			.slv_reg109    (slv_reg109),
			.slv_reg110    (slv_reg110),
			.slv_reg111    (slv_reg111),
			.slv_reg112    (slv_reg112),
			.slv_reg113    (slv_reg113),
			.slv_reg114    (slv_reg114),
			.slv_reg115    (slv_reg115),
			.slv_reg116    (slv_reg116),
			.slv_reg117    (slv_reg117),
			.slv_reg118    (slv_reg118),
			.slv_reg119    (slv_reg119),
			.slv_reg120    (slv_reg120),
			.slv_reg121    (slv_reg121),
			.slv_reg122    (slv_reg122),
			.slv_reg123    (slv_reg123),
			.slv_reg124    (slv_reg124),
			.slv_reg125    (slv_reg125),
			.slv_reg126    (slv_reg126),
			.slv_reg127    (slv_reg127),
			.slv_wire0     (slv_wire0),
			.slv_wire1     (slv_wire1),
			.slv_wire2     (slv_wire2),
			.slv_wire3     (slv_wire3),
			.slv_wire4     (slv_wire4),
			.slv_wire5     (slv_wire5),
			.slv_wire6     (slv_wire6),
			.slv_wire7     (slv_wire7),
			.slv_wire8     (slv_wire8),
			.slv_wire9     (slv_wire9),
			.slv_wire10    (slv_wire10),
			.slv_wire11    (slv_wire11),
			.slv_wire12    (slv_wire12),
			.slv_wire13    (slv_wire13),
			.slv_wire14    (slv_wire14),
			.slv_wire15    (slv_wire15),
			.slv_wire16    (slv_wire16),
			.slv_wire17    (slv_wire17),
			.slv_wire18    (slv_wire18),
			.slv_wire19    (slv_wire19),
			.slv_wire20    (slv_wire20),
			.slv_wire21    (slv_wire21),
			.slv_wire22    (slv_wire22),
			.slv_wire23    (slv_wire23),
			.slv_wire24    (slv_wire24),
			.slv_wire25    (slv_wire25),
			.slv_wire26    (slv_wire26),
			.slv_wire27    (slv_wire27),
			.slv_wire28    (slv_wire28),
			.slv_wire29    (slv_wire29),
			.slv_wire30    (slv_wire30),
			.slv_wire31    (slv_wire31),
			.slv_wire32    (slv_wire32),
			.slv_wire33    (slv_wire33),
			.slv_wire34    (slv_wire34),
			.slv_wire35    (slv_wire35),
			.slv_wire36    (slv_wire36),
			.slv_wire37    (slv_wire37),
			.slv_wire38    (slv_wire38),
			.slv_wire39    (slv_wire39),
			.slv_wire40    (slv_wire40),
			.slv_wire41    (slv_wire41),
			.slv_wire42    (slv_wire42),
			.slv_wire43    (slv_wire43),
			.slv_wire44    (slv_wire44),
			.slv_wire45    (slv_wire45),
			.slv_wire46    (slv_wire46),
			.slv_wire47    (slv_wire47),
			.slv_wire48    (slv_wire48),
			.slv_wire49    (slv_wire49),
			.slv_wire50    (slv_wire50),
			.slv_wire51    (slv_wire51),
			.slv_wire52    (slv_wire52),
			.slv_wire53    (slv_wire53),
			.slv_wire54    (slv_wire54),
			.slv_wire55    (slv_wire55),
			.slv_wire56    (slv_wire56),
			.slv_wire57    (slv_wire57),
			.slv_wire58    (slv_wire58),
			.slv_wire59    (slv_wire59),
			.slv_wire60    (slv_wire60),
			.slv_wire61    (slv_wire61),
			.slv_wire62    (slv_wire62),
			.slv_wire63    (slv_wire63),
			.slv_wire64    (slv_wire64),
			.slv_wire65    (slv_wire65),
			.slv_wire66    (slv_wire66),
			.slv_wire67    (slv_wire67),
			.slv_wire68    (slv_wire68),
			.slv_wire69    (slv_wire69),
			.slv_wire70    (slv_wire70),
			.slv_wire71    (slv_wire71),
			.slv_wire72    (slv_wire72),
			.slv_wire73    (slv_wire73),
			.slv_wire74    (slv_wire74),
			.slv_wire75    (slv_wire75),
			.slv_wire76    (slv_wire76),
			.slv_wire77    (slv_wire77),
			.slv_wire78    (slv_wire78),
			.slv_wire79    (slv_wire79),
			.slv_wire80    (slv_wire80),
			.slv_wire81    (slv_wire81),
			.slv_wire82    (slv_wire82),
			.slv_wire83    (slv_wire83),
			.slv_wire84    (slv_wire84),
			.slv_wire85    (slv_wire85),
			.slv_wire86    (slv_wire86),
			.slv_wire87    (slv_wire87),
			.slv_wire88    (slv_wire88),
			.slv_wire89    (slv_wire89),
			.slv_wire90    (slv_wire90),
			.slv_wire91    (slv_wire91),
			.slv_wire92    (slv_wire92),
			.slv_wire93    (slv_wire93),
			.slv_wire94    (slv_wire94),
			.slv_wire95    (slv_wire95),
			.slv_wire96    (slv_wire96),
			.slv_wire97    (slv_wire97),
			.slv_wire98    (slv_wire98),
			.slv_wire99    (slv_wire99),
			.slv_wire100   (slv_wire100),
			.slv_wire101   (slv_wire101),
			.slv_wire102   (slv_wire102),
			.slv_wire103   (slv_wire103),
			.slv_wire104   (slv_wire104),
			.slv_wire105   (slv_wire105),
			.slv_wire106   (slv_wire106),
			.slv_wire107   (slv_wire107),
			.slv_wire108   (slv_wire108),
			.slv_wire109   (slv_wire109),
			.slv_wire110   (slv_wire110),
			.slv_wire111   (slv_wire111),
			.slv_wire112   (slv_wire112),
			.slv_wire113   (slv_wire113),
			.slv_wire114   (slv_wire114),
			.slv_wire115   (slv_wire115),
			.slv_wire116   (slv_wire116),
			.slv_wire117   (slv_wire117),
			.slv_wire118   (slv_wire118),
			.slv_wire119   (slv_wire119),
			.slv_wire120   (slv_wire120),
			.slv_wire121   (slv_wire121),
			.slv_wire122   (slv_wire122),
			.slv_wire123   (slv_wire123),
			.slv_wire124   (slv_wire124),
			.slv_wire125   (slv_wire125),
			.slv_wire126   (slv_wire126),
			.slv_wire127   (slv_wire127),
			.S_AXI_ACLK    (S_AXI_ACLK),
			.S_AXI_ARESETN (S_AXI_ARESETN),
			.S_AXI_AWADDR  (S_AXI_AWADDR),
			.S_AXI_AWPROT  (S_AXI_AWPROT),
			.S_AXI_AWVALID (S_AXI_AWVALID),
			.S_AXI_AWREADY (S_AXI_AWREADY),
			.S_AXI_WDATA   (S_AXI_WDATA),
			.S_AXI_WSTRB   (S_AXI_WSTRB),
			.S_AXI_WVALID  (S_AXI_WVALID),
			.S_AXI_WREADY  (S_AXI_WREADY),
			.S_AXI_BRESP   (S_AXI_BRESP),
			.S_AXI_BVALID  (S_AXI_BVALID),
			.S_AXI_BREADY  (S_AXI_BREADY),
			.S_AXI_ARADDR  (S_AXI_ARADDR),
			.S_AXI_ARPROT  (S_AXI_ARPROT),
			.S_AXI_ARVALID (S_AXI_ARVALID),
			.S_AXI_ARREADY (S_AXI_ARREADY),
			.S_AXI_RDATA   (S_AXI_RDATA),
			.S_AXI_RRESP   (S_AXI_RRESP),
			.S_AXI_RVALID  (S_AXI_RVALID),
			.S_AXI_RREADY  (S_AXI_RREADY)
		);

		// inter wire
		wire reset;
		wire async_reset;
		wire start;
		wire en_pulse;
		wire done;
		wire sync;
		wire signal_generate_en;
		wire [31:0] TIME_REQUIRED;
		wire ps_shift;
		wire ps_incdec;
		wire ps_done;
		//Memory Map
		assign reset = (~S_AXI_ARESETN) | slv_reg0[0];
		assign en_pulse = slv_reg1[0];
		assign start = slv_reg2[0];
		//3 done reg
		assign TIME_REQUIRED = slv_reg4;
		assign ps_shift = slv_reg5[0];
		assign ps_incdec = slv_reg6[0];
		wire pulse_switch = slv_reg7[0];
		//8 for done
		assign sleep = slv_reg9[0];


		reg [DATA_WIDTH-1:0] ETS_ADC_DATA;
		always @ (posedge adc_clock) begin
			ETS_ADC_DATA <= adc_data;
		end

		assign ps_clk = S_AXI_ACLK;
		wire pulse_inside;
		CPS #(
			.MULTI(MULTI),
			.DIV(DIV),
			.CLOCK_DIV(CLOCK_DIV),
			.PULSE_DIV(PULSE_DIV),
			.CLK8DIV(CLK8DIV),
			.CLK_IN_PERIOD(CLK_IN_PERIOD)
		) inst_CPS (
			.clock_in            (sys_clock_in),
			.reset               (reset),
			.shift_clock_out     (shifting_clk),//100M -> adc
			.shift_clock_out_inv (),
			.drp_din			 (drp_din),
			.drp_dout			 (drp_dout),
			.drp_addr			 (drp_addr),
			.drp_en				 (drp_en),
			.drp_we			     (drp_we),
			.drp_clk			 (drp_clk), 
			.drp_ready			 (drp_ready),
			.clock_out           (locked_sys_clock),//system //100Mhz
			.clock_out_inv       (locked_sys_clock_inv),
			.clock8_out          (clock8_out),
			.clock8_out_inv      (clock8_out_inv),
			.pulse_out			 (pulse_inside),//10Mhz -> pulse
			.pulse_switch		 (pulse_switch),
			.sweep               (sweep),
			.sync 				 (sync),
			.locked              (locked),
			.ps_clk              (ps_clk),
			.ps_shift            (ps_shift),
			.ps_incdec           (ps_incdec),
			.ps_done             (ps_done)
		);
		(* ASYNC_REG = "TRUE"*)reg async_rst_p;
		(* ASYNC_REG = "TRUE"*)reg async_rst_n;
		(* ASYNC_REG = "TRUE"*)reg start_reg;
		(* ASYNC_REG = "TRUE"*)reg start_aver_reg;
		(* ASYNC_REG = "TRUE"*)reg done_reg;

		always @ (posedge shifting_clk) begin
			start_reg <= start;
		end

		always @ (posedge S_AXI_ACLK) begin
			done_reg <= done;
		end

		always @(posedge adc_clock) begin
			async_rst_p <= reset;
		end

		always @(negedge adc_clock) begin
			async_rst_n <= reset;
		end
		assign async_reset = async_rst_p | async_rst_n | reset;

		ETS_Core #(
			.DATA_WIDTH(DATA_WIDTH)
		) inst_ETS_Core (
			.clock              (adc_clock),
			.reset              (async_reset),
			.start              (start_reg),
			.sync               (1'b1),
			.adc_data           (ETS_ADC_DATA),
			.TIME_REQUIRED      (TIME_REQUIRED),
			.data_out_00        (slv_wire10),
			.data_out_01        (slv_wire11),
			.data_out_02        (slv_wire12),
			.data_out_03        (slv_wire13),
			.data_out_04        (slv_wire14),
			.data_out_05        (slv_wire15),
			.data_out_06        (slv_wire16),
			.data_out_07        (slv_wire17),
			.data_out_10        (slv_wire18),
			.data_out_11        (slv_wire19),
			.data_out_12        (slv_wire20),
			.data_out_13        (slv_wire21),
			.data_out_14        (slv_wire22),
			.data_out_15        (slv_wire23),
			.data_out_16        (slv_wire24),
			.data_out_17        (slv_wire25),
			.letf_aver          (),
			.done               (done),
			.signal_generate_en (signal_generate_en)
		);

		assign impulse_out = (en_pulse && signal_generate_en)?pulse_inside:0;
endmodule
