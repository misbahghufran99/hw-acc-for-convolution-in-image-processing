module stage3_control (
  input logic start,        // Start signal
  input logic rst,          // Reset signal (active high)
  input logic clk,          // Clock signal
    input logic prod1_valid,
  input logic prod2_valid,
  input logic prod3_valid,
  input logic prod4_valid,
  input logic prod5_valid,
  input logic prod6_valid,
  input logic prod7_valid,
  input logic prod8_valid,
  input logic prod9_valid,

  output logic [3:0] mux_sel, // Mux selector
  output logic rst_adder,     // Reset signal for the adder
  output logic out_adder_valid
);



  // Process block to control rst_adder
  always_ff @(*) begin
    if (rst || prod1_valid) begin
     
      rst_adder = 1;        // Set rst_adder to 1 when rst is high
     
    end else if (start) begin
      rst_adder = 0;        // Set rst_adder to 0 when start is high
  
    end else begin
      rst_adder = 1;        // Default state when not reset or started
  
    end
  end

  always @(*) begin
  mux_sel = 4'd9;  // Default value when none of the prodX_valid signals are high
  if (prod1_valid) begin
    mux_sel = 4'd0;
    out_adder_valid = 1'b0;
  end
  else if (prod2_valid) begin
    mux_sel = 4'd1;
    out_adder_valid = 1'b0;
  end
  else if (prod3_valid) begin
    mux_sel = 4'd2;
    out_adder_valid = 1'b0;
  end
  else if (prod4_valid) begin
    mux_sel = 4'd3;
    out_adder_valid = 1'b0;
  end
  else if (prod5_valid) begin
    mux_sel = 4'd4;
    out_adder_valid = 1'b0;
  end
  else if (prod6_valid) begin
    mux_sel = 4'd5;
    out_adder_valid = 1'b0;
  end
  else if (prod7_valid) begin
    mux_sel = 4'd6;
    out_adder_valid = 1'b0;
  end
  else if (prod8_valid) begin
    mux_sel = 4'd7;
    out_adder_valid = 1'b0;
  end
  else if (prod9_valid) begin
    mux_sel = 4'd8 ;
    out_adder_valid = 1'b1;
  end
end

endmodule
 

module stage3_control_tb;

  // Declare inputs as reg (for driving values in the testbench)
  reg start;
  reg rst;
  reg clk;
  
  // Declare outputs as wire (for observing the outputs from the DUT)
  wire [3:0] mux_sel;
  wire rst_adder;

  logic prod1_valid;
  logic prod2_valid;
  logic prod3_valid;
  logic prod4_valid;
  logic prod5_valid;
  logic prod6_valid;
  logic prod7_valid;
  logic prod8_valid;
  logic prod9_valid;

  logic out_adder_valid;

  // Instantiate the stage3_control module (DUT)
  stage3_control uut (
    .start(start),
    .rst(rst),
    .clk(clk),
    .prod1_valid(prod1_valid),
    .prod2_valid(prod2_valid),
    .prod3_valid(prod3_valid),
    .prod4_valid(prod4_valid),
    .prod5_valid(prod5_valid),
    .prod6_valid(prod6_valid),
    .prod7_valid(prod7_valid),
    .prod8_valid(prod8_valid),
    .prod9_valid(prod9_valid),
    .mux_sel(mux_sel),
    .rst_adder(rst_adder),
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
    rst = 0;
    
    // Monitor outputs
    $monitor("Time: %0t | rst: %b | start: %b | mux_sel: %d | rst_adder: %b", 
             $time, rst, start, mux_sel, rst_adder);

    // Apply test vectors
    // Test 1: Reset the system
    #5  rst = 1; // Assert reset
    #10 rst = 0; // Deassert reset
    
    // Test 2: Activate start and check mux_sel increment
    #10 start = 1; // Assert start
    
    prod1_valid = 1'b1;
    prod2_valid = 1'b0;
    prod3_valid = 1'b0;
    prod4_valid = 1'b0;
    prod5_valid = 1'b0;
    prod6_valid = 1'b0;
    prod7_valid = 1'b0;
    prod8_valid = 1'b0;
    prod9_valid = 1'b0;

    #80 start = 0; // Deassert start
    
    // Test 3: Reset again while the counter is running
    #10 rst = 1; // Assert reset again
    #10 rst = 0; // Deassert reset
    
    // Test 4: Assert start again and check counter behavior
    #10 start = 1; // Assert start again
    #50 start = 0; // Deassert start
    
    // Finish simulation
    #10 $stop;
  end

endmodule
