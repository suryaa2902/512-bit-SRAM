`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2024 06:33:39 PM
// Design Name: 
// Module Name: sram_512
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sram_512(
    input clk, reset, enable,rw,
    input [5:0] address,
    input [7:0] data_in,
    output reg [7:0] data_out
    );
    //Define SRAM array with 16 rows and 32 coloumns
    reg [31:0] sram_array[15:0];
    //Address split
    wire [3:0] row_address = address[5:2]; //Row decoder - 4:1 decoder
    wire [1:0] column_address = address[1:0]; //Column decoder - 2:1 decoder
    //Read and Write operations with MUX design
    integer i;
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            data_out <= 0;
        end
        else if(enable)
        begin
            if(rw) //Read operation
            begin
                for(i = 0; i < 8; i = i+1)
                begin
                    data_out[i] <= sram_array[row_address][(i*4)+column_address];
                end
            end 
            else //Write operation
            begin
                for(i = 0; i < 8; i = i+1)
                begin
                    sram_array[row_address][(i*4)+column_address] <= data_in[i];
                end 
            end  
        end 
    end                 
endmodule

/////////////////////////////////////////////////////////////////////////////////////

module sram_512_tb();
    
    //Inputs and output
    reg clk;
    reg reset;
    reg enable; 
    reg rw;
    reg [5:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    //Unit Under Test
    sram_512 uut(
        .clk(clk), .reset(reset), .enable(enable), .rw(rw),
        .address(address), .data_in(data_in),
        .data_out(data_out)
    );
    
    //Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    //Test sequence
    initial begin
        reset = 1; enable = 0; rw = 0; address = 0; data_in = 0;
        
        #100; //Waiting for Global Reset to finish
        
        reset = 0; //Release reset
        enable = 1; //Enable the chip
        
        //Write operation
        rw = 0;
        address = 6'b000000;
        data_in = 8'hAA;
        #10;
        address = 6'b000001;
        data_in = 8'h55;
        #10;
        
        //Read operation
        rw = 1;
        address = 6'b000000;
        #10;
        
        //Check output
        if(data_out != 8'hAA)
        begin
            $display("Test failed at address %b: expected %h, got %h", address, 8'hAA, data_out);
        end else 
        begin
            $display("Test passed at address %b", address);
        end 
        
        rw = 1;
        address = 6'b000001;
        #10;
        
        //Check output
        if(data_out != 8'h55)
        begin
            $display("Test failed at address %b: expected %h, got %h", address, 8'h55, data_out);
        end else 
        begin
            $display("Test passed at address %b", address);
        end   
        
        $finish;    
    end
endmodule