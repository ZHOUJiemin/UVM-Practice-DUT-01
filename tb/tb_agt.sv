//Agent
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_agt extends uvm_agent;
  //register with the uvm factory
  `uvm_component_utils(tb_agt)

  //child components
  //if is_active
  tb_sqr sqr;
  tb_drv drv;
  //passive or active
  tb_mon mon;

  //variables
  //agent type
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;   //default is UVM_ACTIVE
  protected agent_type_enum agent_type = DATA_TRANS;          //default is DATA_TRANS

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get config
    uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
    uvm_config_db#(agent_type_enum)::get(this, "", "agent_type", agent_type);
    if(is_active == UVM_ACTIVE) begin
      //create the specified type of driver and sequencer
      if(agent_type == REGISTER_SETTING) begin
        sqr = tb_sqr_reg::type_id::create("sqr", this);
        drv = tb_drv_reg::type_id::create("drv", this);
      end
      else begin
        sqr = tb_sqr_data::type_id::create("sqr", this);
        drv = tb_drv_data::tyoe_id::create("drv", this);
      end
    end
    //create the specified type of monitor
    if(agent_type == REGISTER_SETTING)
      mon = tb_mon_reg::type_id::create("mon", this);
    else
      mon = tb_mon_data::type_id::create("mon", this);
    `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
  endfunction

  //connect phase
  virtual function void connect_phase(uvm_phase);

  endfunction

endclass
