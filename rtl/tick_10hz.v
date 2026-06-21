module tick_10hz
#(
    parameter CLK_FREQ = 50_000_000,
    parameter TICK_FREQ = 10
)
(
    input wire clk,
    input wire rst,

    output reg tick
);

localparam COUNT_MAX = CLK_FREQ/TICK_FREQ - 1;

reg [22:0] counter;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        counter <= 0;
        tick    <= 0;
    end
    else
    begin
        if(counter == COUNT_MAX)
        begin
            counter <= 0;
            tick    <= 1'b1;
        end
        else
        begin
            counter <= counter + 1'b1;
            tick    <= 1'b0;
        end
    end
end

endmodule