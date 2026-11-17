class apb_seq extends uvm_sequence#(apb_seq_item); 
    `uvm_object_utils(apb_seq)
     
 
     function new(string name ="");
      super.new(name);
    endfunction
        
endclass
