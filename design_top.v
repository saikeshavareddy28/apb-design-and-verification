`include "master.v"
`include "slave.v"

module design_top(
            input pclk,preset,transfer,apb_wr_rd,sel,enable,
            input [3:0] apb_addr,
            input [7:0] apb_write_data,
            output [7:0] apb_read_data
         
            );
//wire [7:0] rd;
    wire pwrite,pselx,penable,pready,pslverr;
    wire [3:0] paddr;
    wire [7:0] pwdata,prdata;
 always @(posedge pclk) begin
        //if(!preset)
            //apb_read_data=0;
    end

    
   
    master mas(
                .apb_wr_rd(apb_wr_rd),
                .transfer(transfer),
                .pclk(pclk),
                .preset(preset),
                .sel(sel),
                .enable(enable),
                .apb_write_data(apb_write_data),
                .apb_addr(apb_addr),
                .apb_read_data(apb_read_data),
                .pwrite(pwrite),
                .pselx(pselx),
                .penable(penable),
                .paddr(paddr),
                .pwdata(pwdata),
                .pready(pready),
                .pslverr(pslverr),
                .prdata(prdata)
                );
    slave sla(
                .pclk(pclk),
                .preset(preset),
                .pwrite(pwrite),
                .pselx(pselx),
                .penable(penable),
                .paddr(paddr),
                .pwdata(pwdata),
                .pready(pready),
                .pslverr(pslverr),
                .prdata(prdata)
                );

endmodule
