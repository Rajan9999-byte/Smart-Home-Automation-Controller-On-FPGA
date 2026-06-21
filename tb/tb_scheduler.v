`timescale 1ns/1ps

module tb_scheduler;

    reg clk;
    reg rst;
    reg tick_1min;

    reg [5:0] current_hour;
    reg [5:0] current_minute;

    wire [1:0] scene_id;
    wire scene_update;

    scheduler DUT(
        .clk(clk),
        .rst(rst),
        .tick_1min(tick_1min),
        .current_hour(current_hour),
        .current_minute(current_minute),
        .scene_id(scene_id),
        .scene_update(scene_update)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $dumpfile("scheduler.vcd");
        $dumpvars(0, tb_scheduler);

        rst = 1;
        tick_1min = 0;
        current_hour = 0;
        current_minute = 0;

        #20;
        rst = 0;

        // HOME
        current_hour = 6;
        current_minute = 0;
        tick_1min = 1;
        #10;
        tick_1min = 0;

        #20;

        // VACATION
        current_hour = 8;
        current_minute = 0;
        tick_1min = 1;
        #10;
        tick_1min = 0;

        #20;

        // NIGHT
        current_hour = 18;
        current_minute = 0;
        tick_1min = 1;
        #10;
        tick_1min = 0;

        #20;

        // AWAY
        current_hour = 23;
        current_minute = 0;
        tick_1min = 1;
        #10;
        tick_1min = 0;

        #20;

        $finish;

    end

endmodule