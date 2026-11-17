module tb();
    reg transfer,pclk,preset,apb_wr_rd,Psel,enable;
    reg [7:0] apb_write_data;
    reg [3:0] apb_addr;
    wire [7:0] apb_read_data;

    top tp(
            .transfer(transfer),
            .pclk(pclk),
            .preset(preset),
            .sel(Psel),
            .enable(enable),
            .apb_wr_rd(apb_wr_rd),
            .apb_write_data(apb_write_data),
            .apb_addr(apb_addr),
            .apb_read_data(apb_read_data)
            );
    always #5 pclk=~pclk;
/*
    initial begin
        pclk=1;
        preset=0; #30;
        preset=1;
        transfer=1;
        apb_wr_rd=1;
        Psel=0; enable=0; #10;
        Psel=1; enable=0; //#10;
        apb_addr=5;
        apb_write_data=1; #10;
        enable=1; #10;
        apb_addr=6;
        apb_write_data=2; #10;
        apb_addr=15;
        apb_write_data=3;
        #10;
        apb_wr_rd=0;
        transfer=1; 
        apb_addr=6; #10;
        apb_addr=15; #10;
        apb_addr=5; #10;
         apb_addr=6; #10;
        apb_addr=15; #10;
        apb_addr=5; #10; 
        apb_addr=6; #10;
        apb_addr=15; #10;
        apb_addr=5; 
 
    end
    */
    initial begin
        pclk=1;
        Psel=0; enable=0; transfer=1;
        preset=0; #20;
        preset=1;   
    end
    initial begin
        #30;
            enable=0; 
        repeat(15) begin
            Psel=1; #10;
          ///  enable=0; #10;
            enable=1; #10;
        end
    end
    initial begin
        #30;
            apb_wr_rd=1;
            apb_addr=1;  apb_write_data=5; #20;
            apb_addr=2; apb_write_data=10; #20;
            apb_addr=3; apb_write_data=15; #20;
            apb_addr=4; apb_write_data=20; #20;
            apb_addr=5; apb_write_data=25; #20;
            apb_addr=6; apb_write_data=30; #20;
            
            apb_wr_rd=0; // #10;
            apb_addr=1;  #20;
            apb_addr=3; #20;
            apb_addr=2;

    end
    
    initial begin
        #250 $finish;
    end
endmodule
