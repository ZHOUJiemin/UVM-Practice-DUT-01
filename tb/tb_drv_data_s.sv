//Data Bus Driver Slave
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_drv_data_s extends tb_drv_data;
  //register with the uvm factory
  `uvm_component_utils(tb_drv_data_s)

  //child components
  //none

  //interface
  virtual data_if.s_mp vif;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase);
    super.new(phase);
    //build master interface
    if(!uvm_config_db#(virtual data_if.m_mp)::get(this, "", "ipm", vif))
      `uvm_fatal("NG_IF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    `uvm_info(get_full_name, "Build stage complete.", UVM_LOW)
  endfunction

  //run phase
  virtual task run_phase(uvm_phase phase);
    fork
      reset();
      get_and_drive();
    join
  endtask

  virtual task reset();
    forever begin
      @(negedge vif.rst_n) begin
        vif.data_busy <= 1'b 1;
      end
    end
  endtask

  virtual task get_and_drive();
    data_tranx tx;
    forever begin
      if(vif.rst_n) begin
        seq_item_port.get_next_item(tx);    //get transaction from sequencer
        receive(tx);
        seq_item_port.item_done();          //notify the completion of the item
      end
    end
  endtask

  virtual task receive(data_tranx tx);
    vif.data_busy <= 1'b 0;
    while(!vif.data_valid)
      @(posedge vif.s_clk);
    vif.data_busy <= 1'b 1;
  endtask

endclass
