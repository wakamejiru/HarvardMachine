module top();
    reg CLK, W_time;

    initial begin
        CLK = 0;
        forever #50 CLK = ~CLK;
    end
	 //ここで全てのメモリの値を定義※まだ書いてない
    initial begin
        W_time = 0;
        #300 W_time = 1;
    end
    MEM p(CLK, W_time);
endmodule
module MEM(CLK,W_time);
	input CLK,W_time;
	Instruction_MEM imem(PC,MEM,I);
	
endmodule
module Instruction_MEM
//命令メモリなので書き込みは無し
(
	input [7:0] PC,
	input CLK,
	output [21:0] I
);

	// RAM変数の宣言
	//ここでのramの中身が容量に
	//最初の変数は縦を数えて何個あるか
	reg [7:0] I_ram[63:0];
	
	// 登録されている読み取りアドレスを保持する変数
	reg [7:0] PC_reg;
	assign I = I_ram[PC[7:0]];
endmodule
module Data_MEM
//データメモリ書き込みあり
(
	input [15:0] DW,
	input [15:0] OR,
	input [15:0]data,//dataは入力のデータそのもの
	input we,CLK,
	//we:writeフラグ
	output [15:0] DR//出力データ
);

	// RAM変数の宣言
	//ここでのramの中身が容量に
	//最初の変数は縦を数えて何個あるか
	reg [7:0] D_ram[63:0];
	
	// 登録されている読み取りアドレスを保持する変数
	reg [15:0] OR_reg;
	always @ (posedge CLK)
	begin
	// 書き込み開始
		if (we)
			D_ram[DW] <= data;
		
		 OR_reg<= DW;
		
	end
	assign DR = D_ram[OR[15:0]];
endmodule
module Accumulator_MEM
//累積器メモリ書き込みあり
(
	input [15:0] AW,//データ
	input we,CLK,
	//we:writeフラグ
	output [15:0] AR
);

	// RAM変数の宣言
	//ここでのramの中身が容量に
	//最初の変数は縦を数えて何個あるか
	reg [15:0]A_ram;
	
	// 登録されている読み取りアドレスを保持する変数
	reg [15:0] AR_reg;
	always @ (posedge CLK)
	begin
	// 書き込み開始
		if (we)
			A_ram<= AW;
		
		 AR_reg<= AW;
		
	end
	assign AR = A_ram;
endmodule
module Status_MEM
//ステータスメモリ書き込みあり
(
	input EFW,CFW,CLK,
	output EFF,CFF//データ
);

	// RAM変数の宣言
	//ここでのramの中身が容量に
	//最初の変数は縦を数えて何個あるか
	reg EF,CF;
	always @ (posedge CLK)
	begin
	// 書き込み開始
	EF <= EFW;
	CF <= CFW;
	end
	assign EFF = EF;
	assign CFF=CF;
endmodule