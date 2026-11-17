class apb_sb extends uvm_scoreboard; 
    `uvm_component_utils(apb_sb)
     apb_seq_item refa,act;

     uvm_tlm_analysis_fifo#(apb_seq_item) ip_fifo;
     uvm_tlm_analysis_fifo#(apb_seq_item) op_fifo;

        function new (string name ="",uvm_component parent);
            super.new(name,parent);
            ip_fifo=new("ip_fifo",this);
            op_fifo=new("op_fifo",this);
        endfunction

        function void build_phase (uvm_phase phase);
            refa=apb_seq_item::type_id::create("refa");
            act=apb_seq_item::type_id::create("act");
        endfunction

       task run_phase(uvm_phase phase);
        forever begin
            fork
                ip_fifo.get(refa);
                op_fifo.get(act);
            join
                refa.compare(act);
                  if(act.apb_read_data == refa.apb_read_data)
                     `uvm_info(get_name(),$sformatf("PASS CASE TESTED"),UVM_NONE)
                   else
                     `uvm_info(get_name(),$sformatf("data is not matched"),UVM_NONE)
        end 
       
    endtask

endclass
