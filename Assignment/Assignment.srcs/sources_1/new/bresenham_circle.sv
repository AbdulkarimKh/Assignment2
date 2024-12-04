module bresenham_circle(
    input clk,
    input reset,
    input start,
    input [6:0] radius,
    input [1:0] select,
    output reg [7:0] pixel_x,
    output reg [6:0] pixel_y,
    output reg [2:0] pixel_color,
    output reg done
);
    localparam CENTER_X = 79;
    localparam CENTER_Y = 59;
    localparam MAX_RADIUS = 59;

    reg [7:0] x;
    reg [7:0] y;
    reg signed [7:0] d;
    reg [2:0] state;
    reg [2:0] octant_count;

    localparam IDLE   = 3'b000;
    localparam BLACK  = 3'b001;
    localparam COLOR  = 3'b010;
    localparam INIT   = 3'b011;
    localparam DRAW   = 3'b100;
    localparam FINISH = 3'b101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pixel_x <= 8'd0;
            pixel_y <= 7'd0;
            pixel_color <= 3'b000;
            done <= 0;
            x <= 8'd0;
            y <= 8'd0;
            d <= 8'sd0;
            octant_count <= 3'd0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        case (select)
                            2'd0: begin
                                state <= BLACK;
                                pixel_x <= 8'd0;
                                pixel_y <= 7'd0;
                            end
                            2'd1: state <= COLOR;
                            2'd2: state <= INIT;
                        endcase
                    end
                end

                BLACK: begin
                    pixel_color <= 3'b000;
                    if (pixel_x < 8'd159) begin
                        pixel_x <= pixel_x + 1;
                    end else begin
                        pixel_x <= 8'd0;
                        if (pixel_y < 7'd119) begin
                            pixel_y <= pixel_y + 1;
                        end else begin
                            state <= FINISH;
                        end
                    end
                end
                
                COLOR: begin
                    pixel_x <= pixel_x + 1;
                    pixel_color <= pixel_x[2:0];
                    if (pixel_x == 8'd159) begin
                        pixel_x <= 8'd0;
                        if (pixel_y < 7'd119) begin
                            pixel_y <= pixel_y + 1;
                        end else begin
                            state <= FINISH;
                        end
                    end
                end
                
                INIT: begin
                    if (radius > MAX_RADIUS) begin
                        y <= MAX_RADIUS;
                    end else begin
                        y <= radius;
                    end
                    x <= 8'd0;
                    d <= 3 - 2 * y;
                    octant_count <= 3'd0;
                    state <= DRAW; 
                end
                
                DRAW: begin
                    if (x <= y) begin
                        case (octant_count)
                            3'd0: begin
                                pixel_x <= CENTER_X + x;
                                pixel_y <= CENTER_Y + y;
                            end
                            3'd1: begin
                                pixel_x <= CENTER_X - x;
                                pixel_y <= CENTER_Y + y;
                            end
                            3'd2: begin
                                pixel_x <= CENTER_X + x;
                                pixel_y <= CENTER_Y - y;
                            end
                            3'd3: begin
                                pixel_x <= CENTER_X - x;
                                pixel_y <= CENTER_Y - y;
                            end
                            3'd4: begin
                                pixel_x <= CENTER_X + y;
                                pixel_y <= CENTER_Y + x;
                            end
                            3'd5: begin
                                pixel_x <= CENTER_X - y;
                                pixel_y <= CENTER_Y + x;
                            end
                            3'd6: begin
                                pixel_x <= CENTER_X + y;
                                pixel_y <= CENTER_Y - x;
                            end
                            3'd7: begin
                                pixel_x <= CENTER_X - y;
                                pixel_y <= CENTER_Y - x;
                            end
                        endcase

                        if (select == 2'd0) begin
                            pixel_color <= 3'b000;
                        end else if (select == 2'd1) begin
                            pixel_color <= pixel_x[2:0];
                        end else begin
                            pixel_color <= 3'b111;
                        end

                        if (octant_count < 3'd7) begin
                            octant_count <= octant_count + 1;
                        end else begin
                            octant_count <= 3'd0;
                            if (d < 0) begin
                                d <= d + (4 * x) + 6;
                            end else begin
                                d <= d + (4 * (x - y)) + 10;
                                y <= y - 1;
                            end
                            x <= x + 1;
                        end
                    end else begin
                        state <= FINISH; 
                    end
                end

                FINISH: begin
                    done <= 1; 
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule