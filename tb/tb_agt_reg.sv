//Agent for Register Bus
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created
//2015.12.25    ZHOU Jiemin     Modified for register bus

//Source Code Starts Here------------------------------------
class tb_agt_reg extends uvm_agent;
  //register with the uvm factory
  `uvm_component_utils(tb_agt_reg)

  //child components
  //if is_active
  tb_sqr_reg sqr;
  tb_drv_reg drv;
  //passive or active
  tb_mon_reg mon;

  //variables
  //agent type
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;   //default is UVM_ACTIVE

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get config
    uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
    //build
    if(is_active == UVM_ACTIVE) begin
      sqr = tb_sqr_reg::type_id::create("sqr", this);
      drv = tb_drv_reg::tyoe_id::create("drv", this);
    end
    mon = tb_sqr_reg::type_id::create("mon", this);
    `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
  endfunction

  //connect phase
  virtual function void connect_phase(uvm_phase);
    if(is_active == UVM_ACTIVE)
      //no need to create a seq_item_port in your driver class or sequencer class, there is already one in the uvm_driver class
      drv.seq_item_port.connect(sqr.seq_item_export);
    `uvm_info(get_full_name(), "Connect stage complete.", UVM_LOW)
  endfunction

endclass
