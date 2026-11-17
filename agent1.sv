class apb_agent1 extends uvm_agent; 
    `uvm_component_utils(apb_agent1)
        apb_sqr     sqr;
        apb_driver  drv;
        apb_in_mon  in_mon;

     function new(string name = "",uvm_component parent);
      super.new(name,parent);
    endfunction
        
    function void build_phase(uvm_phase phase);
       sqr=apb_sqr::type_id::create("sqr",this);
       drv=apb_driver::type_id::create("drv",this);
       in_mon=apb_in_mon::type_id::create("in_mon",this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
    
endclass     
