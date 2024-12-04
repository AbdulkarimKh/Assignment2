`timescale 1ns / 1ps

module tb_bresenham_circle;
    reg clk;
    reg reset;
    reg start;
    reg [6:0] radius;
    reg [1:0] select;
    wire [7:0] pixel_x;
    wire [6:0] pixel_y;
    wire [2:0] pixel_color;
    wire done;

    bresenham_circle uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .radius(radius),
        .select(select),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .pixel_color(pixel_color),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        start = 0;
        radius = 8;
        select = 2'd2; //1 for black and 2 for COLOR and 3 for Bresenham

        #10;
        reset = 0;

        #10;
        start = 1;
        #10;
        start = 0;

        #1000;
        $finish;
    end
endmodule