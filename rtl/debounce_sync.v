module debounce_sync #
(
    parameter DEBOUNCE_COUNT = 50000
)
(
    input  wire clk,
    input  wire rst,

    input  wire async_in,

    output wire sync_out,
    output reg  level_out,
    output reg  rise_pulse
);

    //--------------------------------------------------
    // 2-FF Synchronizer
    //--------------------------------------------------

    reg sync_ff1;
    reg sync_ff2;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            sync_ff1 <= 1'b0;
            sync_ff2 <= 1'b0;
        end
        else
        begin
            sync_ff1 <= async_in;
            sync_ff2 <= sync_ff1;
        end
    end

    assign sync_out = sync_ff2;

    //--------------------------------------------------
    // Debounce Counter
    //--------------------------------------------------

    reg [31:0] counter;
    reg stable_state;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            counter      <= 0;
            stable_state <= 0;
        end
        else
        begin

            if(sync_ff2 != stable_state)
            begin

                if(counter == DEBOUNCE_COUNT-1)
                begin
                    stable_state <= sync_ff2;
                    counter      <= 0;
                end
                else
                begin
                    counter <= counter + 1'b1;
                end

            end
            else
            begin
                counter <= 0;
            end

        end
    end

    //--------------------------------------------------
    // Level Output
    //--------------------------------------------------

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            level_out <= 0;
        else
            level_out <= stable_state;
    end

    //--------------------------------------------------
    // Rising Edge Pulse
    //--------------------------------------------------

    reg level_d;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            level_d    <= 0;
            rise_pulse <= 0;
        end
        else
        begin

            level_d <= level_out;

            rise_pulse <= level_out & ~level_d;

        end
    end

endmodule