module lfsr_7 (
    input   logic       clk,
    output  logic [7:1] data_out
);

logic[7:1] sreg;

always_ff @ (posedge clk, posedge rst)
    sreg <= {sreg[6:1], sreg[3] ^ sreg[7]};

assign data_out = sreg;

endmodule
