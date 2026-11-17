class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)
        apb_agent1 ag1;
        apb_agent2 ag2;
        apb_sb     sb;
        apb_cov    cov;

        function new(string name ="",uvm_component parent);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            ag1=apb_agent1::type_id::create("ag1",this);
            ag2=apb_agent2::type_id::create("ag2",this);
            sb=apb_sb::type_id::create("sb",this);
            cov=apb_cov::type_id::create("cov",this);
        endfunction

        function void connect_phase(uvm_phase phase);
        ag1.in_mon.in_port.connect(sb.ip_fifo.analysis_export);
        ag2.op_mon.op_port.connect(sb.op_fifo.analysis_export);
        ag1.in_mon.in_port.connect(cov.analysis_export); 
        endfunction
endclass
