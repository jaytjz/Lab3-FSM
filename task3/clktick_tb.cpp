#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "../vbuddy.cpp" // include vbuddy code
#define MAX_SIM_CYC 100000

int main(int argc, char **argv, char **env)
{
    int simcyc;     // simulation clock count
    int lights = 0; // state to toggle LED lights

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vtop *top = new Vtop;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("top.vcd");

    // init Vbuddy
    if (vbdOpen() != 1)
        return (-1);
    vbdHeader("L3T2:Clktick");
    vbdSetMode(1); // Flag mode set to one-shot

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->N = vbdValue();

    // run simulation for MAX_SIM_CYC clock cycles
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // dump variables into VCD file and toggle clock
        for (int edge = 0; edge < 2; edge++)
        {
            tfp->dump(2 * simcyc + edge);
            top->clk = !top->clk;
            top->eval();
        }

        // Display toggle neopixel
        vbdBar(top->data_out);
        
        // set up input signals of testbench
        top->rst = (simcyc < 2); // assert reset for 1st cycle
        top->N = vbdValue();
        vbdCycle(simcyc);

        if (Verilated::gotFinish() || vbdGetkey() == 'q')
            exit(0);
    }

    vbdClose(); // ++++
    tfp->close();
    exit(0);
}
