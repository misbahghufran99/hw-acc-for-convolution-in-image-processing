module stage1_top #(parameter width=8)(
    input logic clk,    // Clock
    input logic rst,    // Asynchronous reset active high
    input logic start,  // Start signal
    output logic wren,  // Write enable
    output logic [9:0] addr,  // Address output
    input logic [width-1:0] data,  // Input data to be routed to one of the outputs
    output logic [width-1:0] op1, // Output data line 1
    output logic [width-1:0] op2, // Output data line 2
    output logic [width-1:0] op3, // Output data line 3
    output logic [width-1:0] op4, // Output data line 4
    output logic [width-1:0] op5, // Output data line 5
    output logic [width-1:0] op6, // Output data line 6
    output logic [width-1:0] op7, // Output data line 7
    output logic [width-1:0] op8, // Output data line 8
    output logic [width-1:0] op9, // Output data line 9
    output logic op1_valid,
    output logic op2_valid,
    output logic op3_valid,
    output logic op4_valid,
    output logic op5_valid,
    output logic op6_valid,
    output logic op7_valid,
    output logic op8_valid,
    output logic op9_valid,
    output logic [width-1:0] op_NoConnect // Output data line for unconnected or default cases
	
);

//internal signals
logic [3:0] demux_sel;

control_unit_stage1 cus1(
	        .clk(clk),
        .rst(rst),
        .start(start),
        .wren(wren),
        .addr(addr),
        .demux_sel(demux_sel)
        );

demux dmux(
    .demux_sel(demux_sel),     // Selection signal from testbench
    .data(data),               // Input data from testbench
    .op1(op1),                 // Connect output data line 1
    .op2(op2),                 // Connect output data line 2
    .op3(op3),                 // Connect output data line 3
    .op4(op4),                 // Connect output data line 4
    .op5(op5),                 // Connect output data line 5
    .op6(op6),                 // Connect output data line 6
    .op7(op7),                 // Connect output data line 7
    .op8(op8),                 // Connect output data line 8
    .op9(op9),                 // Connect output data line 9
     .op1_valid   (op1_valid),
    .op2_valid   (op2_valid),
    .op3_valid   (op3_valid),
    .op4_valid   (op4_valid),
    .op5_valid   (op5_valid),
    .op6_valid   (op6_valid),
    .op7_valid   (op7_valid),
    .op8_valid   (op8_valid),
    .op9_valid   (op9_valid),
    .op_NoConnect(op_NoConnect) // Connect output data line for unconnected cases
	);

endmodule : stage1_top


module tb_stage1_top ();

	// Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic wren;
    logic [9:0] addr;
    logic [7:0] data;          // 8-bit input data signal to test the demux

	logic [7:0] op1;           // Output line 1
	logic [7:0] op2;           // Output line 2
	logic [7:0] op3;           // Output line 3
	logic [7:0] op4;           // Output line 4
	logic [7:0] op5;           // Output line 5
	logic [7:0] op6;           // Output line 6
	logic [7:0] op7;           // Output line 7
	logic [7:0] op8;           // Output line 8
	logic [7:0] op9;           // Output line 9
	logic [7:0] op_NoConnect;  // Output line for unconnected/default cases

    logic op1_valid;
    logic op2_valid;
    logic op3_valid;
  logic op4_valid;
    logic op5_valid;
    logic op6_valid;
   logic op7_valid;
    logic op8_valid;
     logic op9_valid;


	    // Instantiate the control unit
    stage1_top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .wren(wren),
        .addr(addr),
        .data(data),               // Input data from testbench
	    .op1(op1),                 // Connect output data line 1
	    .op2(op2),                 // Connect output data line 2
	    .op3(op3),                 // Connect output data line 3
	    .op4(op4),                 // Connect output data line 4
	    .op5(op5),                 // Connect output data line 5
	    .op6(op6),                 // Connect output data line 6
	    .op7(op7),                 // Connect output data line 7
	    .op8(op8),                 // Connect output data line 8
	    .op9(op9),                 // Connect output data line 9
        .op1_valid   (op1_valid),
    .op2_valid   (op2_valid),
    .op3_valid   (op3_valid),
    .op4_valid   (op4_valid),
    .op5_valid   (op5_valid),
    .op6_valid   (op6_valid),
    .op7_valid   (op7_valid),
    .op8_valid   (op8_valid),
    .op9_valid   (op9_valid),
	    .op_NoConnect(op_NoConnect) // Connect output data line for unconnected cases
    );

     // Clock generation (50 MHz clock, 20ns period)
    always #10 clk = ~clk;

    // Testbench process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        start = 0;
        data = 8'd123; // Assign a test value to the input data

        // Apply asynchronous reset
        $display("Applying reset...");
        rst = 1;
        #20;  // Hold reset for 20ns
        rst = 0;
        #10;  // Small delay after releasing reset

        // Start signal test
        $display("Applying start signal...");
        start = 1;
        #20;  // Hold start high for 20ns
        start = 0;

        
        #6000;
        // End simulation
        $stop;
    end


endmodule : tb_stage1_top