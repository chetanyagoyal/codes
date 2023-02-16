module writeback (
    clk, valM, valE, icode, ifun, RrA, RrB, Rrsp, instr_valid
);
    
input clk;
input instr_valid;
input [63:0] valE;
input [63:0] valM;
input [3:0] icode;
input [3:0] ifun;

output reg [63:0] RrA;
output reg [63:0] RrB;
output reg [63:0] Rrsp;

always @(*)
begin
    if (instr_valid)
    begin
        if (icode == 4'd2) //cmovxx
            RrB = valE;
        if (icode == 4'd3) //irmovq
            RrB = valE;
        if (icode == 4'd5) //mrmovq
            RrA = valM;
        if (icode == 4'd6) //Opq
            RrB = valE;  
        if (icode == 4'd8) //call
            Rrsp = valE;
        if (icode == 4'd9) //ret
            Rrsp = valE;
        if (icode == 4'd10) //pushq
            Rrsp = valE; 
        if (icode == 4'd11) //popq
            Rrsp = valE;
            RrA = valM;
    end
end

endmodule