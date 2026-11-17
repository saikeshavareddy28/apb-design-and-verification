class apb_in_mon extends uvm_monitor; 
    `uvm_component_utils(apb_in_mon)
     uvm_analysis_port#(apb_seq_item)in_port;
        apb_seq_item seq;
        virtual apb_int vif;
        
     function new(string name = "",uvm_component parent);
      super.new(name,parent);
      in_port=new("in_port",this);
    endfunction
        
    function void build_phase(uvm_phase phase);
       seq=apb_seq_item::type_id::create("seq");
         if(!uvm_config_db#(virtual apb_int)::get(this, "", "vir_inter", vif))
            `uvm_fatal("DONE", "Virtual interface not found(op_mon)")
    endfunction
    
    task run();
        forever begin 
           @(posedge vif.pclk); 
          // @(vif.transfer, vif.psel , vif.apb_wr_rd , vif.enable , vif.apb_write_data , vif.apb_addr)
           if(vif.sel && vif.enable)

           //pin-->pkt
            seq.transfer       = vif.transfer;
            seq.sel            = vif.sel;
            seq.apb_wr_rd      = vif.apb_wr_rd;
            seq.enable         = vif.enable;
            seq.apb_write_data = vif.apb_write_data;
            seq.apb_addr       = vif.apb_addr;
           
            //  bfm();
            seq.print();
            in_port.write(seq);
        end
    endtask 

    task bfm();

    endtask

endclass     
