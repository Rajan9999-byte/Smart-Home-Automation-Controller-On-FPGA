module scheduler(


input wire clk,
input wire rst,

input wire tick_1min,

input wire [5:0] current_hour,
input wire [5:0] current_minute,

output reg [1:0] scene_id,
output reg scene_update


);

always @(posedge clk or posedge rst)
begin


if(rst)
begin
    scene_id <= 0;
    scene_update <= 0;
end

else
begin

    scene_update <= 0;

    if(tick_1min)
    begin

        case({current_hour,current_minute})

            {6'd6,6'd0}:
            begin
                scene_id <= 2'd0;
                scene_update <= 1;
            end

            {6'd18,6'd0}:
            begin
                scene_id <= 2'd2;
                scene_update <= 1;
            end

            {6'd23,6'd0}:
            begin
                scene_id <= 2'd1;
                scene_update <= 1;
            end

            {6'd8,6'd0}:
            begin
                scene_id <= 2'd3;
                scene_update <= 1;
            end

            default:
            begin
                scene_update <= 0;
            end

        endcase

    end

end


end

endmodule
