module decode (
    clk, valA, valB, icode, ifun, RrA, RrB, Rrsp, instr_valid
);

output reg [63:0] valA;
output reg [63:0] valB;
input instr_valid;
input [3:0] icode;
input [3:0] ifun;
input [63:0] RrA;
input [63:0] RrB;
input [63:0] Rrsp;
input clk;

always @(*) 
begin
    if (instr_valid)
    begin
        if (icode == 4'd0 || icode == 4'd1)
        begin
            valA = 64'd15;
            valB = 64'd15;
        end
        if (icode == 4'd2)
            valA = RrA;
        if (icode == 4'd4) //rmmovl
        begin
            valA = RrA;
            valB = RrB;
        end
        if (icode == 4'd5) //mrmovl
        begin
            valB = RrB;
        end
        if (icode == 4'd6)
        begin        
            valA = RrA;
            valB = RrB;   
        end
        if (icode == 4'd8) //call
            valB = Rrsp;
        if (icode == 4'd9) //ret
        begin
            valA = Rrsp;
            valB = Rrsp;
        end
        if (icode == 4'd10) //pushl
        begin
            valA = RrA;
            valB = Rrsp;
        end
        if (icode == 4'd11) //popl
        begin
            valA = Rrsp;
            valB = Rrsp;
        end
    end
end
endmodule

// halt 00
// nop 10
// rrmovl rA, rB 20rArB
// irmovl V, rB 30FrB V
// rmmovl rA, D(rB) 40rArB D
// mrmovl D(rA), rB 50rArB D
// OP1 rA, rB 6fnrArB
// jXX Dest 7f D
// cmovxx rA, rB 2fnrArB
// call Dest 80 D
// ret 90
// pushl rA A0rAF
// popl rA B0rAF 