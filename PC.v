module PC(
    input CLK,
    input EFR,
    input [7:0]PC
    output [7:0] NPC
    );
reg [7:0] PC_ram;
reg [7:0] BPC;
always @ (posedge clk)
	begin
	// Write
		if (BPC!=PC) 
		  BPC<=PC;
		  PC_ram<=PC;
		else
		  PC_ram<=PC_ram+ 8’b 00000001;
	end
   assign NPC = PC_ram;
endmodule
