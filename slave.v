/*
                                                    -------------------------
                                                    |                       |
                                   pclk------------>|                       |
                                                    |                       |------------> pready
                                   preset---------->|                       |
                                                    |                       |
                                   pwrite---------->|           APB         |------------> pslverr
                                                    |          SLAVE        |
                                   pselx----------->|                       |
                                                    |                       |------------> prdata [7:0]
                                   penable--------->|                       |
                                                    |                       |
                             [3:0] paddr----------->|                       |
                                                    |                       |
                             [7:0] pwdata---------->|                       |
                                                    |                       |
                                                    -------------------------
*/

module slave(
                input pclk,preset,
                input pwrite,pselx,penable,
                input [3:0] paddr,
                input [7:0] pwdata,
                output reg pready,
                output reg pslverr,
                output reg [7:0]  prdata
                );
    reg [7:0] mem [15:0];
    integer i;
 //   reg [3:0] addr;
 //   assign prdata=mem[addr];
    always @(*) begin
        if(!preset)
            begin
                prdata=0;
                pready=0;
                for(i=0;i<16;i=i+1)
                    mem[i]=0;
            end
        else
            begin
                if(pselx && !penable && pwrite)
                    begin
                        pready=0;
                        prdata=0;
                    end
                else if(pselx && !penable && !pwrite)
                    begin
                        pready=0;   //here if we put pready=0 then the fsm of master doesnot goes to access state to setup state
                   //     prdata=0;
                    end
                else if(pselx && penable && pwrite)
                    begin
                        mem[paddr]=pwdata;
                        pready=1;
                    end
                else if(pselx && penable && !pwrite)
                    begin
                        prdata=mem[paddr];
                        pready=1;
                    end
                 //  addr=paddr;
                else 
                    pready=0;
            end
    end
    //slave error
    always @(*) begin
        if(pselx && penable)
            begin
                if(pwrite)
                    begin
                        if(paddr==4'bx || pwdata==8'bx)
                            pslverr=1;
                    end
                else if (!pwrite)
                    begin
                        if(mem[paddr]==8'bx)
                            pslverr=1;
                    end
            end
        else
            pslverr=0;
    end
endmodule
