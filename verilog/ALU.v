/*------------------------------------------------------------------*/
/*                                                                  */
/*                                                                  */
/*                                                                  */
/*                                                                  */
/*                         ALU                                      */
/*                         CHETANYA GOYAL                           */
/*                         AJIT S                                   */
/*                                                                  */
/*                                                                  */
/*                                                                  */
/*------------------------------------------------------------------*/

module halfadder(ahalf, bhalf, shalf, chalf);

input ahalf;
input bhalf;
output shalf;
output chalf;

xor x1(shalf, ahalf, bhalf);
and a1(chalf, ahalf, bhalf);

endmodule

module fulladder(afull, bfull, cfullin, sfull, cfull);

input afull;
input bfull;
input cfullin;
output sfull;
output cfull;
wire x, y, z;

halfadder h1(afull, bfull, x, y);
halfadder h2(cfullin, x, sfull, z);
or o1(cfull, y, z);

endmodule

module ADD(a, b, s, overflow);

input [63:0] a;
input [63:0] b;
output [63:0] s;
output overflow;

wire control;
wire [63:0] xorout;
wire [63:0] carry;

//control 1 for subtraction, 0 for addition 

assign control = 1'b0;
genvar i;
generate 
    for (i = 0; i < 64; i = i + 1)
        begin
            xor x(xorout[i], b[i], control);
        end
endgenerate

genvar j;
generate
    for (j = 0; j < 64; j = j + 1)
    begin
        if (j == 0)
            fulladder f(a[j], xorout[j], control, s[j], carry[j]);
        else 
            fulladder f(a[j], xorout[j], carry[j - 1], s[j], carry[j]);
    end
endgenerate

//assign overflow = (a[3] ^ b[3]) ? 0 : (s[3] ^ a[3]);
xor x4 (overflow, carry[63], carry[62]);

endmodule


module SUB(a, b, d, overflow);

input [63:0] a;
input [63:0] b;
output [63:0] d;
output overflow;

wire control;
wire [63:0] xorout;
wire [63:0] carry;

//control 1 for subtraction, 0 for addition 

assign control = 1'b1;
genvar i;
generate 
    for (i = 0; i < 64; i = i + 1)
        begin
            xor x(xorout[i], b[i], control);
        end
endgenerate

genvar j;
generate
    for (j = 0; j < 64; j = j + 1)
    begin
        if (j == 0)
            fulladder f(a[j], xorout[j], control, d[j], carry[j]);
        else 
            fulladder f(a[j], xorout[j], carry[j - 1], d[j], carry[j]);
    end
endgenerate
//assign overflow = (a[3] ^ b[3]) ? 0 : (d[3] ^ a[3]);

xor x4 (overflow, carry[63], carry[62]);

endmodule

module AND(a, b, out);

// inputs A and B
// output out 
// bitwise AND operation

input [63:0] a;
input [63:0] b;
output [63:0] out;

genvar i;
generate
    for (i = 0; i < 64; i = i + 1)
    begin
        and a(out[i], a[i], b[i]);
    end
endgenerate

endmodule

module XOR(a, b, out);

// inputs A and B
// output out 
// bitwise XOR operation

input [63:0] a;
input [63:0] b;
output [63:0] out;

genvar i;
generate
    for (i = 0; i < 64; i = i + 1)
    begin
        xor x(out[i], a[i], b[i]);
    end
endgenerate

endmodule

module ALU(a, b, s, select, overflow);

input [63:0] a;
input [63:0] b;
input [1:0] select;

output reg [63:0] s;
output reg overflow;

wire signed [63:0] outtempadd;
wire signed [63:0] outtempsub;
wire signed [63:0] outtempand;
wire signed [63:0] outtempxor;
wire signed overflowtempadd, overflowtempsub;

ADD a1(a, b, outtempadd, overflowtempadd);
SUB s1(a, b, outtempsub, overflowtempsub);
AND and11(a, b, outtempand);
XOR x11(a, b, outtempxor);

always @(*)
begin
    if (select == 2'b00)
    begin
        s = outtempadd; //add
        overflow = overflowtempadd;
    end
    else if (select == 2'b01)
    begin
        s = outtempsub; //sub
        overflow = overflowtempsub;
    end
    else if (select == 2'b10)
    begin
        s = outtempand; //AND
    end
    else if (select == 2'b11)
    begin
        s = outtempxor; //XOR        
    end
end

endmodule
