module stage3_top #(parameter width=14)(
	input logic start, 
	input logic rst,                         // Asynchronous reset signal
  input logic clk, 
 	input logic signed [width-1:0] prod1,
 	input logic signed [width-1:0] prod2,
 	input logic signed [width-1:0] prod3,
 	input logic signed [width-1:0] prod4,
 	input logic signed [width-1:0] prod5,
 	input logic signed [width-1:0] prod6,
 	input logic signed [width-1:0] prod7,
 	input logic signed [width-1:0] prod8,
 	input logic signed [width-1:0] prod9,

 	input logic prod1_valid,
 	input logic prod2_valid,
 	input logic prod3_valid,
 	input logic prod4_valid,
 	input logic prod5_valid,
 	input logic prod6_valid,
 	input logic prod7_valid,
 	input logic prod8_valid,
 	input logic prod9_valid,


 	output logic signed [width:0] out_adder,
 	output logic out_adder_valid

 	
 );

//internal Signals
logic signed [width-1:0] in_adder;
logic in_adder_valid;
logic [3:0] mux_sel;
logic rst_adder;     // Reset signal for the adder

mux mux_inst(
	//.clk           (clk),
	.rst           (rst),
	  .prod1(prod1),
  .prod2(prod2),
  .prod3(prod3),
  .prod4(prod4),
  .prod5(prod5),
  .prod6(prod6),
  .prod7(prod7),
  .prod8(prod8),
  .prod9(prod9),
  .mux_sel(mux_sel),
  .in_adder(in_adder),
  .in_adder_valid(in_adder_valid)

	);

adder adder_inst(
	.in_adder(in_adder),
	.in_adder_valid (in_adder_valid),
    .rst(rst_adder),
    .clk(clk),
    .out_adder(out_adder)
    	);

stage3_control control_unit_inst(
	   .start(start),
    .rst(rst),
    .clk(clk),
      .prod1_valid   (prod1_valid),
  .prod2_valid   (prod2_valid),
  .prod3_valid   (prod3_valid),
  .prod4_valid   (prod4_valid),
  .prod5_valid   (prod5_valid),
  .prod6_valid   (prod6_valid),
  .prod7_valid   (prod7_valid),
  .prod8_valid   (prod8_valid),
  .prod9_valid   (prod9_valid),
    .mux_sel(mux_sel),
    .rst_adder(rst_adder),
    .out_adder_valid(out_adder_valid)

	);

 endmodule : stage3_top 

`timescale 1ns/1ps
 module stage3_top_tb;

  // Declare inputs as reg (for driving values in the testbench)
  reg start;
  reg rst;
  reg clk;
  reg signed [13:0] prod1, prod2, prod3, prod4, prod5, prod6, prod7, prod8, prod9;
  logic prod1_valid;
logic prod2_valid;
logic prod3_valid;
logic prod4_valid;
logic prod5_valid;
logic prod6_valid;
logic prod7_valid;
logic prod8_valid;
logic prod9_valid;

logic in_adder_valid;
logic out_adder_valid;

assign in_adder_valid=uut.mux_inst.in_adder_valid;

  // Declare outputs as wire (for observing the outputs from the DUT)
  wire signed [14:0] out_adder; // Output from the adder (15 bits to accommodate overflow)

  // Instantiate the stage3_top module (DUT)
  stage3_top #(
    .width(14) // Set the width of the input values (14-bit signed values)
  ) uut (
    .start(start),
    .rst(rst),
    .clk(clk),
    .prod1(prod1),
    .prod2(prod2),
    .prod3(prod3),
    .prod4(prod4),
    .prod5(prod5),
    .prod6(prod6),
    .prod7(prod7),
    .prod8(prod8),
    .prod9(prod9),
    .prod1_valid   (prod1_valid),
  .prod2_valid   (prod2_valid),
  .prod3_valid   (prod3_valid),
  .prod4_valid   (prod4_valid),
  .prod5_valid   (prod5_valid),
  .prod6_valid   (prod6_valid),
  .prod7_valid   (prod7_valid),
  .prod8_valid   (prod8_valid),
  .prod9_valid   (prod9_valid),
    .out_adder(out_adder),
    .out_adder_valid(out_adder_valid)
  );

  // Clock generation (period 10 time units)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle clock every 5 time units (i.e., 10 time units for a full cycle)
  end

  // Testbench procedure to test the DUT
  initial begin
    // Initialize signals
    start = 0;
    rst = 1;
    prod1 = 14'd10; prod2 = 14'd20; prod3 = 14'd30;
    prod4 = 14'd40; prod5 = 14'd50; prod6 = 14'd60;
    prod7 = 14'd70; prod8 = 14'd80; prod9 = 14'd90;

    // Monitor outputs
    $monitor("Time: %0t | rst: %b | start: %b | mux_sel: %d | rst_adder: %b | out_adder: %d", 
             $time, rst, start, uut.mux_sel, uut.rst_adder, out_adder);

    // Test 1: Reset the system

    #5 rst = 0;  // Deassert reset
    start = 1;

    // Test 2: Activate start and check mux_sel increment
    #10; // Assert start
    prod1_valid=1;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=1;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=1;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=1;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=1;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=1;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=1;	prod8_valid=0;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=1;	prod9_valid=0;
    #10;
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=1;


    // Test 3: Assert reset again while the counter is running
    #10 rst = 1; // Assert reset again
    prod1_valid=0;	prod2_valid=0;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #10 rst = 0; // Deassert reset

    // Test 4: Activate start again and check counter behavior
    #10 start = 1; // Assert start again
    prod1_valid=0;	prod2_valid=2;	prod3_valid=0;
    prod4_valid=0;	prod5_valid=0;	prod6_valid=0;
    prod7_valid=0;	prod8_valid=0;	prod9_valid=0;
    #50 start = 0; // Deassert start

    // Finish simulation
    #10 $stop;
  end

endmodule

