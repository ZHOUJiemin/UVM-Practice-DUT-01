//Design Component (Register Top)
//Description: UVM practice on DUT 01
//Modification History
//Date          Author          Description
//2015.12.23    ZHOU Jiemin     First created

//Source Code Starts Here------------------------------------
module dut_reg(  //system
                    input s_clk,
                    input rst_n,
                    //register bus
                    input [31:0] reg_addr,
                    input reg_cs,
                    input reg_we,
                    input [31:0] reg_data_wr,
                    output reg_rdack,
                    output [31:0] reg_data_rd);
    //reg declaration
    //output ports
    reg reg_rdack;
    reg [31:0] reg_data_rd;
    //internal registers
    reg [31:0] reg_00;
    reg [31:0] reg_01;
    reg [31:0] reg_02;
    reg [31:0] reg_03;
    reg [31:0] reg_04;
    reg [31:0] reg_05;
    reg [31:0] reg_06;
    reg [31:0] reg_07;
    reg [31:0] reg_08;
    reg [31:0] reg_09;
    //variables
    //none

    //continuous assignment
    //none

    //process assignment
    //write process
    always@(posedge s_clk) begin
      if(!rst_n) begin
        //when being reset
        //note that register contents are not cleared by reseting
        //do nothing
      end
      else begin
        //when reset is released
        if(reg_cs && reg_we) begin
          //if cs and we are both asserted
          case(reg_addr)
            0: reg_00 <= reg_data_wr;
            1: reg_01 <= reg_data_wr;
            2: reg_02 <= reg_data_wr;
            3: reg_03 <= reg_data_wr;
            4: reg_04 <= reg_data_wr;
            5: reg_05 <= reg_data_wr;
            6: reg_06 <= reg_data_wr;
            7: reg_07 <= reg_data_wr;
          endcase
        end
      end
    end

    //read porcess
    always@(posedge s_clk) begin
      if(!rst_n) begin
        //when being reset
        //note that register contents are not cleared by reseting
        reg_rdack <= 1'b 0;
        reg_data_rd <= 32'b 0;
      end
      else begin
        //when reset is released
        //de-assert rdack 1 cycle after it's asserted
        if(reg_rdack)
          reg_rdack <= ~ reg_rdack;
        //read out register contents
        if(reg_cs && !reg_we) begin
          //if cs is asserted and we is de-assertted
          case (reg_addr)
            0: begin
              reg_data_rd <= reg_00;
              reg_rdack <= 1'b 1;
            end
            1: begin
              reg_data_rd <= reg_01;
              reg_rdack <= 1'b 1;
            end
            2: begin
              reg_data_rd <= reg_02;
              reg_rdack <= 1'b 1;
            end
            3: begin
              reg_data_rd <= reg_03;
              reg_rdack <= 1'b 1;
            end
            4: begin
              reg_data_rd <= reg_04;
              reg_rdack <= 1'b 1;
            end
            5: begin
              reg_data_rd <= reg_05;
              reg_rdack <= 1'b 1;
            end
            6: begin
              reg_data_rd <= reg_06;
              reg_rdack <= 1'b 1;
            end
            7: begin
              reg_data_rd <= reg_07;
              reg_rdack <= 1'b 1;
            end
            default: begin
              reg_data_rd <= 32'b 0;
              reg_rdack <= 1'b 0;
            end
          endcase
        end
      end
    end

    //instantiation
    //none

endmodule
