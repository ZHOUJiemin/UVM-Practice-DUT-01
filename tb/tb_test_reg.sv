//Base Test
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.24    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
class base_test extends uvm_test;
    //register with the uvm factory
    `uvm_component_utils(base_test)

    //child components
    tb_env env;   //environment

    //heirarchy printer
    uvm_table_printer printer;

    //constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    //build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = tb_env::type_id::create("env", this);
      //printer should also be built by using a new function
      printer = new();
      printer.knobs.depth = -1; //print everything
    endfunction

    virtual task run_phase(uvm_phase phase);
      phase.phase_done.set_drain_time(this, 1500);
      tb_seq_reg seq_set_reg;
      phase.raise_objection(this);
      seq_set_reg = tb_seq_reg::type_id::create("seq_set_reg");
      seq_set_reg.start(env.agt_reg.sqr);
      phase.drop_objection(this);
    endtask

    //end of elaboration phase
    virtual function void end_of_elaboration_phase(uvm_phase phase);
      //sprint is just like print, except it returns the string rather than displays it
      `uvm_info(get_type_name(), $sformatf("Printing the test topology :\n%s", this.sprint(printer)),UVM_LOW)
    endfunction

endclass
