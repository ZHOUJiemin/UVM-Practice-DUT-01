//Data Bus Driver Base
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_drv_data extends uvm_driver #(data_tranx);
  //register with the uvm factory
  `uvm_component_utils(tb_drv_data)

  //child components
  //none

  //interface
  virtual data_if vif;

  //interface type
  if_type_enum if_type = MASTER;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase);
    super.new(phase);
  endfunction

  //run phase
  virtual task run_phase(uvm_phase phase);
      `uvm_info("DATA BUS DRIVER", "Specify bus type (master or slave) by extending this class", UVM_LOW)
  endtask

endclass
