module multiplier (
    input logic [7:0] a,              // 8-bit unsigned input A (image pixel value)
    input logic  a_valid,  
    input logic signed [3:0] b,        // 4-bit signed input B (kernel value)
    output logic signed [13:0] product, // 14-bit signed output Product
    output logic p_valid
);

	logic signed [8:0] a_extended;     // 9-bit signed extension of a

    always_comb begin
        // Default assignments to prevent inferred latches
        a_extended = 9'b0;           // Ensure a_extended is assigned in all paths
        product = 14'b0; 
        p_valid = 0;
        
        if (a_valid) begin
            // Extend 'a' to 9 bits by concatenating a 0 at the MSB for sign extension
            a_extended = {1'b0, a};
            product = a_extended * b; // Perform signed multiplication
            p_valid = 1;
        end
    end

endmodule




`timescale 1ns / 1ps
module multiplier_tb;
    // Inputs
    logic [7:0] a;
    logic a_valid;
    logic p_valid;
    logic signed [3:0] b;

    // Output
    logic signed [13:0] product;

    // Instantiate the multiplier module
    multiplier uut (
        .a(a),
        .a_valid(a_valid),
        .b(b),
        .p_valid(p_valid),
        .product(product)
    );

    // Test sequence
    initial begin
        // Display the header for simulation output
        $display("Time\t a\t b\t product");
        $monitor("%0t\t %0d\t %0d\t %0d", $time, a, b, product);

        // Test case 1: Positive multiplication
        a = 8'b10001001;  // 137 (unsigned)
        a_valid=1;
        b = 4'b0100;       // 4 (signed)
        #10; // Wait for 10 time units

        // Test case 2: Negative multiplication
        a = 8'b10001001;  // 137 (unsigned)
        a_valid=0;
        b = 4'b1111;       // -1 (signed)
        #10;

        // Test case 3: Zero multiplication
        a = 8'b00001001;  // 9 (unsigned)
        a_valid=1;
        b = 4'b0000;       // 0 (signed)
        #10;

        // Test case 4: Edge case of smallest negative value
        a = 8'b00000001;  // 1 (unsigned)
        b = 4'b1111;       // -1 (signed)
        #10;

        // End of simulation
        $stop;
    end
endmodule



