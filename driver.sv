class apb_driver extends uvm_driver#(apb_seq_item); 
    `uvm_component_utils(apb_driver)
        apb_seq_item seq;
        virtual apb_int vif;

        function new(string name = "",uvm_component parent);
          super.new(name,parent);
        endfunction
        
        function void build_phase(uvm_phase phase);
            seq=apb_seq_item::type_id::create("seq");
            if(!uvm_config_db#(virtual apb_int)::get(this, "", "vir_inter", vif))
            `uvm_fatal("done", "virtual interface not found in config db");
        endfunction

        task run_phase(uvm_phase phase);
            wait(vif.preset==1);
          forever begin
              seq_item_port.get_next_item(seq);
              //drive();
              r();
             seq.print();
             seq_item_port.item_done();
         end
       endtask

       task r();
        vif.transfer<=1'b1;
        vif.sel<=1'b0;
        vif.enable<=1'b0;
        @(posedge vif.pclk);
        vif.apb_write_data<=seq.apb_write_data;
        vif.apb_addr<=seq.apb_addr;
        vif.sel<=1'b1;
        vif.apb_wr_rd<=seq.apb_wr_rd;
        vif.enable<=1'b1;
        @(posedge vif.pclk);
        
       endtask

          task drive();
            //pkt--->pin
            vif.transfer       <= seq.transfer;
            vif.sel           <= seq.sel;
            vif.apb_wr_rd      <= seq.apb_wr_rd;
            vif.enable         <= seq.enable;
            vif.apb_write_data <= seq.apb_write_data;
            vif.apb_addr       <= seq.apb_addr;
            @(posedge vif.pclk);
         endtask
endclass
