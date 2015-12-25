//Data Bus Monitor Slave
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.25    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class tb_mon_data_s extends tb_mon_data;
    //register with the uvm factory
    `uvm_component_utils(tb_mon_data_s)

    //interface
    virtual data_if.s_mp vif;

    //constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    //build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual data_if.s_mp)::get(this, "", "ipm", vif))
        `uvm_fatal("NG_IF",{"virtual interface must be set for: ", get_full_name(), ".vif"});
      `uvm_info(get_full_name, "Build stage completed", UVM_LOW)
    endfunction

    //run phase
    virtual task run_phase(uvm_phase phase);
      fork
        collect_data();
      join
    endtask

    //report phase
    virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);
    endfunction

    virtual task collect_data();
      forever begin
        @(posedge vif.s_clk) begin
          //if a valid data is received
          if(vif.valid && (~vif.busy)) begin
            collected_tx.data_ch0 = vif.data_ch0;
            collected_tx.data_ch1 = vif.data_ch1;
            collected_tx.data_nop_ch0 = vif.data_nop_ch0;
            collected_tx.data_nop_ch1 = vif.data_nop_ch1;
            collected_tx.data_flag_ch0 = vif.data_flag_ch0;
            collected_tx.data_flag_ch1 = vif.data_flag_ch1;
            $cast(cloned_tx, collected_tx.clone());
            item_collected_port.write(cloned_tx);
            collected_data_num ++;
          end
        end
      end
    endtask

endclass
