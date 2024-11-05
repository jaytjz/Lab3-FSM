module f1_fsm #(
    parameter WIDTH = 8
) (
    input logic clk,
    input logic rst,
    input logic en,
    output logic [WIDTH-1:0] data_out
);

    typedef enum {S_0, S_1, S_2, S_3, S_4, S_5, S_6, S_7, S_8} my_state;
    my_state current_state, next_state;

    always_ff @(posedge clk)
        if (rst)    current_state <= S_0;
        else       current_state <= next_state;

    always_comb
        case (current_state)
            S_0:    if(en)    next_state = S_1;
            S_1:    if(en)    next_state = S_2;
            S_2:    if(en)    next_state = S_3;
            S_3:    if(en)    next_state = S_4;
            S_4:    if(en)    next_state = S_5;
            S_5:    if(en)    next_state = S_6;
            S_6:    if(en)    next_state = S_7;
            S_7:    if(en)    next_state = S_8;
            S_8:    if(en)    next_state = S_0;
            default: next_state = S_0;
        endcase 

    always_comb
        case (current_state)
            S_0:    data_out = 8'b00000000;
            S_1:    data_out = 8'b00000001;
            S_2:    data_out = 8'b00000011;
            S_3:    data_out = 8'b00000111;
            S_4:    data_out = 8'b00001111;
            S_5:    data_out = 8'b00011111;
            S_6:    data_out = 8'b00111111;
            S_7:    data_out = 8'b01111111;
            S_8:    data_out = 8'b11111111;
            default: data_out = 8'b00000000;
        endcase

endmodule
