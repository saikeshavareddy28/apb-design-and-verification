class apb_write_test extends apb_test;
    `uvm_component_utils(apb_write_test)
        apb_write_seq seq
    function new(string name="",uvm_component parent);
        super.new(name,parent);
    endfunction

     function void build_phase(uvm_phase phase);
       seq=apb_write_seq::type_id::create("seq");
    endfunction

     task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            seq.start(env.ag1.sqr);
        phase.drop_objection(this);
     endtask

endclass
