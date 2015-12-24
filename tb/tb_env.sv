//Environment
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_env extends uvm_env;
    //register with the uvm factory
    `uvm_component_utils(tb_env)

    //child components
    tb_agt agt_reg;
    tb_agt agt_input;
    tb_agt agt_output;
    tb_scb scb;

    //constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    //build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //configuring before building
      uvm_config_db#(int)::set(this, "agt_reg", "is_active", UVM_ACTIVE);
      uvm_config_db#(int)::set(this, "agt_input", "is_active", UVM_ACTIVE);
      uvm_config_db#(int)::set(this, "agt_output", "is_active", UVM_ACTIVE);
      uvm_config_db#(agent_type_enum)::set(this, "agt_reg", "agent_type", REGISTER_SETTING);
      uvm_config_db#(agent_type_enum)::set(this, "agt_input", "agent_type", DATA_TRANS);
      uvm_config_db#(agent_type_enum)::set(this, "agt_output", "agent_type", DATA_TRANS);
      //create child components
      agt_reg = tb_agt::type_id::create("agt_reg", this);
      agt_input = tb_agt::type_id::create("agt_input", this);
      agt_output = tb_agt::type_id::create("agt_output", this);
      scb = tb_scb::type_id::create("scb", this);
      //messaging
      `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW);
    endfunction

    //connect phase
    virtual function void connect_phase(uvm_phase phase);
      agt_reg.mon.item_collected_port.connect(scb.register_setting_collected.analysis_export);
      agt_input.mon.item_collected_port.connect(scb.input_image_data_collected.analysis_export);
      agt_output.mon.item_collected_port.connect(scb.output_image_data_collected.analysis_export);
      `uvm_info(get_full_name(), "Connect stage complete.", UVM_LOW);
    endfunction

endclass
