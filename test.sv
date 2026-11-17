class apb_test extends uvm_test;
    `uvm_component_utils(apb_test)
        apb_env  env;
        apb_read_seq rseq;
        apb_write_seq wseq;
        
        function new(string name ="",uvm_component parent);
            super.new(name,parent);
        endfunction

         function void build_phase(uvm_phase phase);
            env=apb_env::type_id::create("env",this);
            rseq=apb_read_seq::type_id::create("rseq");
            wseq=apb_write_seq::type_id::create("wseq");
         endfunction

        function void end_of_elaboration_phase(uvm_phase phase);
            uvm_top.print_topology();
        endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            rseq.start(env.ag1.sqr);
            wseq.start(env.ag1.sqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this,500);
     endtask


endclass
