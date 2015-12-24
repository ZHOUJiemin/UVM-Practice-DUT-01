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

    //type define agent_type_enum
    //choose from register setting and data transferring
    typedef enum {REGISTER_SETTING, DATA_TRANS} agent_type_enum;
    typedef enum {MASTER, SLAVE} if_type_enum;
    //test sequence
    `include "tb_seq.sv"

    //testbench heirarchy
    `include "tb_sqr_data.sv"
    `include "tb_sqr_reg.sv"
    `include "tb_drv_data.sv"
    `include "tb_drv_reg.sv"
    `include "tb_mon_data.sv"
    `include "tb_mon_reg.sv"
    `include "tb_env.sv"

    //test
    `include "base_test.sv"

endpackage

`endif
