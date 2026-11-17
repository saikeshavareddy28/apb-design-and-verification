 /*
                                                    -----------------------------
                                                    |                           |
                                pclk--------------->|                           |------------>pwrite
                                                    |                           |
                                preset------------->|                           |------------>pselx
                                                    |                           |
                                Transfer----------->|                           |------------>penable
                                                    |                           |
                                apb_wr_rd---------->|                           |------------> [3:0] paddr 
                                                    |           APB             |
                                                    |         Master            |------------> [7:0] pwdata
                                                    |                           |
                                [3:0] apb_addr----->|                           |<------------ pready
                                                    |                           |
                                                    |                           |<------------ pslverr
                                                    |                           |
                          [7:0] apb_write_data----->|                           |<------------ [7:0] prdata
                                                    |                           |
                          [7:0] apb_read_data<------|                           |
                                                    |                           |
                                                    -----------------------------
*/
module master(
                input wire pclk,preset,      //global signals
                input wire sel,enable,
                input wire pready,pslverr,
                input wire [7:0] prdata,
                output reg pselx,penable,
                output reg [7:0] pwdata,
                output reg [3:0] paddr,
                output reg pwrite,
                                                                        //---------------------------------------------------
                input [7:0] apb_write_data, //apb_read_data,                                                                |
           //     input [3:0] apb_write_addr,
                input [3:0] apb_addr,                               //                  From top                            |
                output  reg [7:0] apb_read_data,                     //                                                      |
                                                                        //---------------------------------------------------
                input transfer,apb_wr_rd

                );
                                               //       assign  apb_read_data=prdata;

    reg [7:0] mem [15:0];
    parameter idle=2'b00;
    parameter setup=2'b01;
    parameter access=2'b10;
    reg [1:0] cs,ns;


    //assign apb_read_data=prdata;

    always @(posedge pclk) begin
        pselx=sel;
        penable=enable;
        if(!preset)     //Active low reset
            begin
                cs<=idle;
             //   ns<=cs;
            end
        else
            cs<=ns;
    end


    

    always @(*) begin
        pwrite=apb_wr_rd;
        case(cs)
            idle    :   begin
                            if(!pselx && ! penable && transfer)
                          //  if(transfer)
                                ns=setup;
                            else
                                ns=idle;
                        end
            setup   :   begin
                    
                            if(apb_wr_rd && transfer)
                                begin
                                    pwdata=apb_write_data;
                                    paddr=apb_addr;
                                end
                            else
                                begin
                                    paddr=apb_addr;
                                end 
                     
                            if(pselx && !penable && transfer && !pslverr)
                                ns<=access;
                            else if(pselx && penable && transfer && !pslverr)
                                ns<=access;
                            else if(!pselx && !penable && transfer && !pslverr)
                                ns<=setup;
                            else
                                ns=idle;
                        end
            access  :   begin
                            if(pselx && penable)
                                begin
                                    if(pslverr && !transfer)
                                        ns=idle;
                                    else  
                                        begin
                                            if(!pready) //pready=0 means slave is not ready we should wait
                                                ns=access; 
                                            else if(pready)
                                                begin
                                                    if(apb_wr_rd && transfer)
                                                        begin
                                                            ns=setup;
                                                        end
                                                    else if (!apb_wr_rd && transfer)
                                                        begin
                                                            ns=setup;
                                                            apb_read_data=prdata;
                                                        end
                                                end         
                                        end                            
                                  end
                                else if(pselx &&!penable)
                                        ns=setup;
                                else
                                   ns<=idle;
                            end 
           default  : ns<=idle;
        endcase
    end

endmodule

/*
        case(cs)
            idle    :   begin
                            if(pselx && ! penable && transfer)
                                ns<=setup;
                            else
                                ns<=idle;
                        end
            setup   :   begin
                    
                            if(apb_wr_rd && transfer)
                                begin
                                    pwdata=apb_write_data;
                                    paddr=apb_addr;
                                end
                            else
                                begin
                                    paddr=apb_addr;
                                end 
                     
                            if(pselx && penable && transfer && !pslverr)
                                ns<=access;
                            else if(pselx && !penable && transfer && !pslverr)
                                ns<=setup;
                            else
                                ns<=idle;
                        end
            access  :   begin
                            if(pselx && penable)
                                begin
                                    if(pslverr && !transfer)
                                        ns<=idle;
                                    else  
                                        begin
                                            if(!pready) //pready=0 means slave is not ready we should wait
                                                ns<=access; 
                                            else if(pready)
                                                begin
                                                    if(apb_wr_rd)// && transfer)
                                                        begin
                                                            ns=setup;
                                                        end
                                                    else if (!apb_wr_rd)// && transfer)
                                                        begin
                                                            ns=setup;
                                                            apb_read_data=prdata;
                                                        end
                                                end         
                                        end                            
                                  end
                                else if(pselx &&!penable)
                                        ns=setup;
                                else
                                   ns<=idle;
                            end 
           default  : ns<=idle;
        endcase

        */
