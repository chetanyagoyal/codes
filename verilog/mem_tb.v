`timescale 10ns/1ps

module mem_tb;

initial begin
    $dumpfile("mem_tb.vcd");
    $dumpvars(0, mem_tb);
end

reg [3:0] icode;
reg [3:0] ifun;
reg signed [63:0] valE;
reg signed [63:0] valA;
reg signed [63:0] valP;
wire signed [63:0] valM;
wire signed [63:0] memdata;

mem m1
(
    .icode(icode),
    .ifun(ifun),
    .valE(valE),
    .valA(valA),
    .valP(valP),
    .valM(valM),
    .memdata(memdata)
);

initial begin
    icode = 4'd0; ifun = 4'd0; valE = 64'd0; valA = 64'd0; valP = 64'd0;
    #10;
    icode = 4'd1; ifun = 4'd0; valA = 64'd10; valE = 64'd10; valP = 64'd10;
    #10;
    icode = 4'd2; ifun = 4'd0;
    #10;
    icode = 4'd3; ifun = 4'd0;
    #10;
    icode = 4'd4; ifun = 4'd0;
    #10;
    icode = 4'd5; ifun = 4'd0;
    #10;
    icode = 4'd6; ifun = 4'd0;
    #10;
    icode = 4'd7; ifun = 4'd0;
    #10;
    icode = 4'd8; ifun = 4'd0;
    #10;
    icode = 4'd9; ifun = 4'd0;
    #10;
    icode = 4'd10; ifun = 4'd0;
    #10;
    icode = 4'd11; ifun = 4'd0;
end

initial
begin
    $monitor("icode = %d, ifun = %d, valA = %d, valE = %d, valP = %d, memdata = %d, valM = %d", icode, ifun, valA, valE, valP, memdata, valM);
end
endmodule