//Agent for Data Bus
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created
//2015.12.25    ZHOU Jiemin     Modified for data bus

//Source Code Starts Here------------------------------------
class tb_agt_data extends uvm_agent;
  //register with the uvm factory
  `uvm_component_utils(tb_agt_data)

  //child components
  //if is_active
  tb_sqr_data sqr;    //base class of data bus sequencer
  tb_drv_data drv;    //base class of data bus driver
  //passive or active
  tb_mon_data mon;    //base class of data bus monitor

  //variables
  //agent type
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;   //default is UVM_ACTIVE
  protected master_or_slave_enum agent_type = D_SLAVE //default is D_SLAVE

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get config
    uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
    uvm_config_db#(master_or_slave_enum)::get(this, "", "agent_type", agent_type);
    //build
    if(is_active == UVM_ACTIVE) begin
      if(agent_type == D_MASTER) begin
        sqr = tb_sqr_data::type_id::create("sqr", this);  //create data bus master sequencer
        drv = tb_drv_data_m::tyoe_id::create("drv", this);  //create data bus master driver
      end
      else begin
        sqr = tb_sqr_data::type_id::create("sqr", this);  //create data bus slave sequencer
        drv = tb_drv_data_s::type_id::create("drv", this);  //create data bus slave driver
      end
    end
    if(agent_type == D_MASTER)
      mon = tb_mon_data_m::type_id::create("mon", this);
    else
      mon = tb_sqr_data_s::type_id::create("mon", this);
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
