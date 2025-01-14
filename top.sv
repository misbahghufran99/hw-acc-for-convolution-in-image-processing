/*
AUTHOR: MUHAMMAD MISBAH

DATE CREATED: 17-NOV-2024

FILE NAME: TOP.SV

DESCRIPTION: TOP MODULE FOR CONVOLUTION HARDWARE ACCELERATOR

*/

module top #(parameter width=8)(
/*
-----------------------
   INPUT INTERFACE
-----------------------
*/
	input logic clk,    // Clock
    input logic rst,    // Asynchronous reset active high
    input logic start,  // Start signal
    

/*
-----------------------
   OUTPUT INTERFACE
-----------------------
*/

	output logic wren,
    output logic [9:0] addr,
    output logic signed [14:0] out_adder,
    output logic out_adder_valid

);

/*
-----------------------
   INTERNAL SIGNALS
-----------------------
*/
	
	////////////////////////////////////////////////////////

	//RAM OUTPUT -> STAGE1 INPUT

	logic [width-1:0] data;

	////////////////////////////////////////////////////////


	//STAGE1 OUTPUT -> STAGE2 INPUT

	logic [7:0] op1;           // Output line 1
	logic [7:0] op2;           // Output line 2
	logic [7:0] op3;           // Output line 3
	logic [7:0] op4;           // Output line 4
	logic [7:0] op5;           // Output line 5
	logic [7:0] op6;           // Output line 6
	logic [7:0] op7;           // Output line 7
	logic [7:0] op8;           // Output line 8
	logic [7:0] op9;           // Output line 9

	logic op1_valid;
    logic op2_valid;
    logic op3_valid;
    logic op4_valid;
    logic op5_valid;
    logic op6_valid;
    logic op7_valid;
    logic op8_valid;
    logic op9_valid;
	logic [7:0] op_NoConnect;  // Output line for unconnected/default cases

	////////////////////////////////////////////////////////

	//STAGE2 OUTPUT -> STAGE3 INPUT

	logic [13:0] prod1; // output product line 1
    logic [13:0] prod2; // output product line 2
    logic [13:0] prod3; // output product line 3
    logic [13:0] prod4; // output product line 4
    logic [13:0] prod5; // output product line 5
    logic [13:0] prod6; // output product line 6
    logic [13:0] prod7; // output product line 7
    logic [13:0] prod8; // output product line 8
    logic [13:0] prod9; // output product line 9

    logic prod1_valid;
    logic prod2_valid;
    logic prod3_valid;
    logic prod4_valid;
    logic prod5_valid;
    logic prod6_valid;
    logic prod7_valid;
    logic prod8_valid;
    logic prod9_valid;

    ////////////////////////////////////////////////////////

/*
-----------------------
   RAM INSTANTIATION
-----------------------
*/

	my_ram mem(
		.clk(clk),
		.adr(addr),
		.we(wren),
		.din (),
		.dout(data)
		);

/*
--------------------------
   STAGE1 INSTANTIATION
--------------------------
*/

stage1_top st1(
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
/*
--------------------------
   STAGE2 INSTANTIATION
--------------------------
*/

stage2_top st2(
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

/*
--------------------------
   STAGE3 INSTANTIATION
--------------------------
*/

  stage3_top st3 (
    .start(stage3_start),
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
    .prod1_valid (prod1_valid),
	.prod2_valid (prod2_valid),
	.prod3_valid (prod3_valid),
	.prod4_valid (prod4_valid),
	.prod5_valid (prod5_valid),
	.prod6_valid (prod6_valid),
	.prod7_valid (prod7_valid),
	.prod8_valid (prod8_valid),
	.prod9_valid (prod9_valid),
    .out_adder(out_adder),
    .out_adder_valid(out_adder_valid)
  );


endmodule : top


/*
--------------------------
      TEST BENCH
--------------------------
*/

module tb_top();
    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic wren;
    logic [9:0] addr;
    logic [7:0] data; // 8-bit input data signal to test the demux
    logic signed [14:0] out_adder;
    logic out_adder_valid;
   

    // BMP-related parameters
    integer bmp_file;
    integer i, j;
    localparam IMAGE_WIDTH = 30;  // Width of the image
    localparam IMAGE_HEIGHT = 30; // Height of the image
    
    logic [7:0] pixel_data [0:IMAGE_HEIGHT-1][0:IMAGE_WIDTH-1]; // Pixel array

    logic [9:0] pixel_count;

    // Clock generation (50 MHz clock, 20ns period)
    always #10 clk = ~clk;

    // Assign testbench signals to DUT outputs (example connections)
    assign data = dut.mem.dout;

    // Top module instantiation
    top dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .wren(wren),
        .addr(addr),
        .out_adder(out_adder),
        .out_adder_valid(out_adder_valid)
    );

    // Initialize signals
    initial begin
        clk = 0;
        rst = 0;
        start = 0;
        pixel_count = 10'd0;

        // Apply reset
        rst = 1;
        #20;
        rst = 0;
        #10;

        // Start signal
        start = 1;
        #20;
        start = 0;

        // Wait for simulation to complete (example duration)
        //#163;

        

        #6000;

        // End simulation
        //$stop;
    end

    // Populate pixel_data array with values from out_adder
    always @(out_adder_valid) begin
        if (out_adder_valid) begin
            pixel_data[pixel_count / IMAGE_WIDTH][pixel_count % IMAGE_WIDTH] = out_adder[14:8]; // Truncate to 8 bits
            pixel_count = pixel_count+1;
        end
    end

    always @(*)
    begin
        if (pixel_count==10'd901) begin
            // Generate BMP file
        $display("Generating BMP file...");
        generate_bmp("output.bmp");
            $stop;
        end

    end

    // BMP file generation task


task generate_bmp(input string filename);
    integer bmp_file;
    integer file_size;
    integer pixel_array_offset;
    integer row_size;
    integer padding_size;
    integer i, j;

    begin
        // Constants
        pixel_array_offset = 54; // Header size (14 bytes + 40 bytes for DIB header)
        row_size = IMAGE_WIDTH * 3; // 3 bytes per pixel (RGB)
        padding_size = (4 - (row_size % 4)) % 4; // Padding to 4-byte alignment
        file_size = pixel_array_offset + (row_size + padding_size) * IMAGE_HEIGHT;

        // Open file for writing
        bmp_file = $fopen(filename, "wb");
        if (bmp_file == 0) begin
            $display("Error: Unable to open BMP file.");
            $stop;
        end

        // BMP Header (14 bytes)
        $fwrite(bmp_file, "%c%c", 66, 77); // 'BM' signature
        $fwrite(bmp_file, "%c%c%c%c", file_size[7:0], file_size[15:8], file_size[23:16], file_size[31:24]);
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Reserved
        $fwrite(bmp_file, "%c%c%c%c", pixel_array_offset[7:0], pixel_array_offset[15:8], pixel_array_offset[23:16], pixel_array_offset[31:24]);

        // DIB Header (40 bytes)
        $fwrite(bmp_file, "%c%c%c%c", 40, 0, 0, 0); // DIB header size
        $fwrite(bmp_file, "%c%c%c%c", IMAGE_WIDTH[7:0], IMAGE_WIDTH[15:8], IMAGE_WIDTH[23:16], IMAGE_WIDTH[31:24]); // Width
        $fwrite(bmp_file, "%c%c%c%c", IMAGE_HEIGHT[7:0], IMAGE_HEIGHT[15:8], IMAGE_HEIGHT[23:16], IMAGE_HEIGHT[31:24]); // Height
        $fwrite(bmp_file, "%c%c", 1, 0); // Color planes (1)
        $fwrite(bmp_file, "%c%c", 24, 0); // Bits per pixel (24)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Compression (none)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Image size (0 if uncompressed)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // X pixels per meter (0)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Y pixels per meter (0)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Colors in palette (0)
        $fwrite(bmp_file, "%c%c%c%c", 0, 0, 0, 0); // Important colors (0)

        // Pixel Array
        for (i = IMAGE_HEIGHT - 1; i >= 0; i = i - 1) begin
            for (j = 0; j < IMAGE_WIDTH; j = j + 1) begin
                $fwrite(bmp_file, "%c%c%c", pixel_data[i][j], pixel_data[i][j], pixel_data[i][j]); // Grayscale RGB
            end
            // Write padding bytes
            for (j = 0; j < padding_size; j = j + 1) begin
                $fwrite(bmp_file, "%c", 0);
            end
        end

        // Close file
        $fclose(bmp_file);
    end
endtask



endmodule
