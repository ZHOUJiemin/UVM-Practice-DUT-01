//Data Bus Sequencer
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_sqr_data extends uvm_sequencer #(data_tranx);
  //first thing to do: register with the uvm factory
  `uvm_component_utils(tb_sqr_data)

  //sequencer may be the easiest, the simpliest class in uvm
  //no changes need to be made
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
