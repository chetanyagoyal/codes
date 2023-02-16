module PCUpd (
    icode, jmpcnd, valC, valM, valP, PC
);

input [3:0] icode;
input jmpcnd;
input [63:0] valC;
input [63:0] valM;
input [63:0] valP;
output reg [63:0] PC;

always @(*) 
begin
    if (icode <= 4'd11 && icode >= 4'd2) 
    begin
        if (icode == 4'd9) begin
            PC = valM; 
            end
        else if (icode == 4'd7) begin
            if(jmpcnd)
                PC = valP;
            else 
                PC = valC;
        end
        else if (icode == 4'd8) begin
            PC = valC;
        end
        else 
            PC = valP;

    end
end

endmodule