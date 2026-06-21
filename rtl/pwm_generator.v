module pwm_generator (

    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] duty,

    output reg        pwm_out

);

    reg [7:0] counter;

    // PWM Counter
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            counter <= 8'd0;
        else
            counter <= counter + 1'b1;
    end

    // PWM Compare Logic
    always @(*)
    begin
        if (counter < duty)
            pwm_out = 1'b1;
        else
            pwm_out = 1'b0;
    end

endmodule