`include "defines.v"

module if_id(
    input wire                   rst,
    input wire                   clk,

    input wire [3:0]             stall,

    input wire [`INST_ADDR_BUS]  if_pc,
    input wire [`INST_BUS]       if_instr,
    
    output reg [`INST_ADDR_BUS]  id_pc,
    output reg [`INST_BUS]       id_instr
    );
    
    wire inst_stall, id_stall, exe_stall, data_stall;
    assign inst_stall = stall[0];
    assign id_stall = stall[1];
    assign exe_stall = stall[2];
    assign data_stall = stall[3];
    
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            id_pc <= `ZEROWORD32;
            id_instr <= `ZEROWORD32;
        end else begin
            if (stall != 4'b0000) begin
                id_pc <= `ZEROWORD32;
			    id_instr <= `ZEROWORD32;	
            end else begin
                id_pc <= if_pc;
                id_instr <= if_instr;
            end
        end
    end
endmodule
