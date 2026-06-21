`timescale 1ns/1ps

module tb_scene_rom;

    reg  [1:0] scene_id;
    wire [17:0] scene_data;

    scene_rom DUT (
        .scene_id(scene_id),
        .scene_data(scene_data)
    );

    initial begin

        $dumpfile("scene_rom.vcd");
        $dumpvars(0, tb_scene_rom);

        $display("===== Scene ROM Test =====");

        scene_id = 2'd0;
        #20;
        $display("HOME     : %b", scene_data);

        scene_id = 2'd1;
        #20;
        $display("AWAY     : %b", scene_data);

        scene_id = 2'd2;
        #20;
        $display("NIGHT    : %b", scene_data);

        scene_id = 2'd3;
        #20;
        $display("VACATION : %b", scene_data);

        $finish;

    end

endmodule