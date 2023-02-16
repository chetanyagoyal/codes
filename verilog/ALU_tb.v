`timescale 10ns/1ps

module ALU_tb;

initial 
begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars(0, ALU_tb);    
end

reg signed [63:0] a;
reg signed [63:0] b;
reg [1:0] select;
wire signed [63:0] s;
wire overflow;

ALU uut(
    .a(a),
    .b(b),
    .s(s), 
    .overflow(overflow),
    .select(select)
);

initial
begin
    a = 0;
    b = 0;
    select = 2'b00;
    #10;
    select = 2'b10;
    a = 2938;
    b = 2938;
    #10;
    select = 2'b00;
    a = 10;
    b = -7;
    #10;
    select = 2'b01;
    a = 10;
    b = -7;
    #10;
    select = 2'b11;
    a = 2938;
    b = 2938;
    #10;
    select = 2'b01;
    a = -173733462;
    b = -9866987;
    #10;
    select = 2'b00;
    a = 9223372036854775805;
    b = 9223372036854775805;
    #10
    select = 2'b10;
    a = 1'b1;
    b = 1'b1;
end

initial 
begin
    $monitor("time = %3d, a = %d, b = %d, s = %d, overflow = %1b, select = %d", $time, a, b, s, overflow, select);
end

endmodule
