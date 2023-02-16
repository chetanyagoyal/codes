`timescale 10ns/1ps

module testde_tb;

initial begin
    $dumpfile("testde_tb.vcd");
    $dumpvars(0, testde_tb);
end

reg clk;
reg instr_valid;
reg [3:0] icode;
reg [3:0] ifun;
reg signed [63:0] RrA;
reg signed [63:0] RrB;
reg signed [63:0] Rrsp;
reg signed [63:0] valC;
reg signed [63:0] valP;
wire signed [63:0] valE;
wire signed [63:0] memdata;
wire signed [63:0] valM;
wire cnd;
wire [2:0] cndflags;

testde t1
(
    .clk(clk),
    .instr_valid(instr_valid),
    .icode(icode),
    .ifun(ifun),
    .RrA(RrA),
    .RrB(RrB),
    .Rrsp(Rrsp),
    .valC(valC),
    .valE(valE),
    .cnd(cnd),
    .cndflags(cndflags),
    .memdata(memdata),
    .valM(valM)
);

parameter CLK_PER = 1000;
initial
    clk = 0;
always #CLK_PER
    clk = ~clk;


initial begin
    instr_valid = 1'b0; valP = 64'd10;
    icode = 4'b0;  ifun = 4'b0; RrA = 64'b0; RrB = 64'b0; Rrsp = 64'b0; valC = 64'd10;
    #1000;
    instr_valid = 1'b1;
    icode = 4'd0; ifun = 4'd0; RrA = 64'd1; RrB = 64'd18; Rrsp = 64'd2; valC = 64'd10; 
    #1000;
    icode = 4'd1; ifun = 4'd0; RrA = 64'd2; RrB = 64'd17; Rrsp = 64'd3; valC = 64'd10;
    #1000;
    icode = 4'd4; ifun = 4'd0; RrA = 64'd9; RrB = 64'd10; Rrsp = 64'd10; valC = 64'd11;
    #1000;
    icode = 4'd5; ifun = 4'd0; RrA = 64'd10; RrB = 64'd9; Rrsp = 64'd11; valC = 64'd11;
    #1000;
    icode = 4'd6; ifun = 4'd0; RrA = 64'd11; RrB = 64'd8; Rrsp = 64'd12; valC = 64'd11;
    #1000;
    icode = 4'd6; ifun = 4'd1; RrA = 64'd12; RrB = 64'd7; Rrsp = 64'd13; valC = 64'd11;
    #1000;
    icode = 4'd6; ifun = 4'd2; RrA = 64'd13; RrB = 64'd6; Rrsp = 64'd14; valC = 64'd11;
    #1000;
    icode = 4'd6; ifun = 4'd3; RrA = 64'd14; RrB = 64'd5; Rrsp = 64'd15; valC = 64'd11;
    #1000;
    icode = 4'd8; ifun = 4'd0; RrA = 64'd15; RrB = 64'd4; Rrsp = 64'd16; valC = 64'd11;
    #1000;
    icode = 4'd9; ifun = 4'd0; RrA = 64'd16; RrB = 64'd3; Rrsp = 64'd17; valC = 64'd11;
    #1000;
    icode = 4'd10; ifun = 4'd0; RrA = 64'd17; RrB = 64'd2; Rrsp = 64'd18; valC = 64'd14;
    #1000;
    icode = 4'd11; ifun = 4'd0; RrA = 64'd18; RrB = 64'd1; Rrsp = 64'd19; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd0; RrA = 64'd3; RrB = 64'd16; Rrsp = 64'd4; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd1; RrA = 64'd4; RrB = 64'd15; Rrsp = 64'd5; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd2; RrA = 64'd5; RrB = 64'd14; Rrsp = 64'd6; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd3; RrA = 64'd6; RrB = 64'd13; Rrsp = 64'd7; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd4; RrA = 64'd7; RrB = 64'd12; Rrsp = 64'd8; valC = 64'd10;
    #1000;
    icode = 4'd2; ifun = 4'd5; RrA = 64'd8; RrB = 64'd11; Rrsp = 64'd9; valC = 64'd10;
    #1000;
    $finish;
end

initial begin
    $monitor("icode = %d, ifun = %d, R[rA] = %d, R[rB] = %d, R[rsp] = %d\n valE = %d, cnd = %d, cndflags = %d, valM = %d, memdata = %d", icode, ifun, RrA, RrB, Rrsp, valE, cnd, cndflags, valM, memdata);
end

endmodule