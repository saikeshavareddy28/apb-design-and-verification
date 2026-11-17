class apb_write_seq extends apb_seq;
    `uvm_object_utils(apb_write_seq)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        repeat(5) begin
        apb_seq_item req;

        req = apb_seq_item::type_id::create("req");
        start_item(req);

        //req.transfer        = 1;
        req.apb_wr_rd       = 1;   
        //req.sel             = 1;
        //req.enable          = 1;

        assert(req.randomize() with {
                                      apb_addr inside {[0:15]};
                                      apb_write_data inside {[0:255]};});
        finish_item(req);
        end
    endtask
endclass
