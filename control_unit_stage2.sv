module control_unit_stage2 (

    input logic start,  // Start signal
    output logic signed [3:0] k_pixel_1,
    output logic signed [3:0] k_pixel_2,
    output logic signed [3:0] k_pixel_3,
    output logic signed [3:0] k_pixel_4,
    output logic signed [3:0] k_pixel_5,
    output logic signed [3:0] k_pixel_6,
    output logic signed [3:0] k_pixel_7,
    output logic signed [3:0] k_pixel_8,
    output logic signed [3:0] k_pixel_9,
    output logic stage3_start  // Start signal
    
);

logic signed [3:0] kernel [2:0][2:0]; // 2D array with signed 4-bit values

    always_ff @(posedge start) begin
   
            // Initialize kernel values on reset
            kernel[0][0] <= 0;
            kernel[0][1] <= -1;
            kernel[0][2] <= 0;
            kernel[1][0] <= -1;
            kernel[1][1] <= 4;
            kernel[1][2] <= -1;
            kernel[2][0] <= 0;
            kernel[2][1] <= -1;
            kernel[2][2] <= 0;
            stage3_start<=1;
       
    end

    assign k_pixel_1=kernel[0][0];
    assign k_pixel_2=kernel[0][1];
    assign k_pixel_3=kernel[0][2];
    assign k_pixel_4=kernel[1][0];
    assign k_pixel_5=kernel[1][1];
    assign k_pixel_6=kernel[1][2];
    assign k_pixel_7=kernel[2][0];
    assign k_pixel_8=kernel[2][1];
    assign k_pixel_9=kernel[2][2];

endmodule : control_unit_stage2

`timescale 1ns / 1ps

module control_unit_stage2_tb;

    // Inputs
    logic start;  // Start signal

    // Outputs
    logic signed [3:0] k_pixel_1;
    logic signed [3:0] k_pixel_2;
    logic signed [3:0] k_pixel_3;
    logic signed [3:0] k_pixel_4;
    logic signed [3:0] k_pixel_5;
    logic signed [3:0] k_pixel_6;
    logic signed [3:0] k_pixel_7;
    logic signed [3:0] k_pixel_8;
    logic signed [3:0] k_pixel_9;
    logic stage3_start;

    // Instantiate the control_unit_stage2 module
    control_unit_stage2 uut (
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

    // Test sequence
    initial begin
        // Display the header for simulation output
        $display("Time\t start\t k_pixel_1\t k_pixel_2\t k_pixel_3\t k_pixel_4\t k_pixel_5\t k_pixel_6\t k_pixel_7\t k_pixel_8\t k_pixel_9");
        $monitor("%0t\t %0d\t %0d\t %0d\t %0d\t %0d\t %0d\t %0d\t %0d\t %0d\t %0d", 
                 $time, start, k_pixel_1, k_pixel_2, k_pixel_3, k_pixel_4, k_pixel_5, k_pixel_6, k_pixel_7, k_pixel_8, k_pixel_9);

        // Initialize signals
        start = 0;  // Initially start is low

        // Test case 1: Assert start signal
        #10 start = 1;  // Assert start signal
        #10 start = 0;  // Deassert start signal

        // Wait for the simulation to settle
        #20;

        // Test case 2: Assert start signal again
        #10 start = 1;  // Assert start signal
        #10 start = 0;  // Deassert start signal

        // End simulation after checking the kernel values
        #20;
        $stop;
    end

endmodule : control_unit_stage2_tb