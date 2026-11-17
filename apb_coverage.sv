class apb_cov extends uvm_subscriber #(apb_seq_item);


    `uvm_component_utils(apb_cov)
    apb_seq_item seq;
    
    // virtual apb_int vif;



        covergroup apb_cg ;

        // Address coverage
        cp_addr : coverpoint seq.apb_addr {
            bins addr_0      = {4'h0};
            bins addr_low    = {[1:7]};
            bins addr_mid    = {[8:12]};
            bins addr_high   = {[13:15]};
        }

        // Read/Write operation
        cp_wr_rd : coverpoint seq.apb_wr_rd {
            bins write = {1};
            bins read  = {0};
        }

        // Write data 
        cp_wdata : coverpoint seq.apb_write_data {
            bins zero      = {8'h00};
            //bins all_ones  = {8'hFF};
            
        }

        // Read data 
        cp_rdata : coverpoint seq.apb_read_data {
            bins zero      = {8'h00};
            //bins all_ones  = {8'hFF};
       
        }

        // Transfer
        cp_transfer : coverpoint seq.transfer {
            bins no_trans = {0};
            bins trans    = {1};
        }

    
    endgroup

    function new(string name="", uvm_component parent);
        super.new(name, parent);
        apb_cg = new;
    endfunction

  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

   
    function void write(apb_seq_item t);
        seq = apb_seq_item::type_id::create("seq");
        seq = t;
        apb_cg.sample();  
    endfunction

endclass

/*class apb_cov extends uvm_subscriber#(apb_seq_item);
    `uvm_component_utils(apb_cov)
       // uvm_analysis_imp#(seq_item, my_coverage)cov_port;
        apb_seq_item seq;

        function new(string name ="",uvm_component parent);
            super.new(name,parent);
 
        endfunction

        function void build_phase(uvm_phase phase);
            seq=apb_seq_item::type_id::create("seq");
        endfunction

        function void write(apb_seq_item t);
            seq=t;
        endfunction
endclass*/

