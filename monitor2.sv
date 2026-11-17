class apb_op_mon extends uvm_monitor; 
  `uvm_component_utils(apb_op_mon)
     uvm_analysis_port#(apb_seq_item)op_port;
        apb_seq_item seq;
        virtual apb_int vif;
        
     function new(string name = "",uvm_component parent);
      super.new(name,parent);
      op_port=new("op_port",this);
    endfunction
        
    function void build_phase(uvm_phase phase);
       seq=apb_seq_item::type_id::create("seq");
         if(!uvm_config_db#(virtual apb_int)::get(this, "", "vir_inter", vif))
            `uvm_fatal("DONE", "Virtual interface not found(in_mon)")


    endfunction
    
    task run();
        forever begin 
           @(posedge vif.pclk); 
           @(vif.apb_read_data)
            //pin-->pkt
            seq.apb_read_data = vif.apb_read_data;         
            //  bfm();
            seq.print();
            op_port.write(seq);
        end
    endtask 

    task bfm();

    endtask

endclass   

  
