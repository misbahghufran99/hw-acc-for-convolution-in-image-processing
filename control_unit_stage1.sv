module control_unit_stage1 (
    input logic clk,    // Clock
    input logic rst,    // Asynchronous reset active high
    input logic start,  // Start signal
    output logic wren,  // Write enable
    output logic [9:0] addr,  // Address output
    output logic [3:0] demux_sel  // Demultiplexer select signal
);

    // Internal variables to track the previous state of the start signal
    logic start_prev;
        // Internal variables for address generation
    logic [5:0] row_index;  // 6 bits for rows (0-31)
    logic [5:0] col_index;  // 6 bits for columns (0-31)
    logic [3:0] kernel_step; // Keeps track of the 3x3 kernel steps (0 to 8)

// Combinational block for immediate address calculation
always_comb begin
    case (kernel_step)
        0: addr = (row_index * 32) + col_index;
        1: addr = (row_index * 32) + col_index + 1;
        2: addr = (row_index * 32) + col_index + 2;
        3: addr = ((row_index + 1) * 32) + col_index;
        4: addr = ((row_index + 1) * 32) + col_index + 1;
        5: addr = ((row_index + 1) * 32) + col_index + 2;
        6: addr = ((row_index + 2) * 32) + col_index;
        7: addr = ((row_index + 2) * 32) + col_index + 1;
        8: addr = ((row_index + 2) * 32) + col_index + 2;
        default: addr = 10'b0; // Optional default case
    endcase
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        demux_sel <= 4'b1111;
        //addr <= 10'b0;
        wren <= 1'b0;
        start_prev <= 1'b0;
        row_index <= 6'b0;
        col_index <= 6'b0;
        kernel_step <= 4'b0;
    end else begin
        if (start && !start_prev) begin
            //addr <= 10'b0; // Optional if using combinational block
            demux_sel <= 4'b0000;
            wren <= 1'b0;
        end else begin
            if (demux_sel == 8)
                demux_sel <= 0;
            else
                demux_sel <= demux_sel + 1;

            // Handle kernel step logic
            if (kernel_step == 8) begin
                kernel_step <= 0;
                col_index <= col_index + 1;
                if (col_index >= 29) begin
                    col_index <= 0;
                    row_index <= row_index + 1;
                end
            end else begin
                kernel_step <= kernel_step + 1;
            end

            wren <= 1'b0; // Set wren as needed
        end
        start_prev <= start;
    end
end


endmodule : control_unit_stage1


`timescale 1ns / 1ps

module tb_control_unit_stage1();

    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic wren;
    logic [9:0] addr;
    logic [3:0] demux_sel;

    // Instantiate the control unit
    control_unit_stage1 uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .wren(wren),
        .addr(addr),
        .demux_sel(demux_sel)
    );

    // Clock generation (50 MHz clock, 20ns period)
    always #10 clk = ~clk;

    // Testbench process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        start = 0;

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

    // Monitor signals for debugging
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | start: %b | wren: %b | addr: %d | demux_sel: %d", 
                 $time, clk, rst, start, wren, addr, demux_sel);
    end

endmodule : tb_control_unit_stage1
