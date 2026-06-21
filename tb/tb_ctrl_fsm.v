`timescale 1ns/1ps

module tb_ctrl_fsm;

reg clk;
reg rst;

reg manual_mode;
reg schedule_mode;

reg motion_sensor;
reg dark_room;

reg alarm_trigger;

wire [1:0] current_state;

wire light_enable;
wire fan_enable;
wire alarm_enable;

ctrl_fsm DUT(
.clk(clk),
.rst(rst),
.manual_mode(manual_mode),
.schedule_mode(schedule_mode),
.motion_sensor(motion_sensor),
.dark_room(dark_room),
.alarm_trigger(alarm_trigger),
.current_state(current_state),
.light_enable(light_enable),
.fan_enable(fan_enable),
.alarm_enable(alarm_enable)
);

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin


$dumpfile("ctrl_fsm.vcd");
$dumpvars(0, tb_ctrl_fsm);

rst = 1;
manual_mode = 0;
schedule_mode = 0;
motion_sensor = 0;
dark_room = 0;
alarm_trigger = 0;

#20;
rst = 0;

// AUTO Mode
motion_sensor = 1;
dark_room = 1;

#20;

// MANUAL Mode
manual_mode = 1;

#20;

manual_mode = 0;

#20;

// SCHEDULE Mode
schedule_mode = 1;

#20;

schedule_mode = 0;

#20;

// ALARM Mode
alarm_trigger = 1;

#20;

alarm_trigger = 0;

#20;

$finish;


end

endmodule
