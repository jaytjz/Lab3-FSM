module top(
    input logic clk,
    input logic rst,
    input logic [15:0] N,
    output logic [7:0] data_out
);

logic en = 1'b1;
logic tick;

clktick myclktick(
    .clk(clk),
    .rst(rst),
    .N(N),
    .en(en),
    .tick(tick)
);

f1_fsm myf1_fsm(
    .clk(clk),
    .rst(rst),
    .en(tick),
    .data_out(data_out)
);

endmodule
