//Data Bus Interface
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
interface data_if(input s_clk,
                  input rst_n);
    logic data_valid;
    logic data_end;
    logic data_busy;
    logic [31:0] data_ch0;
    logic [31:0] data_ch1;
    logic [31:0] data_nop_ch0;
    logic [31:0] data_nop_ch1;
    logic [5:0] data_flag_ch0;
    logic [5:0] data_flag_ch1;

    //modport for slave
    modport s_mp(input data_valid,
                 input data_end,
                 output data_busy,
                 input data_ch0,
                 input data_ch1,
                 input data_nop_ch0,
                 input data_nop_ch1,
                 input data_flag_ch0,
                 input data_flag_ch1);

    //modport for master
    modport m_mp(output data_valid,
                 output data_end,
                 input data_busy,
                 output data_ch0,
                 output data_ch1,
                 output data_nop_ch0,
                 output data_nop_ch1,
                 output data_flag_ch0,
                 output data_flag_ch1);

endinterface
