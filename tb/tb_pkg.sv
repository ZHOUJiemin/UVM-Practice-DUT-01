//Testbench Package
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
`ifndef TB_PKG
`define TB_PKG

`include "uvm_macros.svh"

package tb_pkg;
    //import uvm package
    import uvm_pkg::*;

    //type define master_or_slave_enum
    //choose from data master and data slave
    typedef enum {D_MASTER, D_SLAVE} master_or_slave_enum;

    //type define register transaction type
    typedef enum {REG_WRITE, REG_READ} reg_write_or_read_enum;
    //test sequence
    `include "tb_seq.sv"

    //transactions
    `include "tb_reg_tranx.sv"
    `include "tb_data_tranx.sv"
    //testbench components
    //uvm_sequencer
    `include "tb_sqr_data.sv"
    `include "tb_sqr_reg.sv"
    //uvm_driver
    `include "tb_drv_data.sv"
    `include "tb_drv_data_m.sv"
    `include "tb_drv_data_s.sv"
    `include "tb_drv_reg.sv"
    //uvm_monitor
    `include "tb_mon_data.sv"
    `include "tb_mon_data_m.sv"
    `include "tb_mon_data_s.sv"
    `include "tb_mon_reg.sv"
    //uvm_agent
    `include "tb_agt_data.sv"
    `include "tb_agt_reg.sv"
    //uvm_environment
    `include "tb_env.sv"

    //test
    `include "base_test.sv"

endpackage

`endif
