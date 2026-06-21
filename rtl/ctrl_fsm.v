module ctrl_fsm(
input clk,
input rst,

input manual_mode,
input schedule_mode,

input motion_sensor,
input dark_room,

input alarm_trigger,

output reg [1:0] current_state,

output reg light_enable,
output reg fan_enable,
output reg alarm_enable
);

parameter AUTO     = 2'b00;
parameter MANUAL   = 2'b01;
parameter SCHEDULE = 2'b10;
parameter ALARM    = 2'b11;

always @(posedge clk or posedge rst)
begin


if(rst)
    current_state <= AUTO;

else
begin

    case(current_state)

        AUTO:
        begin
            if(alarm_trigger)
                current_state <= ALARM;
            else if(manual_mode)
                current_state <= MANUAL;
            else if(schedule_mode)
                current_state <= SCHEDULE;
            else
                current_state <= AUTO;
        end

        MANUAL:
        begin
            if(alarm_trigger)
                current_state <= ALARM;
            else if(!manual_mode)
                current_state <= AUTO;
        end

        SCHEDULE:
        begin
            if(alarm_trigger)
                current_state <= ALARM;
            else if(!schedule_mode)
                current_state <= AUTO;
        end

        ALARM:
        begin
            if(!alarm_trigger)
                current_state <= AUTO;
        end

        default:
            current_state <= AUTO;

    endcase

end


end

always @(*)
begin


light_enable = 1'b0;
fan_enable   = 1'b0;
alarm_enable = 1'b0;

case(current_state)

    AUTO:
    begin
        if(motion_sensor && dark_room)
            light_enable = 1'b1;
    end

    MANUAL:
    begin
        light_enable = 1'b1;
        fan_enable   = 1'b1;
    end

    SCHEDULE:
    begin
        light_enable = 1'b1;
        fan_enable   = 1'b1;
    end

    ALARM:
    begin
        alarm_enable = 1'b1;
    end

endcase


end

endmodule
