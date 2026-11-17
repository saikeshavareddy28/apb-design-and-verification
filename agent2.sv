class apb_agent2 extends uvm_agent; 
    `uvm_component_utils(apb_agent2)
        apb_op_mon  op_mon;

     function new(string name = "",uvm_component parent);
      super.new(name,parent);
    endfunction
        
    function void build_phase(uvm_phase phase);
       op_mon=apb_op_mon::type_id::create("op_mon",this);
    endfunction
    
    
endclass   
