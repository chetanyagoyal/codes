`timescale 10ns/1ps

module fetch_tb;

initial 
begin
    $dumpfile("fetch_tb.vcd");
    $dumpvars(0, fetch_tb);    
end

reg clk;
reg [63:0] pc;
wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;
wire [63:0] valC;
wire [63:0] valP;
wire halt;
wire instr_valid;
wire imem_error;

fetch f1
(
    .clk(clk),
    .pc(pc),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .halt(halt),
    .instr_valid(inst_valid),
    .imem_error(imem_error)
);

initial
    clk = 0;

parameter CLOCK_PER = 10;
always #CLOCK_PER
begin
    clk = ~clk;
end

initial 
begin 
    pc = 64'd0;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    pc = valP;
    #10;
    $finish;
end 

initial
begin
    $monitor("pc = %d, icode = %d, ifun = %d, valC = %d, valP = %d, rA = %d, rB = %d", pc, icode, ifun, valC, valP, rA, rB);
end
endmodule