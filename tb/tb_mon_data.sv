//Data Bus Monitor Base
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_mon_data extends uvm_monitor #(data_tranx);
    //register with the uvm factory
    `uvm_component_utils(tb_mon_data)

    //child components
    //analysis port
    uvm_analysis_port #(data_tranx) item_collected_port;

    //interface
    virtual data_if vif;

    //collected transaction and cloned transaction
    data_tranx collected_tx;
    data_tranx cloned_tx;
    int collected_data_num = 0;

    //constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    //build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //use new(name, parent) function to build a port
      item_collected_port = new("item_collected_port", this);
      //build transactions
      collected_tx = data_tranx::type_id::create("collected_tx");
      cloned_tx = data_tranx::type_id::create("cloned_tx");
      `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
    endfunction

    //run phase
    virtual task run_phase(uvm_phase phase);
      `uvm_info("DATA BUS MONITOR", "Specify bus type (master or slave) by extending this class", UVM_LOW)
    endtask

    //report phase
    virtual function void report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Report: Total Collected Data = %0d", collected_data_num), UVM_LOW)
    endfunction

endclass
