module scene_rom(

    input  wire [1:0] scene_id,

    output reg  [17:0] scene_data

);

always @(*)
begin

    case(scene_id)

        // HOME

        2'd0:
            scene_data =
            {
                1'b0,       // security
                1'b0,       // ac
                8'd128,     // fan 50%
                8'd255      // light 100%
            };

        // AWAY

        2'd1:
            scene_data =
            {
                1'b1,
                1'b0,
                8'd0,
                8'd0
            };

        // NIGHT

        2'd2:
            scene_data =
            {
                1'b1,
                1'b0,
                8'd64,
                8'd76
            };

        // VACATION

        2'd3:
            scene_data =
            {
                1'b1,
                1'b0,
                8'd0,
                8'd25
            };

        default:
            scene_data = 18'd0;

    endcase

end

endmodule