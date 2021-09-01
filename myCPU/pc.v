`include "defines.v"

module pc(
	input wire                    rst,
	input wire                    clk,
	
	input wire[3:0]               stall,
	
	input wire                    branch_enable_i,
	input wire  [`INST_ADDR_BUS]  branch_addr_i,

	output reg  [`INST_ADDR_BUS]  pc_o,
	output reg                    ce
    );
	
    wire inst_stall, id_stall, exe_stall, data_stall;
    assign inst_stall = stall[0];
    assign id_stall = stall[1];
    assign exe_stall = stall[2];
    assign data_stall = stall[3];

	always @ (posedge clk) begin
		if (rst == `RST_ENABLE) begin
			pc_o <= 32'hbfc0_0000;
		end else begin			
			if (branch_enable_i == `BRANCH_ENABLE) begin
				if (stall == 4'b0000) pc_o <= branch_addr_i;
			end else begin
				if (stall == 4'b0000) pc_o <= pc_o + 4;
			end			
		end
	end

	always @ (posedge clk) begin
		if (rst == `RST_ENABLE) begin
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;
		end
	end
	
endmodule