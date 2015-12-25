//Data Bus Driver Master
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_drv_data_m extends tb_drv_data;
  //register with the uvm factory
  `uvm_component_utils(tb_drv_data_m)

  //child components
  //none

  //interface
  virtual data_if.m_mp vif;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase);
    super.new(phase);
    //build master interface
    if(!uvm_config_db#(virtual data_if.m_mp)::get(this, "", "ips", vif))
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
        vif.data_valid <= 1'b 0;
        vif.data_end <= 1'b 0;
        vif.data_ch0 <= 32'b 0;
        vif.data_ch1 <= 32'b 0;
        vif.data_nop_ch0 <= 32'b 0;
        vif.data_nop_ch1 <= 32'b 0;
        vif.data_flag_ch0 <= 6'b 0;
        vif.data_flag_ch1 <= 6'b 0;
      end
    end
  endtask

  virtual task get_and_drive();
    data_tranx tx;
    forever begin
      if(vif.rst_n) begin
        seq_item_port.get_next_item(tx);    //get transaction from sequencer
        send(tx);
        seq_item_port.item_done();          //notify the completion of the item
      end
    end
  endtask

  virtual task send(data_tranx tx);
    @(posedge vif.s_clk) begin
      vif.data_valid <= 1'b 1;
      vif.data_end <= 1'b 0;
      vif.data_ch0 <= tx.data_ch0;
      vif.data_ch1 <= tx.data_ch1;
      vif.data_nop_ch0 <= tx.data_nop_ch0;
      vif.data_nop_ch1 <= tx.data_nop_ch1;
      vif.data_flag_ch0 <= tx.data_flag_ch0;
      vif.data_flag_ch1 <= tx.data_flag_ch1;
      //if busy, keep waiting
      while (vif.data_busy)
        @(posedge vif.s_clk);
    end
  endtask

endclass
