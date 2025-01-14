module stage2_top  #(parameter width=8)(
	input logic start,  // Start signal
	input logic [width-1:0] op1, // input data line 1 from stage 1
    input logic [width-1:0] op2, // input data line 2
    input logic [width-1:0] op3, // input data line 3
    input logic [width-1:0] op4, // input data line 4
    input logic [width-1:0] op5, // input data line 5
    input logic [width-1:0] op6, // input data line 6
    input logic [width-1:0] op7, // input data line 7
    input logic [width-1:0] op8, // input data line 8
    input logic [width-1:0] op9, // input data line 9

    input logic op1_valid,
    input logic op2_valid,
    input logic op3_valid,
    input logic op4_valid,
    input logic op5_valid,
    input logic op6_valid,
    input logic op7_valid,
    input logic op8_valid,
    input logic op9_valid,

    output logic [13:0] prod1, // output product line 1
    output logic [13:0] prod2, // output product line 2
    output logic [13:0] prod3, // output product line 3
    output logic [13:0] prod4, // output product line 4
    output logic [13:0] prod5, // output product line 5
    output logic [13:0] prod6, // output product line 6
    output logic [13:0] prod7, // output product line 7
    output logic [13:0] prod8, // output product line 8
    output logic [13:0] prod9, // output product line 9

    output logic prod1_valid,
    output logic prod2_valid,
    output logic prod3_valid,
    output logic prod4_valid,
    output logic prod5_valid,
    output logic prod6_valid,
    output logic prod7_valid,
    output logic prod8_valid,
    output logic prod9_valid,

    output logic stage3_start  // Start signal
);

 logic signed [3:0] k_pixel_1;
     logic signed [3:0] k_pixel_2;
     logic signed [3:0] k_pixel_3;
     logic signed [3:0] k_pixel_4;
     logic signed [3:0] k_pixel_5;
     logic signed [3:0] k_pixel_6;
     logic signed [3:0] k_pixel_7;
     logic signed [3:0] k_pixel_8;
     logic signed [3:0] k_pixel_9;

control_unit_stage2 cus2(
	.start(start),
        .k_pixel_1(k_pixel_1),
        .k_pixel_2(k_pixel_2),
        .k_pixel_3(k_pixel_3),
        .k_pixel_4(k_pixel_4),
        .k_pixel_5(k_pixel_5),
        .k_pixel_6(k_pixel_6),
        .k_pixel_7(k_pixel_7),
        .k_pixel_8(k_pixel_8),
        .k_pixel_9(k_pixel_9),
        .stage3_start(stage3_start)
	);

multiplier mul1(
	.a(op1),
	.a_valid(op1_valid),
    .b(k_pixel_1),
    .product(prod1),
    .p_valid(prod1_valid)
	);

multiplier mul2(
	.a(op2),
	.a_valid(op2_valid),
    .b(k_pixel_2),
    .product(prod2),
    .p_valid(prod2_valid)
	);

multiplier mul3(
	.a(op3),
	.a_valid(op3_valid),
    .b(k_pixel_3),
    .product(prod3),
    .p_valid(prod3_valid)
	);

multiplier mul4(
	.a(op4),
	.a_valid(op4_valid),
    .b(k_pixel_4),
    .product(prod4),
    .p_valid(prod4_valid)
	);

multiplier mul5(
	.a(op5),
	.a_valid(op5_valid),
    .b(k_pixel_5),
    .product(prod5),
    .p_valid(prod5_valid)
	);

multiplier mul6(
	.a(op6),
	.a_valid(op6_valid),
    .b(k_pixel_6),
    .product(prod6),
    .p_valid(prod6_valid)
	);

multiplier mul7(
	.a(op7),
	.a_valid(op7_valid),
    .b(k_pixel_7),
    .product(prod7),
    .p_valid(prod7_valid)
	);

multiplier mul8(
	.a(op8),
	.a_valid(op8_valid),
    .b(k_pixel_8),
    .product(prod8),
    .p_valid(prod8_valid)
	);

multiplier mul9(
	.a(op9),
	.a_valid(op9_valid),
    .b(k_pixel_9),
    .product(prod9),
    .p_valid(prod9_valid)
	);




endmodule : stage2_top

`timescale 1ns / 1ps

module tb_stage2_top ();

logic start;  // Start signal
logic [7:0] op1;
logic [7:0] op2;
logic [7:0] op3;
logic [7:0] op4;
logic [7:0] op5;
logic [7:0] op6;
logic [7:0] op7;
logic [7:0] op8;
logic [7:0] op9;
logic op1_valid;
    logic op2_valid;
    logic op3_valid;
  logic op4_valid;
    logic op5_valid;
    logic op6_valid;
   logic op7_valid;
    logic op8_valid;
     logic op9_valid;
logic signed [13:0] prod1;
logic signed [13:0] prod2;
logic signed [13:0] prod3;
logic signed [13:0] prod4;
logic signed [13:0] prod5;
logic signed [13:0] prod6;
logic signed [13:0] prod7;
logic signed [13:0] prod8;
logic signed [13:0] prod9;

logic prod1_valid;
logic prod2_valid;
logic prod3_valid;
logic prod4_valid;
logic prod5_valid;
logic prod6_valid;
logic prod7_valid;
logic prod8_valid;
logic prod9_valid;

logic stage3_start ;

stage2_top dut(
	 .start(start),
	 .op1(op1),
	 .op2(op2),
	 .op3(op3),
	 .op4(op4),
	 .op5(op5),
	 .op6(op6),
	 .op7(op7),
	 .op8(op8),
	 .op9(op9),
	 .op1_valid   (op1_valid),
    .op2_valid   (op2_valid),
    .op3_valid   (op3_valid),
    .op4_valid   (op4_valid),
    .op5_valid   (op5_valid),
    .op6_valid   (op6_valid),
    .op7_valid   (op7_valid),
    .op8_valid   (op8_valid),
    .op9_valid   (op9_valid),
	 .prod1(prod1),
	 .prod2(prod2),
	 .prod3(prod3),
	 .prod4(prod4),
	 .prod5(prod5),
	 .prod6(prod6),
	 .prod7(prod7),
	 .prod8(prod8),
	 .prod9(prod9),
	 .prod1_valid (prod1_valid),
	 .prod2_valid (prod2_valid),
	 .prod3_valid (prod3_valid),
	 .prod4_valid (prod4_valid),
	 .prod5_valid (prod5_valid),
	 .prod6_valid (prod6_valid),
	 .prod7_valid (prod7_valid),
	 .prod8_valid (prod8_valid),
	 .prod9_valid (prod9_valid),
	 .stage3_start(stage3_start)

	);

initial begin
	op1=8'bz;
	op2=8'bz;
	op3=8'bz;
	op4=8'bz;
	op5=8'bz;
	op6=8'bz;
	op7=8'bz;
	op8=8'bz;
	op9=8'bz;
	op1_valid=0;
	op2_valid=0;
	op3_valid=0;
	op4_valid=0;
	op5_valid=0;
	op6_valid=0;
	op7_valid=0;
	op8_valid=0;
	op9_valid=0;
	start=0;
	#10;
	start=1;
	op1=8'd1;
	op2=8'd2;
	op3=8'd3;
	op4=8'd123;
	op5=8'd255;
	op6=8'd0;
	op7=8'd41;
	op8=8'd99;
	op9=8'd199;
	op1_valid=1;
	op2_valid=0;
	op3_valid=0;
	op4_valid=0;
	op5_valid=0;
	op6_valid=0;
	op7_valid=0;
	op8_valid=0;
	op9_valid=0;

	#10;
	op1=8'd2;
	op2=8'd3;
	op3=8'd4;
	op4=8'd124;
	op5=8'd200;
	op6=8'd3;
	op7=8'd45;
	op8=8'd100;
	op9=8'd167;
	op1_valid=0;
	op2_valid=1;
	op3_valid=0;
	op4_valid=0;
	op5_valid=0;
	op6_valid=0;
	op7_valid=0;
	op8_valid=0;
	op9_valid=0;

	#20;
	start=0;
	op1_valid=0;
	op2_valid=0;
	op3_valid=1;
	op4_valid=0;
	op5_valid=0;
	op6_valid=0;
	op7_valid=0;
	op8_valid=0;
	op9_valid=0;


	

	#60;
	$stop;
	
end

endmodule : tb_stage2_top