//Register Setting Transaction
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class reg_tranx extends uvm_sequence_item;
    //register with the uvm factory
    `uvm_object_utils(reg_tranx)

    //contents
    reg_write_or_read_enum tranx_type = REG_WRITE;
    rand int tranx_num;
    rand bit [31:0] address;
    rand bit [31:0] data;

    //constraints
    constraint c_reg_addr{ address >= 0;
                           address <= 9;}

    constraint c_reg_tranx_num{ tranx_num > 0;
                                tranx_num < 10;}

    //constructor
    function new(string name = "reg_tranx");
      super.new(name);
    endfunction

    //other methods
    //ususally a display function is required (for debug?)
    virtual task display_it();
      //write transaction
      if (tranx_type == REG_WRITE)
        `uvm_info("TRANX", $sformatf("WR_REG","Write Register = 0x%0h @ Address = 0x%0h\n", data, address) ,UVM_LOW)
      else if(tranx_type == REG_READ)
        //display("Read Transaction\nDelay = %0d Cycles\n", delay);
        //use uvm macros!
        `uvm_info("TRANX", $sformatf("RD_REG","Read Register @ Address = %0d \n", address), UVM_LOW)
      else
        //this is not supposed to happen
        `uvm_error("NG_TRANX", "Wrong Type of Transaction!\n")
    endtask

endclass
