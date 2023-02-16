`include "execute.v"
`include "decode.v"
`include "mem.v"
`include "writeback.v"

module testde 
(
    clk, instr_valid, icode, ifun, RrA, RrB, Rrsp, valC, valE, cnd, cndflags, memdata, valM
);

input clk;
input instr_valid;
input [3:0] icode;
input [3:0] ifun;
input [63:0] RrA;
input [63:0] RrB;
input [63:0] Rrsp;
input [63:0] valC;
input [63:0] valP;
output reg [63:0] valE;
output reg [63:0] valM;
output reg [63:0] memdata;
output cnd;
output [2:0] cndflags;

/////////////////////////////////////
// decode                          //
wire signed [63:0] valA_decode;    //                
wire signed [63:0] valB_decode;    //                
reg instr_valid_decode;            //           
reg [3:0] icode_decode;            //            
reg [3:0] ifun_decode;             //            
reg signed [63:0] RrA_decode;      //           
reg signed [63:0] RrB_decode;      //            
reg signed [63:0] Rrsp_decode;     //          
reg clk_decode;                    //
// execute                         //
reg clk_execute;                   //
reg [3:0] icode_execute;           //                 
reg [3:0] ifun_execute;            //            
reg signed [63:0] valA_execute;    //               
reg signed [63:0] valB_execute;    //                
reg signed [63:0] valC_execute;    //                             
wire signed [63:0] valE_execute;   //              //============\\
wire [2:0] cndflags_execute;       //             || [zf, sf, of] ||
wire cnd_execute;                  //              \\=============/      
// memory                          //              
reg [3:0] icode_mem;               //
reg [3:0] ifun_mem;                //
reg signed [63:0] valE_mem;        //
reg signed [63:0] valA_mem;        //
reg signed [63:0] valP_mem;        //
wire signed [63:0] memdata_mem;    //
wire signed [63:0] valM_mem;       //
// writeback                       //
reg clk_wb;                        //
reg signed [63:0] valM_wb;         //
reg signed [63:0] valE_wb;         //
reg [3:0] icode_wb;                //
reg [3:0] ifun_wb;                 //
reg inst_valid_wb;                 //
wire signed [63:0] RrA_wb;         //
wire signed [63:0] RrB_wb;         //
wire signed [63:0] Rrsp_wb;        //
/////////////////////////////////////

decode d1(clk_decode, valA_decode, valB_decode, icode_decode, ifun_decode, RrA_decode, RrB_decode, Rrsp_decode, instr_valid_decode);
execute e1(clk_execute, icode_execute, ifun_execute, valC_execute, valA_execute, valB_execute, cndflags, valE_execute, cnd);
mem m1(icode_mem, ifun_mem, valE_mem, valA_mem, valP_mem, valM_mem, memdata_mem);
writeback w1(clk_wb, valM_wb, valE_wb, icode_wb, ifun_wb, RrA_wb, RrB_wb, Rrsp_wb, inst_valid_wb);

always @(*) 
begin
    clk_decode = clk;
    RrA_decode = RrA;
    RrB_decode = RrB;
    Rrsp_decode = Rrsp;
    icode_decode = icode;
    ifun_decode = ifun;
    instr_valid_decode = instr_valid;
    valC_execute = valC;
    valA_execute = valA_decode;
    valB_execute = valB_decode;
    icode_execute = icode;
    ifun_execute = ifun;
    clk_execute = clk;
    icode_mem = icode;
    ifun_mem = ifun;
    valP_mem = valP;
    memdata = memdata_mem;
    valM = valM_mem;
    valE_mem = valE_execute;
    valA_mem = valA_decode;
end


always @(*)
begin
    if (instr_valid)
    begin
        if (icode == 4'd2) //cmovq
        begin
            RrA_decode = RrA;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            valC_execute = valC;
        end
        if (icode == 4'd4) //rmmovl
        begin
            RrA_decode = RrA;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            RrB_decode = RrB;
            valB_execute = valB_decode;
            valC_execute = valC;
        end
        if (icode == 4'd5) //mrmovl
        begin
            RrB_decode = RrB;
            valB_execute = valB_decode;
            valC_execute = valC;
        end
        if (icode == 4'd6)
        begin        
            RrA_decode = RrA;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            RrB_decode = RrB;
            valB_execute = valB_decode;
            valC_execute = valC;
        end
        if (icode == 4'd8) //call
        begin
            RrB_decode = Rrsp;
            valB_execute = valB_decode;
            valC_execute = valC;
        end
        if (icode == 4'd9) //ret
        begin
            RrA_decode = Rrsp;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            RrB_decode = Rrsp;
            valB_execute = valB_decode;
            valC_execute = valC;
        end
        if (icode == 4'd10) //pushl
        begin
            RrA_decode = Rrsp;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            valC_execute = valC;
        end
        if (icode == 4'd11) //popl
        begin
            RrA_decode = Rrsp;
            valA_execute = valA_decode;
            valA_mem = valA_decode;
            valC_execute = valC;
        end
        valE = valE_execute;
        valE_mem = valE_execute;
        valM = valM_mem;
        memdata = memdata_mem;
        //cnd = cnd_execute;
        //cndflags = cndflags_execute;
    end
end
endmodule
