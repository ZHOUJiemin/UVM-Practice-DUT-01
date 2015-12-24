//Data Bus Driver
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_drv_data extends uvm_driver;
  //register with the uvm factory
  `uvm_component_utils(tb_drv_data)

  //child components
  //none

  //interface
  virtual data_if data_if;

  //interface type
  if_type_enum if_type = MASTER;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase);
    super.new(phase);
    uvm_config_db#(if_type_enum)::get(this, "", "if_type", if_type);
    if(if_type == MASTER) begin
      if(!uvm_config_db#(virtual data_if)::get(this, "", "ipm", data_if))
        `uvm_fatal("NG_IF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
      `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
    end
    else begin
      if(!uvm_config_db#(virtual data_if)::get(this, "", "ips", data_if))
        `uvm_fatal("NG_IF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
      `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
    end
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
      @(negedge vif.rst_n)
        if(if_type == MASTER) begin
          vif.data_valid <= 1'b 0;
          vif.data_end <= 1'b 0;
          vif.data_ch0 <= 32'b 0;
          vif.data_ch1 <= 32'b 0;
          vif.data_nop_ch0 <= 32'b 0;
          vif.data_nop_ch1 <= 32'b 0;
          vif.data_flag_ch0 <= 6'b 0;
          vif.data_flag_ch1 <= 6'b 0;
        end
        else
          vif.data_busy <= 1'b 1;
    end
  endtask

  virtual task get_and_drive();
    data_tranx tx;
    if(vif.rst_n) begin
      seq_item_port.get_next_item(tx);    //get transaction from sequencer
      if(if_type == MASTER) begin
        send(tx);
      end
      else begin
        receive(tx);
      end
    end
  endtask

  virtual task send(data_tranx tx);
    @(posedge vif.s_clk) begin
      if(vif.data_busy)//think!!
      vif.data_valid <= 1'b 1;
      vif.data_ch0 <= tx.data_ch0;
      vif.data_ch1 <= tx.data_ch1;
      vif.data_nop_ch0 <= tx.data_nop_ch0;
      vif.data_nop_ch1 <= tx.data_nop_ch1;
      vif.data_flag_ch0 <= tx.data_flag_ch0;
      vif.data_flag_ch1 <= tx.data_flag_ch1;
    end
  endtask

  virtual task receive(data_tranx tx);

  endtask

endclass
