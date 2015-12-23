//Design Top (Dummy Top)
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.23    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
`include "dut_reg.sv"

module dut_01_top(  //system
                    input s_clk,
                    input rst_n,
                    //register bus
                    input [31:0] reg_addr,
                    input reg_cs,
                    input reg_we,
                    input [31:0] reg_data_wr,
                    output reg_rdack,
                    output [31:0] reg_data_rd,
                    //input data bus
                    input data_valid_in,
                    input data_end_in,
                    output data_busy_out,
                    input [31:0] data_ch0_in,
                    input [31:0] data_ch1_in,
                    input [31:0] data_nop_ch0_in,
                    input [31:0] data_nop_ch1_in,
                    input [5:0] data_flag_ch0_in,
                    input [5:0] data_flag_ch1_in,
                    //output data bus
                    output data_valid_out,
                    output data_end_out,
                    input data_busy_in,
                    output [31:0] data_ch0_out,
                    output [31:0] data_ch1_out,
                    output [31:0] data_nop_ch0_out,
                    output [31:0] data_nop_ch1_out,
                    output [5:0] data_flag_ch0_out,
                    output [5:0] data_flag_ch1_out);
    //reg declaration
    //output ports
    reg reg_rdack;
    reg [31:0] reg_data_rd;
    /*
    reg data_busy_out;
    reg data_valid_out;
    reg data_end_out;
    reg [31:0] data_ch0_out;
    reg [31:0] data_ch1_out;
    reg [31:0] data_nop_ch0_out;
    reg [31:0] data_nop_ch1_out;
    reg [5:0] data_flag_ch0_out;
    reg [5:0] data_flag_ch1_out;
    */
    //variables
    //none

    //This is the dummy top module which acts only in the "through mode"
    //continuous assignment
    //through mode
    assign data_busy_out = rst_n ? data_busy_in : 1;
    assign data_valid_out = rst_n ? data_valid_in : 0;
    assign data_end_out = rst_n ? data_end_in : 0;
    assign data_ch0_out = rst_n ? data_ch0_in : 0;
    assign data_ch1_out = rst_n ? data_ch1_in : 0;
    assign data_nop_ch0_out = rst_n ? data_nop_ch0_in : 0;
    assign data_nop_ch1_out = rst_n ? data_nop_ch1_in : 0;
    assign data_flag_ch0_out = rst_n ? data_flag_ch0_in : 0;
    assign data_flag_ch1_out = rst_n ? data_flag_ch1_in : 0;

    //process assignment
    //none

    //instantiation
    //dut_reg
    dut_reg dut_01_reg( .s_clk(s_clk),
                        .rst_n(rst_n),
                        .reg_addr(reg_addr),
                        .reg_cs(reg_cs),
                        .reg_we(reg_we),
                        .reg_data_wr(reg_data_wr),
                        .reg_rdack(reg_rdack),
                        .reg_data_rd(reg_data_rd) );

endmodule
