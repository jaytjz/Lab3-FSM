module mux2(
    input logic       sel, 
    input logic       d0,
    input logic       d1,
    output logic      dout
);

    always_comb
        case (sel)
            1'b0: dout = d0; 
            1'b1: dout = d1; 
            default: dout = d0;
        endcase

endmodule
