module smart_home_controller(

    input motion_sensor,
    input dark_room,
    input temp_high,
    input door_open,
    input security_mode,

    output light_ctrl,
    output fan_ctrl,
    output alarm_ctrl

);

assign light_ctrl =
       motion_sensor & dark_room;

assign fan_ctrl =
       temp_high;

assign alarm_ctrl =
       security_mode & door_open;

endmodule