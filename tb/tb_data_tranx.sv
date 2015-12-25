//Data Transaction
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class data_tranx extends uvm_sequence_item;
    //register with the uvm factory
    `uvm_object_utils(data_tranx)

    //contents
    rand bit [31:0] data_ch0;
    rand bit [31:0] data_ch1;
    rand bit [31:0] data_nop_ch0;
    rand bit [31:0] data_nop_ch1;
    rand bit [6:0] data_flag_ch0;
    rand bit [6:0] data_flag_ch1;

    rand int tranx_num;

    //constraints
    constraint c_data_tranx_num{ tranx_num > 0;
                                 tranx_num <= 50;}

    //constructor
    function new(string name = "data_tranx");
      super.new(name);
    endfunction

    //other methods
    //ususally a display function is required (for debug?)
    virtual task display_it();
      `uvm_info("TRANX", $sformatf("DATA","Data_CH0 = 0x%0h, Data_CH1 = 0x%0h\n
                Data_NOP_CH0 = 0x%0h, Data_NOP_CH1 = 0x%0h\n
                Data_Flag_CH0 = 0x%0h, Data_Flag_CH1 = 0x%0h\n", data_ch0, data_ch1, data_nop_ch0, data_nop_ch1, data_flag_ch0, data_flag_ch1) ,UVM_LOW)
    endtask

endclass
