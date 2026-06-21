initial begin
    $dumpfile("smart_home_controller.vcd");
    $dumpvars(0, tb_smart_home_controller);
end


`timescale 1ns/1ps

module tb_smart_home_controller;

    // Inputs
    reg motion_sensor;
    reg dark_room;
    reg temp_high;
    reg door_open;
    reg security_mode;

    // Manual buttons (future FSM expansion)
    reg btn_light;
    reg btn_fan;

    // Outputs
    wire light_ctrl;
    wire fan_ctrl;
    wire alarm_ctrl;

    //--------------------------------------------------
    // DUT
    //--------------------------------------------------

    smart_home_controller DUT (

        .motion_sensor(motion_sensor),
        .dark_room(dark_room),
        .temp_high(temp_high),
        .door_open(door_open),
        .security_mode(security_mode),

        .light_ctrl(light_ctrl),
        .fan_ctrl(fan_ctrl),
        .alarm_ctrl(alarm_ctrl)

    );

    //--------------------------------------------------
    // VCD Dump
    //--------------------------------------------------

    initial begin
        $dumpfile("smart_home_controller.vcd");
        $dumpvars(0, tb_smart_home_controller);
    end

    //--------------------------------------------------
    // Test Sequence
    //--------------------------------------------------

    initial begin

        $display("\n===== SMART HOME TEST START =====");

        // Initialize

        motion_sensor = 0;
        dark_room     = 0;
        temp_high     = 0;
        door_open     = 0;
        security_mode = 0;

        btn_light     = 0;
        btn_fan       = 0;

        #10;

        //--------------------------------------------------
        // Test 1
        //--------------------------------------------------

        $display("\nTEST1 : Motion + Dark");

        motion_sensor = 1;
        dark_room     = 1;

        #10;

        $display("light=%b fan=%b alarm=%b",
                  light_ctrl,
                  fan_ctrl,
                  alarm_ctrl);

        if(light_ctrl !== 1)
        begin
            $display("ERROR: Light should turn ON");
            $stop;
        end

        //--------------------------------------------------
        // Test 2
        //--------------------------------------------------

        $display("\nTEST2 : High Temperature");

        motion_sensor = 0;
        dark_room     = 0;
        temp_high     = 1;

        #10;

        $display("light=%b fan=%b alarm=%b",
                  light_ctrl,
                  fan_ctrl,
                  alarm_ctrl);

        if(fan_ctrl !== 1)
        begin
            $display("ERROR: Fan should turn ON");
            $stop;
        end

        //--------------------------------------------------
        // Test 3
        //--------------------------------------------------

        $display("\nTEST3 : Security Alarm");

        temp_high     = 0;
        security_mode = 1;
        door_open     = 1;

        #10;

        $display("light=%b fan=%b alarm=%b",
                  light_ctrl,
                  fan_ctrl,
                  alarm_ctrl);

        if(alarm_ctrl !== 1)
        begin
            $display("ERROR: Alarm should turn ON");
            $stop;
        end

        //--------------------------------------------------
        // Test 4
        //--------------------------------------------------

        $display("\nTEST4 : Manual Button Toggle");

        btn_light = 1;

        #5;

        btn_light = 0;

        #10;

        $display("Manual button event generated");

        //--------------------------------------------------
        // Safety Property
        //--------------------------------------------------

        $display("\nTEST5 : Safety Check");

        if(alarm_ctrl && fan_ctrl)
        begin
            $display("SAFETY VIOLATION");
            $stop;
        end

        $display("\n===== ALL TESTS PASSED =====");

        #20;

        $finish;

    end

endmodule