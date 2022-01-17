module serv_auto_decode
  #(parameter [0:0] MDU = 1'b0,
    parameter [0:0] CSR = 1'b0)
  (
   input wire i_clk,
   //Input
   input wire i_en,
   input wire i_imm30,
   input wire [2:0] i_funct3,
   input wire [4:0] i_opcode,
   //MDU/Ext/CSR
   input wire i_imm25,
   output reg [2:0] o_ext_funct3,
   output reg o_mdu_op,
   input wire i_op20,
   input wire i_op21,
   input wire i_op22,
   input wire i_op26,
   output reg o_e_op,
   output reg o_ebreak,
   output reg o_ctrl_mret,
   output reg o_csr_en,
   output reg o_csr_addr1,
   output reg o_csr_addr0,
   output reg o_csr_mstatus_en,
   output reg o_csr_mie_en,
   output reg o_csr_mcause_en,
   output reg o_csr_source1,
   output reg o_csr_source0,
   output reg o_csr_d_sel,
   output reg o_csr_imm_en,
   output reg o_rd_csr_en,
   //Output
   output wire o_branch_op,
   output wire o_rd_ctrl_sel,
   output wire o_slt_or_branch,
   output wire o_alu_rd_sel1,
   output wire o_op_b_source,
   output wire o_mem_cmd,
   output wire o_immdec_ctrl0,
   output wire o_immdec_en0,
   output wire o_immdec_ctrl1,
   output wire o_bufreg_rs1_en,
   output wire o_immdec_ctrl2,
   output wire o_cond_branch,
   output wire o_immdec_ctrl3,
   output wire o_two_stage_op,
   output wire o_immdec_en1,
   output wire o_immdec_en2,
   output wire o_immdec_en3,
   output wire o_bne_or_bge,
   output wire o_rd_alu_sel,
   output wire o_sh_right,
   output wire o_alu_cmp_sig,
   output wire o_mem_half,
   output wire o_shift_op,
   output wire o_ctrl_utype,
   output wire o_rd_op,
   output wire o_dbus_en,
   output wire o_alu_rd_sel0,
   output wire o_bufreg_imm_en,
   output wire o_alu_rd_sel2,
   output wire o_bufreg_clr_lsb,
   output wire o_ctrl_pc_rel,
   output wire o_alu_sub,
   output wire o_alu_bool_op1,
   output wire o_bufreg_sh_signed,
   output wire o_alu_cmp_eq,
   output wire o_mem_signed,
   output wire o_alu_bool_op0,
   output wire o_mem_word);

   (* ram_style = "block" *) reg [18:0] mem [0:511];
   reg [18:0] d;

   initial begin
      mem[0] = 19'h2e350;
      mem[1] = 19'h00000;
      mem[2] = 19'h00000;
      mem[3] = 19'h00000;
      mem[4] = 19'h06710;
      mem[5] = 19'h13381;
      mem[6] = 19'h00000;
      mem[7] = 19'h00000;
      mem[8] = 19'h0c25c;
      mem[9] = 19'h00000;
      mem[10] = 19'h00000;
      mem[11] = 19'h00000;
      mem[12] = 19'h06404;
      mem[13] = 19'h03381;
      mem[14] = 19'h00000;
      mem[15] = 19'h00000;
      mem[16] = 19'h00000;
      mem[17] = 19'h00000;
      mem[18] = 19'h00000;
      mem[19] = 19'h00000;
      mem[20] = 19'h00000;
      mem[21] = 19'h00000;
      mem[22] = 19'h00000;
      mem[23] = 19'h00000;
      mem[24] = 19'h3826f;
      mem[25] = 19'h0a157;
      mem[26] = 19'h00000;
      mem[27] = 19'h1a3c7;
      mem[28] = 19'h00000;
      mem[29] = 19'h00000;
      mem[30] = 19'h00000;
      mem[31] = 19'h00000;
      mem[32] = 19'h2eb50;
      mem[33] = 19'h00000;
      mem[34] = 19'h00000;
      mem[35] = 19'h00000;
      mem[36] = 19'h43750;
      mem[37] = 19'h13381;
      mem[38] = 19'h00000;
      mem[39] = 19'h00000;
      mem[40] = 19'h0ca5c;
      mem[41] = 19'h00000;
      mem[42] = 19'h00000;
      mem[43] = 19'h00000;
      mem[44] = 19'h43454;
      mem[45] = 19'h03381;
      mem[46] = 19'h00000;
      mem[47] = 19'h00000;
      mem[48] = 19'h00000;
      mem[49] = 19'h00000;
      mem[50] = 19'h00000;
      mem[51] = 19'h00000;
      mem[52] = 19'h00000;
      mem[53] = 19'h00000;
      mem[54] = 19'h00000;
      mem[55] = 19'h00000;
      mem[56] = 19'h3866f;
      mem[57] = 19'h0a157;
      mem[58] = 19'h00000;
      mem[59] = 19'h1a3c7;
      mem[60] = 19'h00000;
      mem[61] = 19'h00000;
      mem[62] = 19'h00000;
      mem[63] = 19'h00000;
      mem[64] = 19'h4e350;
      mem[65] = 19'h00000;
      mem[66] = 19'h00000;
      mem[67] = 19'h00000;
      mem[68] = 19'h12f52;
      mem[69] = 19'h13381;
      mem[70] = 19'h00000;
      mem[71] = 19'h00000;
      mem[72] = 19'h4c25c;
      mem[73] = 19'h00000;
      mem[74] = 19'h00000;
      mem[75] = 19'h00000;
      mem[76] = 19'h12c46;
      mem[77] = 19'h03381;
      mem[78] = 19'h00000;
      mem[79] = 19'h00000;
      mem[80] = 19'h00000;
      mem[81] = 19'h00000;
      mem[82] = 19'h00000;
      mem[83] = 19'h00000;
      mem[84] = 19'h00000;
      mem[85] = 19'h00000;
      mem[86] = 19'h00000;
      mem[87] = 19'h00000;
      mem[88] = 19'h00000;
      mem[89] = 19'h0a157;
      mem[90] = 19'h00000;
      mem[91] = 19'h1a3c7;
      mem[92] = 19'h00000;
      mem[93] = 19'h00000;
      mem[94] = 19'h00000;
      mem[95] = 19'h00000;
      mem[96] = 19'h00000;
      mem[97] = 19'h00000;
      mem[98] = 19'h00000;
      mem[99] = 19'h00000;
      mem[100] = 19'h12752;
      mem[101] = 19'h13381;
      mem[102] = 19'h00000;
      mem[103] = 19'h00000;
      mem[104] = 19'h00000;
      mem[105] = 19'h00000;
      mem[106] = 19'h00000;
      mem[107] = 19'h00000;
      mem[108] = 19'h12446;
      mem[109] = 19'h03381;
      mem[110] = 19'h00000;
      mem[111] = 19'h00000;
      mem[112] = 19'h00000;
      mem[113] = 19'h00000;
      mem[114] = 19'h00000;
      mem[115] = 19'h00000;
      mem[116] = 19'h00000;
      mem[117] = 19'h00000;
      mem[118] = 19'h00000;
      mem[119] = 19'h00000;
      mem[120] = 19'h00000;
      mem[121] = 19'h0a157;
      mem[122] = 19'h00000;
      mem[123] = 19'h1a3c7;
      mem[124] = 19'h00000;
      mem[125] = 19'h00000;
      mem[126] = 19'h00000;
      mem[127] = 19'h00000;
      mem[128] = 19'h0e350;
      mem[129] = 19'h00000;
      mem[130] = 19'h00000;
      mem[131] = 19'h00000;
      mem[132] = 19'h0a710;
      mem[133] = 19'h13381;
      mem[134] = 19'h00000;
      mem[135] = 19'h00000;
      mem[136] = 19'h00000;
      mem[137] = 19'h00000;
      mem[138] = 19'h00000;
      mem[139] = 19'h00000;
      mem[140] = 19'h0a404;
      mem[141] = 19'h03381;
      mem[142] = 19'h00000;
      mem[143] = 19'h00000;
      mem[144] = 19'h00000;
      mem[145] = 19'h00000;
      mem[146] = 19'h00000;
      mem[147] = 19'h00000;
      mem[148] = 19'h00000;
      mem[149] = 19'h00000;
      mem[150] = 19'h00000;
      mem[151] = 19'h00000;
      mem[152] = 19'h18a6f;
      mem[153] = 19'h0a157;
      mem[154] = 19'h00000;
      mem[155] = 19'h1a3c7;
      mem[156] = 19'h00000;
      mem[157] = 19'h00000;
      mem[158] = 19'h00000;
      mem[159] = 19'h00000;
      mem[160] = 19'h0eb50;
      mem[161] = 19'h00000;
      mem[162] = 19'h00000;
      mem[163] = 19'h00000;
      mem[164] = 19'h43f50;
      mem[165] = 19'h13381;
      mem[166] = 19'h00000;
      mem[167] = 19'h00000;
      mem[168] = 19'h00000;
      mem[169] = 19'h00000;
      mem[170] = 19'h00000;
      mem[171] = 19'h00000;
      mem[172] = 19'h43c54;
      mem[173] = 19'h03381;
      mem[174] = 19'h00000;
      mem[175] = 19'h00000;
      mem[176] = 19'h00000;
      mem[177] = 19'h00000;
      mem[178] = 19'h00000;
      mem[179] = 19'h00000;
      mem[180] = 19'h00000;
      mem[181] = 19'h00000;
      mem[182] = 19'h00000;
      mem[183] = 19'h00000;
      mem[184] = 19'h18e6f;
      mem[185] = 19'h0a157;
      mem[186] = 19'h00000;
      mem[187] = 19'h1a3c7;
      mem[188] = 19'h00000;
      mem[189] = 19'h00000;
      mem[190] = 19'h00000;
      mem[191] = 19'h00000;
      mem[192] = 19'h00000;
      mem[193] = 19'h00000;
      mem[194] = 19'h00000;
      mem[195] = 19'h00000;
      mem[196] = 19'h1a710;
      mem[197] = 19'h13381;
      mem[198] = 19'h00000;
      mem[199] = 19'h00000;
      mem[200] = 19'h00000;
      mem[201] = 19'h00000;
      mem[202] = 19'h00000;
      mem[203] = 19'h00000;
      mem[204] = 19'h1a404;
      mem[205] = 19'h03381;
      mem[206] = 19'h00000;
      mem[207] = 19'h00000;
      mem[208] = 19'h00000;
      mem[209] = 19'h00000;
      mem[210] = 19'h00000;
      mem[211] = 19'h00000;
      mem[212] = 19'h00000;
      mem[213] = 19'h00000;
      mem[214] = 19'h00000;
      mem[215] = 19'h00000;
      mem[216] = 19'h1826f;
      mem[217] = 19'h0a157;
      mem[218] = 19'h00000;
      mem[219] = 19'h1a3c7;
      mem[220] = 19'h00000;
      mem[221] = 19'h00000;
      mem[222] = 19'h00000;
      mem[223] = 19'h00000;
      mem[224] = 19'h00000;
      mem[225] = 19'h00000;
      mem[226] = 19'h00000;
      mem[227] = 19'h00000;
      mem[228] = 19'h5a710;
      mem[229] = 19'h13381;
      mem[230] = 19'h00000;
      mem[231] = 19'h00000;
      mem[232] = 19'h00000;
      mem[233] = 19'h00000;
      mem[234] = 19'h00000;
      mem[235] = 19'h00000;
      mem[236] = 19'h5a404;
      mem[237] = 19'h03381;
      mem[238] = 19'h00000;
      mem[239] = 19'h00000;
      mem[240] = 19'h00000;
      mem[241] = 19'h00000;
      mem[242] = 19'h00000;
      mem[243] = 19'h00000;
      mem[244] = 19'h00000;
      mem[245] = 19'h00000;
      mem[246] = 19'h00000;
      mem[247] = 19'h00000;
      mem[248] = 19'h1866f;
      mem[249] = 19'h0a157;
      mem[250] = 19'h00000;
      mem[251] = 19'h1a3c7;
      mem[252] = 19'h00000;
      mem[253] = 19'h00000;
      mem[254] = 19'h00000;
      mem[255] = 19'h00000;
      mem[256] = 19'h2e350;
      mem[257] = 19'h00000;
      mem[258] = 19'h00000;
      mem[259] = 19'h00000;
      mem[260] = 19'h06710;
      mem[261] = 19'h13381;
      mem[262] = 19'h00000;
      mem[263] = 19'h00000;
      mem[264] = 19'h0c25c;
      mem[265] = 19'h00000;
      mem[266] = 19'h00000;
      mem[267] = 19'h00000;
      mem[268] = 19'h16404;
      mem[269] = 19'h03381;
      mem[270] = 19'h00000;
      mem[271] = 19'h00000;
      mem[272] = 19'h00000;
      mem[273] = 19'h00000;
      mem[274] = 19'h00000;
      mem[275] = 19'h00000;
      mem[276] = 19'h00000;
      mem[277] = 19'h00000;
      mem[278] = 19'h00000;
      mem[279] = 19'h00000;
      mem[280] = 19'h3826f;
      mem[281] = 19'h0a157;
      mem[282] = 19'h00000;
      mem[283] = 19'h1a3c7;
      mem[284] = 19'h00000;
      mem[285] = 19'h00000;
      mem[286] = 19'h00000;
      mem[287] = 19'h00000;
      mem[288] = 19'h2eb50;
      mem[289] = 19'h00000;
      mem[290] = 19'h00000;
      mem[291] = 19'h00000;
      mem[292] = 19'h00000;
      mem[293] = 19'h13381;
      mem[294] = 19'h00000;
      mem[295] = 19'h00000;
      mem[296] = 19'h0ca5c;
      mem[297] = 19'h00000;
      mem[298] = 19'h00000;
      mem[299] = 19'h00000;
      mem[300] = 19'h00000;
      mem[301] = 19'h03381;
      mem[302] = 19'h00000;
      mem[303] = 19'h00000;
      mem[304] = 19'h00000;
      mem[305] = 19'h00000;
      mem[306] = 19'h00000;
      mem[307] = 19'h00000;
      mem[308] = 19'h00000;
      mem[309] = 19'h00000;
      mem[310] = 19'h00000;
      mem[311] = 19'h00000;
      mem[312] = 19'h3866f;
      mem[313] = 19'h0a157;
      mem[314] = 19'h00000;
      mem[315] = 19'h1a3c7;
      mem[316] = 19'h00000;
      mem[317] = 19'h00000;
      mem[318] = 19'h00000;
      mem[319] = 19'h00000;
      mem[320] = 19'h4e350;
      mem[321] = 19'h00000;
      mem[322] = 19'h00000;
      mem[323] = 19'h00000;
      mem[324] = 19'h12f52;
      mem[325] = 19'h13381;
      mem[326] = 19'h00000;
      mem[327] = 19'h00000;
      mem[328] = 19'h4c25c;
      mem[329] = 19'h00000;
      mem[330] = 19'h00000;
      mem[331] = 19'h00000;
      mem[332] = 19'h00000;
      mem[333] = 19'h03381;
      mem[334] = 19'h00000;
      mem[335] = 19'h00000;
      mem[336] = 19'h00000;
      mem[337] = 19'h00000;
      mem[338] = 19'h00000;
      mem[339] = 19'h00000;
      mem[340] = 19'h00000;
      mem[341] = 19'h00000;
      mem[342] = 19'h00000;
      mem[343] = 19'h00000;
      mem[344] = 19'h00000;
      mem[345] = 19'h0a157;
      mem[346] = 19'h00000;
      mem[347] = 19'h1a3c7;
      mem[348] = 19'h00000;
      mem[349] = 19'h00000;
      mem[350] = 19'h00000;
      mem[351] = 19'h00000;
      mem[352] = 19'h00000;
      mem[353] = 19'h00000;
      mem[354] = 19'h00000;
      mem[355] = 19'h00000;
      mem[356] = 19'h12752;
      mem[357] = 19'h13381;
      mem[358] = 19'h00000;
      mem[359] = 19'h00000;
      mem[360] = 19'h00000;
      mem[361] = 19'h00000;
      mem[362] = 19'h00000;
      mem[363] = 19'h00000;
      mem[364] = 19'h00000;
      mem[365] = 19'h03381;
      mem[366] = 19'h00000;
      mem[367] = 19'h00000;
      mem[368] = 19'h00000;
      mem[369] = 19'h00000;
      mem[370] = 19'h00000;
      mem[371] = 19'h00000;
      mem[372] = 19'h00000;
      mem[373] = 19'h00000;
      mem[374] = 19'h00000;
      mem[375] = 19'h00000;
      mem[376] = 19'h00000;
      mem[377] = 19'h0a157;
      mem[378] = 19'h00000;
      mem[379] = 19'h1a3c7;
      mem[380] = 19'h00000;
      mem[381] = 19'h00000;
      mem[382] = 19'h00000;
      mem[383] = 19'h00000;
      mem[384] = 19'h0e350;
      mem[385] = 19'h00000;
      mem[386] = 19'h00000;
      mem[387] = 19'h00000;
      mem[388] = 19'h0a710;
      mem[389] = 19'h13381;
      mem[390] = 19'h00000;
      mem[391] = 19'h00000;
      mem[392] = 19'h00000;
      mem[393] = 19'h00000;
      mem[394] = 19'h00000;
      mem[395] = 19'h00000;
      mem[396] = 19'h00000;
      mem[397] = 19'h03381;
      mem[398] = 19'h00000;
      mem[399] = 19'h00000;
      mem[400] = 19'h00000;
      mem[401] = 19'h00000;
      mem[402] = 19'h00000;
      mem[403] = 19'h00000;
      mem[404] = 19'h00000;
      mem[405] = 19'h00000;
      mem[406] = 19'h00000;
      mem[407] = 19'h00000;
      mem[408] = 19'h18a6f;
      mem[409] = 19'h0a157;
      mem[410] = 19'h00000;
      mem[411] = 19'h1a3c7;
      mem[412] = 19'h00000;
      mem[413] = 19'h00000;
      mem[414] = 19'h00000;
      mem[415] = 19'h00000;
      mem[416] = 19'h0eb50;
      mem[417] = 19'h00000;
      mem[418] = 19'h00000;
      mem[419] = 19'h00000;
      mem[420] = 19'h63f50;
      mem[421] = 19'h13381;
      mem[422] = 19'h00000;
      mem[423] = 19'h00000;
      mem[424] = 19'h00000;
      mem[425] = 19'h00000;
      mem[426] = 19'h00000;
      mem[427] = 19'h00000;
      mem[428] = 19'h63c54;
      mem[429] = 19'h03381;
      mem[430] = 19'h00000;
      mem[431] = 19'h00000;
      mem[432] = 19'h00000;
      mem[433] = 19'h00000;
      mem[434] = 19'h00000;
      mem[435] = 19'h00000;
      mem[436] = 19'h00000;
      mem[437] = 19'h00000;
      mem[438] = 19'h00000;
      mem[439] = 19'h00000;
      mem[440] = 19'h18e6f;
      mem[441] = 19'h0a157;
      mem[442] = 19'h00000;
      mem[443] = 19'h1a3c7;
      mem[444] = 19'h00000;
      mem[445] = 19'h00000;
      mem[446] = 19'h00000;
      mem[447] = 19'h00000;
      mem[448] = 19'h00000;
      mem[449] = 19'h00000;
      mem[450] = 19'h00000;
      mem[451] = 19'h00000;
      mem[452] = 19'h1a710;
      mem[453] = 19'h13381;
      mem[454] = 19'h00000;
      mem[455] = 19'h00000;
      mem[456] = 19'h00000;
      mem[457] = 19'h00000;
      mem[458] = 19'h00000;
      mem[459] = 19'h00000;
      mem[460] = 19'h00000;
      mem[461] = 19'h03381;
      mem[462] = 19'h00000;
      mem[463] = 19'h00000;
      mem[464] = 19'h00000;
      mem[465] = 19'h00000;
      mem[466] = 19'h00000;
      mem[467] = 19'h00000;
      mem[468] = 19'h00000;
      mem[469] = 19'h00000;
      mem[470] = 19'h00000;
      mem[471] = 19'h00000;
      mem[472] = 19'h1826f;
      mem[473] = 19'h0a157;
      mem[474] = 19'h00000;
      mem[475] = 19'h1a3c7;
      mem[476] = 19'h00000;
      mem[477] = 19'h00000;
      mem[478] = 19'h00000;
      mem[479] = 19'h00000;
      mem[480] = 19'h00000;
      mem[481] = 19'h00000;
      mem[482] = 19'h00000;
      mem[483] = 19'h00000;
      mem[484] = 19'h5a710;
      mem[485] = 19'h13381;
      mem[486] = 19'h00000;
      mem[487] = 19'h00000;
      mem[488] = 19'h00000;
      mem[489] = 19'h00000;
      mem[490] = 19'h00000;
      mem[491] = 19'h00000;
      mem[492] = 19'h00000;
      mem[493] = 19'h03381;
      mem[494] = 19'h00000;
      mem[495] = 19'h00000;
      mem[496] = 19'h00000;
      mem[497] = 19'h00000;
      mem[498] = 19'h00000;
      mem[499] = 19'h00000;
      mem[500] = 19'h00000;
      mem[501] = 19'h00000;
      mem[502] = 19'h00000;
      mem[503] = 19'h00000;
      mem[504] = 19'h1866f;
      mem[505] = 19'h0a157;
      mem[506] = 19'h00000;
      mem[507] = 19'h1a3c7;
      mem[508] = 19'h00000;
      mem[509] = 19'h00000;
      mem[510] = 19'h00000;
      mem[511] = 19'h00000;
   end

always @(posedge i_clk)
   if (i_en)
      d <= mem[{i_imm30,i_funct3,i_opcode}];

   assign o_branch_op = d[0];
   assign o_rd_ctrl_sel = o_branch_op;
   assign o_slt_or_branch = d[1];
   assign o_alu_rd_sel1 = o_slt_or_branch;
   assign o_op_b_source = d[2];
   assign o_mem_cmd = o_op_b_source;
   assign o_immdec_ctrl0 = d[3];
   assign o_immdec_en0 = o_immdec_ctrl0;
   assign o_immdec_ctrl1 = d[4];
   assign o_bufreg_rs1_en = o_immdec_ctrl1;
   assign o_immdec_ctrl2 = d[5];
   assign o_cond_branch = o_immdec_ctrl2;
   assign o_immdec_ctrl3 = d[6];
   assign o_two_stage_op = o_immdec_ctrl3;
   assign o_immdec_en1 = d[7];
   assign o_immdec_en2 = d[8];
   assign o_immdec_en3 = d[9];
   assign o_bne_or_bge = d[10];
   assign o_rd_alu_sel = o_bne_or_bge;
   assign o_sh_right = d[11];
   assign o_alu_cmp_sig = o_sh_right;
   assign o_mem_half = o_sh_right;
   assign o_shift_op = d[12];
   assign o_ctrl_utype = o_shift_op;
   assign o_rd_op = d[13];
   assign o_dbus_en = d[14];
   assign o_alu_rd_sel0 = o_dbus_en;
   assign o_bufreg_imm_en = d[15];
   assign o_alu_rd_sel2 = o_bufreg_imm_en;
   assign o_bufreg_clr_lsb = d[16];
   assign o_ctrl_pc_rel = o_bufreg_clr_lsb;
   assign o_alu_sub = o_bufreg_clr_lsb;
   assign o_alu_bool_op1 = o_bufreg_clr_lsb;
   assign o_bufreg_sh_signed = d[17];
   assign o_alu_cmp_eq = o_bufreg_sh_signed;
   assign o_mem_signed = o_bufreg_sh_signed;
   assign o_alu_bool_op0 = d[18];
   assign o_mem_word = o_alu_bool_op0;

always @(posedge i_clk) begin
   if (i_en) begin
      //MDU/CSR/Ext
      o_mdu_op     <= MDU & (i_opcode == 5'b01100) & i_imm25;
      o_ext_funct3 <= MDU ? i_funct3 : 3'b000;
      o_ebreak         <= CSR & (i_op20);
      o_rd_csr_en      <= CSR & (i_opcode[4] & i_opcode[2] &  (|i_funct3));
      o_ctrl_mret      <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) &  i_op21);
      o_e_op           <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) & !i_op21);
      o_csr_en         <= CSR & (i_op20 | (i_op26 & !i_op21));
      o_csr_mstatus_en <= CSR & (!i_op26 & !i_op22);
      o_csr_mie_en     <= CSR & (!i_op26 &  i_op22 & !i_op20);
      o_csr_mcause_en  <= CSR & (         i_op21 & !i_op20);
      o_csr_source1    <= CSR & (i_funct3[1]);
      o_csr_source0    <= CSR & (i_funct3[0]);
      o_csr_d_sel      <= CSR & (i_funct3[2]);
      o_csr_imm_en     <= CSR & (i_opcode[4] & i_opcode[2] & i_funct3[2]);
      o_csr_addr1      <= CSR & (i_op26 & i_op20);
      o_csr_addr0      <= CSR & (!i_op26 | i_op21);
   end
end

endmodule
