module mux #(parameter width=14) (
	//input logic clk,
	input logic rst,
 	input logic signed [width-1:0] prod1,
 	input logic signed [width-1:0] prod2,
 	input logic signed [width-1:0] prod3,
 	input logic signed [width-1:0] prod4,
 	input logic signed [width-1:0] prod5,
 	input logic signed [width-1:0] prod6,
 	input logic signed [width-1:0] prod7,
 	input logic signed [width-1:0] prod8,
 	input logic signed [width-1:0] prod9,




 	output logic signed [width-1:0] in_adder,
 	output logic in_adder_valid,

 	input logic [3:0] mux_sel  

 	
 );



always @(*) begin
  if (rst) begin
    in_adder_valid = 0;  // Reset value
  end
  else if (mux_sel < 4'd9) begin
    in_adder_valid = 1;
  end
  else begin
    in_adder_valid = 0;
    //$display("in_adder_valid = 0 b/c mux_sel = %0d @ Time: %0t", mux_sel,$time);
  end
end



always_comb begin
  case (mux_sel)
    4'd0: begin
    	in_adder = 14'd0;
      in_adder = prod1;
    
    end
    
    4'd1: begin
    	in_adder = prod2;
    
    end
    4'd2: begin
    	in_adder = prod3;
    
    end
    4'd3: begin
    	in_adder = prod4;
    
    end
    4'd4: begin
    	in_adder = prod5;
   
    end
    4'd5: begin
    	in_adder = prod6;
    	
    end
    4'd6: begin
    	in_adder = prod7;
    	
    end
    4'd7: begin
    	in_adder = prod8;
  
    end
    4'd8: begin
    	in_adder = prod9;
    
    end
    default: begin
    	in_adder = 0;
    	
    end  // Default case, e.g., 0, if no valid selection is made
  endcase
end
 
 endmodule : mux 

`timescale 1ns / 1ps

module tb_mux;

// Parameters
localparam width = 14;

//logic clk;
logic rst;

// Testbench signals
logic signed [width-1:0] prod1;
logic signed [width-1:0] prod2;
logic signed [width-1:0] prod3;
logic signed [width-1:0] prod4;
logic signed [width-1:0] prod5;
logic signed [width-1:0] prod6;
logic signed [width-1:0] prod7;
logic signed [width-1:0] prod8;
logic signed [width-1:0] prod9;

/*
logic prod1_valid;
logic prod2_valid;
logic prod3_valid;
logic prod4_valid;
logic prod5_valid;
logic prod6_valid;
logic prod7_valid;
logic prod8_valid;
logic prod9_valid;
*/
logic signed [width-1:0] in_adder;
logic in_adder_valid;
logic [3:0] mux_sel;

// Instantiate the mux module
mux #(width) uut (
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


  // Clock generation (period 10 time units)
 // initial begin
 //   clk = 0;
 //   forever #5 clk = ~clk;  // Toggle clock every 5 time units (i.e., 10 time units for a full cycle)
 // end


initial begin

	rst=1;
	#10;
	rst=0;


  // Initialize inputs
  prod1 = 14'sd100;
  prod2 = 14'sd200;
  prod3 = 14'sd300;
  prod4 = 14'sd400;
  prod5 = 14'sd500;
  prod6 = 14'sd600;
  prod7 = 14'sd700;
  prod8 = 14'sd800;
  prod9 = 14'sd900;


  // Test all possible select values
  for (int i = 0; i < 10; i++) begin
    mux_sel = i;
    #10; // Wait 10 time units
    $display("mux_sel = %0d, in_adder = %0d", mux_sel, in_adder);
  end

  // End simulation
  $stop;
end

endmodule
