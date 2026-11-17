`include "uvm_macros.svh"
import uvm_pkg::*;

`include "design_top.v"

`include "interface.sv"

`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor1.sv"
`include "agent1.sv"

`include "monitor2.sv"
`include "agent2.sv"

`include "sb.sv"
`include "apb_coverage.sv"

`include "apb_env.sv"
`include "apb_read_seq.sv"
`include "apb_write_seq.sv"

`include "test.sv"
//`include "apb_read_test.sv"
//`include "apb_write_test.sv"
module top();
    bit pclk,preset;

    apb_int apbi(pclk,preset);

  design_top RTL(
            .pclk(pclk),
            .preset(preset),
            .transfer(apbi.transfer),
            .apb_wr_rd(apbi.apb_wr_rd),
            .sel(apbi.sel),
            .enable(apbi.enable),
            .apb_addr(apbi.apb_addr),
            .apb_write_data(apbi.apb_write_data),
            .apb_read_data(apbi.apb_read_data)           
            );

             initial begin
                pclk = 0;
                forever #5 pclk = ~pclk;
             end

            initial begin
                preset=0;
                #10; preset=1;
            end
 
            initial begin
              uvm_config_db#(virtual apb_int)::set(null,"*","vir_inter",apbi);
            end

            initial begin
              run_test("apb_test");
            end

  


endmodule
