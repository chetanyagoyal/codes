///////////////////////////////////////////////
// t = a OP b                                //
// of = (a < 0 == b < 0) && (t < 0 != a < 0) //
// sf = (t < 0)                              //
// zf = (t == 0)                             //
///////////////////////////////////////////////

`include "ALU.v"
module execute (
    clk, icode, ifun, valC, valA, valB, cndflags, valE, cnd
);

input clk;
input [3:0] icode; 
input [3:0] ifun;
input [63:0] valA;
input [63:0] valB;
input [63:0] valC;             
output reg [63:0] valE;
output reg [2:0] cndflags; // [zf, sf, of]
output reg cnd;

wire signed [63:0] outalu;
reg signed [63:0] aa;
reg signed [63:0] bb;
wire overflow;
reg [1:0] select;

ALU alu1(aa, bb, outalu, select, overflow);

initial 
begin
    select[0] = ifun[0];
    select[1] = ifun[1];
    aa = valB;
    bb = valA;
    cndflags = 3'b0;
    cnd = 1'b0;
end

always @(*)
begin
    //cndflags = 3'b0;
    if (icode == 4'd6) //OPq
    begin
        cndflags = 3'b0;
        select[0] = ifun[0];
        select[1] = ifun[1];
        aa = valB;
        bb = valA;
        valE = outalu;
        if (ifun == 4'd0) //addq
        begin
            if (overflow)
                cndflags = 4;
        end
        else if (ifun == 4'd1) //subq
        begin
            if (overflow)
                cndflags = 4;
        end
        if (outalu == 0)
            cndflags = 1;
        else if (outalu < 0 && overflow != 1)
            cndflags = 2;
    end
    else if (icode == 4'd4 || icode == 4'd5) //rmmovq mrmovq
    begin
        select = 0;
        aa = valB;
        bb = valC;
        valE = outalu;
    end
    else if (icode == 4'd11 || icode == 4'd9) //popq or ret
    begin
        select = 0;
        aa = valB;
        bb = 64'd8;
        valE = outalu;
    end
    else if (icode == 4'd10 || icode == 4'd8) //pushq or call
    begin
        select = 1;
        aa = valB;
        bb = 64'd8;
        valE = outalu;
    end
    else if (icode == 4'd2) //cmovxx
    begin
        select = 0;
        if (ifun == 4'd0) //rrmovq
        begin
            
        end
        if (ifun == 4'd1) //cmovle
        begin
            if (cndflags[0] || cndflags[1] ^ cndflags[2])
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
        if (ifun == 4'd2) //cmovl
        begin
            if (cndflags[1] ^ cndflags[2])
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
        if (ifun == 4'd3) //cmove
        begin
            if (cndflags[0])
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
        if (ifun == 4'd4) //cmovne
        begin
            if (cndflags[0] == 0)
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
        if (ifun == 4'd5) //cmovge
        begin
            if (cndflags[1] == cndflags[2])
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
        if (ifun == 4'd6) //cmovg
        begin
            if (cndflags[0] == 0 && ((cndflags[1] ^ cndflags[2]) == 1))
            begin
                aa = 64'd0;
                bb = valA;
                valE = outalu;
            end
        end
    end
    else if (icode == 4'd3) //irmovq
    begin
        select = 0;
        aa = 64'd0;
        bb = valC;
        valE = outalu;
    end
    else if (icode == 4'd7) //jXX
    begin
        if (ifun == 4'd0) //jmp
            cnd = 1'b1;
        if (ifun == 4'd1) //jle 
            if (cndflags[0] || cndflags[1] ^ cndflags[2])
                cnd = 1'b1;
        if (ifun == 4'd2) //jl 
            if (cndflags[1] ^ cndflags[2])
                cnd = 1'b1;
        if (ifun == 4'd3) //je
            if (cndflags[0])
                cnd = 1'b1;
        if (ifun == 4'd4) //jne 
            if (cndflags[0] == 0)
                cnd = 1'b1;
        if (ifun == 4'd5) //jge 
            if (cndflags[1] == cndflags[2])
                cnd = 1'b1;
        if (ifun == 4'd6) //jg
            if (cndflags[0] == 0 && ((cndflags[1] ^ cndflags[2]) == 1))
                cnd = 1'b1;
    end
end

endmodule


