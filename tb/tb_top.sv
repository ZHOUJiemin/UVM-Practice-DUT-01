//Testbench Top
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.22    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
//include files
`include "reg_if.sv"
`include "data_if.sv"
`include "tb_pkg.sv"

`define CLOCKHALFCYCLE 10
`define RESETRELEASE 50

module tb_top();
  //time scale
  timeunit 1ns;
  timeprecision 1ps;

  //import packages
  import uvm_pkg::*;
  import tb_pkg::*;

  //variables
  bit s_clk;
  bit rst_n;

  //clock generator
  initial begin
    s_clk = 0;
    forever
      #`CLOCKHALFCYCLE s_clk = ~s_clk;
  end

  //interface instantiation
  //register bus
  reg_if neco(.s_clk(s_clk),
              .rst_n(rst_n));

  //input data bus
  data_if ips(.s_clk(s_clk),
              .rst_n(rst_n));

  //output data bus
  data_if ipm(.s_clk(s_clk),
              .rst_n(rst_n));

  //dut instantiation
  dut_01_top dut(//system
                 .s_clk(s_clk),
                 .rst_n(rst_n),
                 //register bus
                 .reg_addr(neco.reg_addr),
                 .reg_cs(neco.reg_cs),
                 .reg_we(neco.reg_we),
                 .reg_data_wr(neco.reg_data_wr),
                 .reg_rdack(neco.reg_rdack),
                 .reg_data_rd(neco.reg_data_rd),
                 //input data bus
                 .data_valid_in(ips.data_valid),
                 .data_end_in(ips.data_end),
                 .data_busy_out(ips.data_busy),
                 .data_ch0_in(ips.data_ch0),
                 .data_ch1_in(ips.data_ch1),
                 .data_nop_ch0_in(ips.data_nop_ch0),
                 .data_nop_ch1_in(ips.data_nop_ch1),
                 .data_flag_ch0_in(ips.data_flag_ch0),
                 .data_flag_ch1_in(ips.data_flag_ch1),
                 //output data bus
                 .data_valid_out(ipm.data_valid),
                 .data_end_out(ipm.data_end),
                 .data_busy_in(ipm.data_busy),
                 .data_ch0_out(ipm.data_ch0),
                 .data_ch1_out(ipm.data_ch1),
                 .data_nop_ch0_out(ipm.data_nop_ch0),
                 .data_nop_ch1_out(ipm.data_nop_ch1),
                 .data_flag_ch0_out(ipm.data_flag_ch0),
                 .data_flag_ch1_out(ipm.data_flag_ch1));

  //run test
  initial begin
    //initialization
    rst_n = 0;
    #`RESETRELEASE rst_n = 1;
    //config database
    //set interfaces
    uvm_config_db#(virtual reg_if)::set(uvm_root::get(), "*", "neco", neco);
    uvm_comfig_db#(virtual data_if)::set(uvm_root::get(), "*", "ips", ips);
    uvm_config_db#(virtual data_if)::set(uvm_root::get(), "*", "ipm", ipm);
    //start test
    run_test("base_test");
  end

endmodule
