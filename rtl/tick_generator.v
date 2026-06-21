module tick_generator(

    input  wire clk,
    input  wire rst,

    output reg tick_1khz,
    output reg tick_10hz

);

reg [15:0] cnt_1khz;
reg [22:0] cnt_10hz;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        cnt_1khz <= 0;
        cnt_10hz <= 0;

        tick_1khz <= 0;
        tick_10hz <= 0;
    end
    else
    begin

        tick_1khz <= 0;
        tick_10hz <= 0;

        if(cnt_1khz == 49999)
        begin
            cnt_1khz <= 0;
            tick_1khz <= 1;
        end
        else
            cnt_1khz <= cnt_1khz + 1;

        if(cnt_10hz == 4999999)
        begin
            cnt_10hz <= 0;
            tick_10hz <= 1;
        end
        else
            cnt_10hz <= cnt_10hz + 1;

    end
end

endmodule