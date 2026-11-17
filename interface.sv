interface apb_int(input logic pclk,
                  input logic preset
                 );
                  logic transfer;
                  logic apb_wr_rd;
                  logic sel;
                  logic enable;
 
                  logic [7:0] apb_write_data;
                  logic [3:0] apb_addr;
                  logic [7:0] apb_read_data;

                                     
endinterface


                
