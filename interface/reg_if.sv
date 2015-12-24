//Register Bus Interface
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
interface reg_if(input bit s_clk,
                 input bit rst_n);
   logic [31:0] reg_addr;
   logic reg_cs;
   logic reg_we;
   logic [31:0] reg_data_wr;
   logic reg_rdack;
   logic [31:0] reg_data_rd;

   //modport for the testbench
   modport tb_mp(output reg_addr,
                 output reg_cs,
                 output reg_we,
                 output reg_data_wr,
                 input reg_rdack,
                 input reg_data_rd);

    //modport for the DUT
    //none

endinterface
