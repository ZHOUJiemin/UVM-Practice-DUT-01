//Register Bus Monitor
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_mon_reg extends uvm_monitor #(reg_tranx);
    //register with the uvm factory
    `uvm_component_utils(tb_mon_reg)

    //child components
    //analysis port
    uvm_analysis_port #(reg_tranx) item_collected_port;

    //interface
    virtual reg_if vif;

    //collected transaction and cloned transaction
    reg_tranx collected_tx;
    reg_tranx cloned_tx;
    int collected_data_num = 0;

    //constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    //build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual reg_if)::get(this, "", "neco", vif))
        `uvm_fatal("NG_IF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
      //use new(name, parent) function to build a port
      item_collected_port = new("item_collected_port", this);
      //build transactions
      collected_tx = reg_tranx::type_id::create("collected_tx");
      cloned_tx = reg_tranx::type_id::create("cloned_tx");
      `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
    endfunction

    //run phase
    virtual task run_phase(uvm_phase phase);
      fork
        collect_data();
      join
    endtask

    //report phase
    virtual function void report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Report: Total Collected Data = %0d", collected_data_num), UVM_LOW)
    endfunction

    virtual task collect_data();
      forever begin
        @(posedge vif.s_clk) begin
          //if cs signal is asserted
          if(vif.reg_cs) begin
            //if we signal is asserted: write
            if(vif.reg_we) begin
              collected_tx.tranx_type = WRITE;
              collected_tx.address = vif.reg_addr;
              collected_tx.data = vif.reg_data_wr;
              $cast(cloned_tx, collected_tx.clone());
              item_collected_port.write(cloned_tx);
              collected_data_num ++;
            end
            //if we signal is de-asserted: read
            else begin
              collected_tx.tranx_type = READ;
              collected_tx.address = vif.reg_addr;
              @(posedge vif.reg_rdack)
                collected_tx.data = vif.reg_data_rd;
              $cast(cloned_tx, collected_tx.clone());
              item_collected_port.write(cloned_tx);
              collected_data_num ++;
            end
          end
        end
      end
    endtask

endclass
