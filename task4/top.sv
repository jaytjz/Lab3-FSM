module top(
    input logic clk,
    input logic rst,
    input logic trigger,
    input logic N,
    output logic [7:0] data_out
);

logic K;
logic cmd_delay;
logic cmd_seq;
logic time_out;
logic tick;
logic mux_out;

lfsr_7 myLfsr7(
    .clk(clk),
    .data_out(K)
);

delay myDelay(
    .clk(clk),
    .rst(rst),
    .trigger(cmd_delay),
    .n(K),
    .time_out(time_out)
);

clktick myClktick(
    .clk(clk),
    .rst(rst),
    .en(cmd_seq),
    .N(N),
    .tick(tick)
);

mux2 myMux2(
    .sel(cmd_seq),
    .d0(time_out),
    .d1(tick),
    .dout(mux_out)
);

f1_fsm myFsm(
    .clk(clk),
    .rst(rst),
    .en(mux_out),
    .trigger(trigger),
    .data_out(data_out),
    .cmd_seq(cmd_seq),
    .cmd_delay(cmd_delay)
);

endmodule
