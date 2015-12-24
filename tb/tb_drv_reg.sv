//Register Bus Driver
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_drv_reg extends uvm_driver #(reg_tranx);   //parameterised to get register setting transaction
  //register with the uvm factory
  `uvm_component_utils(tb_drv_reg)

  //child components
  //none

  //interface
  virtual reg_if vif;

  //mailbox

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual reg_if)::get(this, "", "neco", vif))
      `uvm_fatal("NG_IF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      reset();
      get_and_drive();
    join
  endtask

  virtual task reset();
    forever begin
      //block until rst_n is activated
      @(negedge vif.rst_n)
        `uvm_info(get_type_name(), "Resetting signals.", UVM_LOW)
      vif.reg_addr <= 32'b 0;
      vif.reg_cs <= 1'b 0;
      vif.reg_we <= 1'b 0;
      vif.reg_data_wr <= 32'b 0;
    end
  endtask

  virtual task get_and_drive();
    reg_tranx tx;
    forever begin
      //do if rst_n is released
      if(rst_n) begin
        seq_item_port.get_next_item(tx);    //get transaction from sequencer
        if(tx.trans_type == WRITE)          //if tx is a write transaction
          write_reg(tx);                    //drive transaction on pin level
        else                                //if tx is a read transaction
          read_reg(tx);                       //drive transaction on pin level
        seq_item_port.item_done();          //notify the completion of the item
      end
    end
  endtask

  virtual task write_reg(reg_tranx tx);
    @(posedge vif.s_clk) begin
      vif.reg_cs <= 1'b 1;
      vif.reg_we <= 1'b 1;
      vif.reg_addr <= tx.reg_addr;
      vif.reg_data_wr <= tx.reg_data_wr;
      `uvm_info(get_type_name(), $sformatf("@ %0t, WRITE REGISTER: %0h @ %0h", $time, vif.reg_data_wr, vif.reg_addr), UVM_LOW)
    end
  endtask

  virtual task read_reg(reg_tranx tx);
    @(posedge vif.s_clk) begin
      vif.reg_cs <= 1'b 1;
      vif.reg_we <= 1'b 0;
      vif.reg_addr <= tx.reg_addr;
      vif.reg_data_wr <= 32'b 0;
    end
    @(posedge vif.s_clk) begin
      if(vif.reg_rdack) begin
        tx.reg_data_rd <= vif.reg_data_rd;
        seq_item_port.put(tx);
      end
    end
  endtask

endclass
