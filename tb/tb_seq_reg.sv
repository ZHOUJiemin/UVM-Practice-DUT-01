//Register Setting Sequence
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_seq_reg extends uvm_sequence #(reg_tranx);
  //first thing to do: register with the uvm factory
  `uvm_object_utils(tb_sqr_reg)

  //variables
  //none

  //constructor
  function new(string name = "tb_seq_reg");
    super.new(name);
  endfunction

  //this is the part when transactions are generated
  virtual task body();
    //`uvm_do_with{inline constraints}
    //`uvm_do(req)
    //the above macros may be used, but is recommended not to use them?
    reg_tranx tx;
    tx = reg_tranx::type_id::create("tx");
    //to write a few registers
    start_item(tx);
    assert(tx.randomize());
    tx.tranx_type = REG_WRITE;
    finish_item(tx);
    //and to read the same registers
    start_item(tx);
    tx.tranx_type = REG_READ;
    finish_item(tx);
  endtask

endclass
