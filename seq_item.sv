class apb_seq_item extends uvm_sequence_item;
     rand bit transfer;
     rand bit apb_wr_rd;
     rand bit sel;
     rand bit enable;

    rand bit [7:0] apb_write_data; //input signal
    rand bit [3:0] apb_addr;      //input signal
         bit [7:0] apb_read_data;//output signal

    `uvm_object_utils_begin(apb_seq_item)
        `uvm_field_int(transfer,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(apb_wr_rd,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(sel,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(enable,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(apb_write_data,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(apb_addr,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(apb_read_data,UVM_ALL_ON|UVM_DEC)
     `uvm_object_utils_end

    function new(string name = "");
        super.new(name);
    endfunction

    constraint c1 {transfer==1;}
endclass
