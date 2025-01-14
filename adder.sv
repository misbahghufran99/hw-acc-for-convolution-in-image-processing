module adder #(parameter width = 14) (
  input logic signed [width-1:0] in_adder,  // Signed input
  input logic in_adder_valid,
  input logic rst,                         // Asynchronous reset signal
  input logic clk,                         // Clock signal
  output logic signed [width:0] out_adder,  // Signed output (wider than input for overflow handling)
  output logic out_adder_valid
);




  
    always @(*) begin
    if (rst) begin
      out_adder = 0;
      out_adder_valid = 0;

    end 
    else if (in_adder_valid) begin
      // Accumulate input values
      out_adder = out_adder + in_adder;
      out_adder_valid = 1;

    end 
    else begin
      out_adder = 0;
      out_adder_valid = 0;
      //$display("out_adder = 0 b/c in_adder_valid = %0d @ Time: %0t", in_adder_valid,$time);

    end
  end
  
  
endmodule

`timescale 1ns/1ps
module tb_adder;

  // Parameters
  localparam width = 14;

  // Testbench signals
  logic signed [width-1:0] in_adder;
  logic in_adder_valid;
  logic rst;
  logic clk;
  logic signed [width:0] out_adder;
  logic out_adder_valid;

  // Instantiate the adder module
  adder #(width) uut (
    .in_adder(in_adder),
    .in_adder_valid (in_adder_valid),
    .rst(rst),
    .clk(clk),
    .out_adder(out_adder),
    .out_adder_valid(out_adder_valid)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10-time unit clock period
  end

  // Test stimulus
  initial begin
    // Initialize signals
    rst = 1;
    in_adder = 0;
    in_adder_valid=0;
    #15;  // Wait for a few clock cycles

    // Release reset and apply inputs
    rst = 0;
    in_adder_valid=1;
    in_adder = 14'sd5;
    #10;
    in_adder = 14'sd3;
    #10;
    in_adder = -14'sd2;
    #10;

    // Apply reset again
    rst = 1;
    in_adder_valid=0;
    #10;
    rst = 0;

    // Continue with new inputs
    in_adder = 14'sd7;
    #10;
    in_adder = 14'sd10;
    #20;

    // End simulation
    $stop;
  end

  // Monitor changes
  initial begin
    $monitor("Time: %0t | rst: %b | in_adder: %d | out_adder: %d", $time, rst, in_adder, out_adder);
  end

endmodule
