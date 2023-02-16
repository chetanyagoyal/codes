module mem (
    icode, ifun, valE, valA, valP, valM, memdata
);
input [3:0] icode;
input [3:0] ifun;
input [63:0] valE;
input [63:0] valA;
input [63:0] valP;
output reg [63:0] valM;
output reg [63:0] memdata;

reg [63:0] data[0:1023];

initial begin
    for (integer i = 0; i < 1024; i++)
    begin
         data[i] = 64'b111; 
    end
end

always @(*) 
begin
    if (icode == 4'd4)
        data[valE] = valA;
    if (icode == 4'd5)
        valM = data[valE];
    if (icode == 4'd8) 
        data[valE] = valP;
    if (icode == 4'd9)
        valM = data[valA];
    if (icode == 4'd10)
        data[valE] = valA;
    if (icode == 4'd11)
        valM = data[valE];
    
    memdata = data[valE];
end

endmodule