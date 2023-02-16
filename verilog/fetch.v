module fetch (
    clk, pc, icode, ifun, rA, rB, valC, valP,halt, instr_valid, imem_error
);

input clk;
input [63:0] pc;
output reg [3:0] icode;
output reg [3:0] ifun;
output reg [3:0] rA;
output reg [3:0] rB;
output reg [63:0] valC;
output reg [63:0] valP;
output reg halt;
output reg instr_valid;
output reg imem_error;
reg [0:79] instr; 
reg [7:0] instr_mem [0:119];  // little endian  


always @(*)
begin
    instr_valid = 1'b1;
    imem_error = 1'b0;
    halt = 1'b0;

    if(pc > 119)
    begin
        imem_error = 1'b1;
    end

    instr_mem[0]  = 8'b00010000; // nop instruction pc = pc +1 = 1
    instr_mem[1]  = 8'b01100000; // Opq add
    instr_mem[2]  = 8'b00000001; // rA = 0, rB = 1; pc = pc + 2 = 3

    instr_mem[3]  = 8'b00110000; // irmovq instruction pc = pc + 10 = 13
    instr_mem[4]  = 8'b11110010; // F, rB = 2;
    instr_mem[5]  = 8'b11111111; // 1st byte of V = 255, rest all bytes will be zero
    instr_mem[6]  = 8'b00000000; // 2nd byte
    instr_mem[7]  = 8'b00000000; // 3rd byte
    instr_mem[8]  = 8'b00000000; // 4th byte
    instr_mem[9]  = 8'b00000000; // 5th byte
    instr_mem[10] = 8'b00000000; // 6th byte
    instr_mem[11] = 8'b00000000; // 7th byte
    instr_mem[12] = 8'b00000000; // 8th byte (This completes irmovq)

    instr_mem[13] = 8'b00110000; // irmovq instruction pc = pc + 10 = 23
    instr_mem[14] = 8'b11110011; // F, rB = 3;
    instr_mem[15] = 8'b00000101; // 1st byte of V = 5, rest all bytes will be zero
    instr_mem[16] = 8'b00000000; // 2nd byte
    instr_mem[17] = 8'b00000000; // 3rd byte
    instr_mem[18] = 8'b00000000; // 4th byte
    instr_mem[19] = 8'b00000000; // 5th byte
    instr_mem[20] = 8'b00000000; // 6th byte
    instr_mem[21] = 8'b00000000; // 7th byte
    instr_mem[22] = 8'b00000000; // 8th byte (This completes irmovq)

    instr_mem[23] = 8'b00110000; // irmovq instruction pc = pc + 10 = 33
    instr_mem[24] = 8'b11110100; // F, rB = 4;
    instr_mem[25] = 8'b00000101; // 1st byte of V = 5, rest all bytes will be zero
    instr_mem[26] = 8'b00000000; // 2nd byte
    instr_mem[27] = 8'b00000000; // 3rd byte
    instr_mem[28] = 8'b00000000; // 4th byte
    instr_mem[29] = 8'b00000000; // 5th byte
    instr_mem[30] = 8'b00000000; // 6th byte
    instr_mem[31] = 8'b00000000; // 7th byte
    instr_mem[32] = 8'b00000000; // 8th byte (This completes irmovq)

    instr_mem[33] = 8'b00100000; // rrmovq // pc = pc + 2 = 35
    instr_mem[34] = 8'b01000101; // rA = 4; rB = 5; 

    instr_mem[35] = 8'b01100000; // Opq add // pc = pc + 2 = 37
    instr_mem[36] = 8'b00110100; // rA = 3 and rB = 4, final value in rB(4) = 10;

    instr_mem[37] = 8'b00100101; // cmovge // pc = pc + 2 = 39
    instr_mem[38] = 8'b01010110; // rA = 5; rB = 6;

    instr_mem[39] = 8'b01100001; // Opq subq // pc = pc + 2 = 41
    instr_mem[40] = 8'b00110101; // rA = 3, rB = 5; both are equal

    instr_mem[41] = 8'b01110011; //je // pc = pc + 9 = 50
    instr_mem[42] = 8'b00110100; // Dest = 52; 1st byte
    instr_mem[43] = 8'b00000000; // 2nd byte
    instr_mem[44] = 8'b00000000; // 3rd byte
    instr_mem[45] = 8'b00000000; // 4th byte
    instr_mem[46] = 8'b00000000; // 5th byte
    instr_mem[47] = 8'b00000000; // 6th byte
    instr_mem[48] = 8'b00000000; // 7th byte
    instr_mem[49] = 8'b00000000; // 8th byte

    instr_mem[50] = 8'b00010000; // nop 
    instr_mem[51] = 8'b00010000; // nop

    instr_mem[52] = 8'b01100000; // Opq add
    instr_mem[53] = 8'b00110101; // rA = 3; rB = 5;

    instr_mem[54] = 8'b00000000; // halt

    instr = {instr_mem[pc], instr_mem[pc+1], instr_mem[pc+2], instr_mem[pc+3], instr_mem[pc+4], instr_mem[pc+5], instr_mem[pc+6], instr_mem[pc+7], instr_mem[pc+8], instr_mem[pc+9]};

    icode = instr[0:3];
    ifun = instr[4:7];

    rA = instr[8:11];
    rB = instr[12:15];

    case(icode)
        4'b0000:
        begin //halt
            halt = 1;
            valP = pc + 1;
            rA = 4'd15;
            rB = 4'd15;
        end

        4'b0001: //no op
        begin
            valP = pc + 1;
            rA = 4'd15;
            rB = 4'd15;
        end

        4'b0010: //rrmov or cmovXX 
            valP = pc + 2;

        4'b0011:
        begin //irmovq
            valP = pc + 10;
            valC = instr[16:79];
            rA = 4'd15;
        end

        4'b0100:
        begin //rmmovq
            valP = pc + 10;
            valC = instr[16:79];
        end

        4'b0101:
        begin //mrmovq
            valP = pc + 10;
            valC = instr[16:79];
        end

        4'b0110: //OPq
            valP = pc + 2;

        4'b0111:
        begin //jxx
            valP = pc + 9;
            valC = instr[8:71];
            rA = 4'd15;
            rB = 4'd15;
        end

        4'b1000:
        begin //call
            valP = pc + 9;
            valC = instr[8:71];  
            rA = 4'd15;
            rB = 4'd15;
        end

        4'b1001: //ret
        begin
            valP = pc + 1;
            rA = 4'd15;
            rB = 4'd15;
        end

        4'b1010:  //pushq
        begin
            valP = pc + 2;
            rB = 4'd15;
        end

        4'b1011: //popq
        begin
            valP = pc + 2;
            rB = 4'd15;
        end

        default : instr_valid = 0;
    endcase
end

endmodule
