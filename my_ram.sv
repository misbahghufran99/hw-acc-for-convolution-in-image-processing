module my_ram #(parameter N=10,M=8)
(clk, we, adr, din, dout);

input logic clk,we;
input logic [N-1:0]adr;
input logic [M-1:0]din;
output logic [M-1:0]dout;

logic [M-1:0]mem[2**N-1:0];

// Load hex file into memory during simulation
initial begin
    $readmemh("D:\\IC Design Summer School 2024\\IC Design Project\\verif\\conv_hw_acc\\32 by 32 img.hex", mem);
end

always @(posedge clk)
begin
if (we)
mem[adr]<=din;
end

assign dout=mem[adr];


endmodule