module demux #(parameter width=8) (
    // Port Declarations
    input logic [3:0] demux_sel, // 4-bit selection input to choose which output receives data
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

always @(*) begin
    // Set all outputs to high-impedance ('bz) by default to prevent conflicting drivers
    op1 = 'bz;
    op2 = 'bz;
    op3 = 'bz;
    op4 = 'bz;
    op5 = 'bz;
    op6 = 'bz;
    op7 = 'bz;
    op8 = 'bz;
    op9 = 'bz;
    op1_valid = 0;
    op2_valid = 0;
    op3_valid = 0;
    op4_valid = 0;
    op5_valid = 0;
    op6_valid = 0;
    op7_valid = 0;
    op8_valid = 0;
    op9_valid = 0;
    op_NoConnect = 'bz;

    // Route the input data to the selected output based on the demux_sel signal
    case (demux_sel)
        4'd0:
        begin
             op1 = data;          // Selects op1 to carry data
             op1_valid = 1;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd1: begin
             op2 = data;          // Selects op2 to carry data
             op1_valid = 0;
            op2_valid = 1;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd2:begin
             op3 = data;          // Selects op3 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 1;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd3:begin
             op4 = data;          // Selects op4 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 1;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd4: begin
             op5 = data;          // Selects op5 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 1;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd5:begin
             op6 = data;          // Selects op6 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 1;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd6:begin
             op7 = data;          // Selects op7 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 1;
            op8_valid = 0;
            op9_valid = 0;
         end 
        4'd7:begin
             op8 = data;          // Selects op8 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 1;
            op9_valid = 0;
         end 
        4'd8: begin
             op9 = data;          // Selects op9 to carry data
             op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 1;
         end 
        default: 
        begin
            op_NoConnect = data; // If no valid selection, send data to op_NoConnect
            op1_valid = 0;
            op2_valid = 0;
            op3_valid = 0;
            op4_valid = 0;
            op5_valid = 0;
            op6_valid = 0;
            op7_valid = 0;
            op8_valid = 0;
            op9_valid = 0;
        end

    endcase
end

endmodule : demux




`timescale 1ns / 1ps
module tb_demux ();

// Testbench signals
reg [7:0] data;          // 8-bit input data signal to test the demux
reg [3:0] demux_sel;     // 4-bit selection signal to choose the output line
reg [7:0] op1;           // Output line 1
reg [7:0] op2;           // Output line 2
reg [7:0] op3;           // Output line 3
reg [7:0] op4;           // Output line 4
reg [7:0] op5;           // Output line 5
reg [7:0] op6;           // Output line 6
reg [7:0] op7;           // Output line 7
reg [7:0] op8;           // Output line 8
reg [7:0] op9;           // Output line 9
reg [7:0] op_NoConnect;  // Output line for unconnected/default cases
logic op1_valid;
    logic op2_valid;
    logic op3_valid;
  logic op4_valid;
    logic op5_valid;
    logic op6_valid;
   logic op7_valid;
    logic op8_valid;
     logic op9_valid;

// Initial block to provide stimulus for the demux
initial begin
    data = 8'd123; // Assign a test value to the input data

    // Apply different selection values to test the routing behavior of the demux
    demux_sel = 4'd0; #20;  // Select op1
    demux_sel = 4'd1; #20;  // Select op2
    demux_sel = 4'd2; #20;  // Select op3
    demux_sel = 4'd3; #20;  // Select op4
    demux_sel = 4'd4; #20;  // Select op5
    demux_sel = 4'd5; #20;  // Select op6
    demux_sel = 4'd6; #20;  // Select op7
    demux_sel = 4'd7; #20;  // Select op8
    demux_sel = 4'd8; #20;  // Select op9
    demux_sel = 4'd9; #20;  // Select op_NoConnect
    demux_sel = 4'd10; #20; // Select op_NoConnect (out of range)
    demux_sel = 4'd11; #20; // Select op_NoConnect (out of range)

    // Stop the simulation after the last test case
    #20;
    $stop;
end

// Instantiate the demux module
demux dut (
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

endmodule : tb_demux
