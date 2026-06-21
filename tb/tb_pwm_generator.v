`timescale 1ns/1ps

module tb_pwm_generator;

    reg clk;
    reg rst;
    reg [7:0] duty;

    wire pwm_out;

    pwm_generator DUT (
        .clk(clk),
        .rst(rst),
        .duty(duty),
        .pwm_out(pwm_out)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // VCD Dump
    initial begin
        $dumpfile("pwm_generator.vcd");
        $dumpvars(0, tb_pwm_generator);
    end

    // Test Cases
    initial begin

        rst  = 1;
        duty = 0;

        #20;
        rst = 0;

        // 25%
        duty = 8'd64;
        #3000;

        // 50%
        duty = 8'd128;
        #3000;

        // 75%
        duty = 8'd192;
        #3000;

        // 100%
        duty = 8'd255;
        #3000;

        $finish;

    end

endmodule