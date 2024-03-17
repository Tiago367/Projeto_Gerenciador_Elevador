// Modulo do fluxo de dados para o projeto "Gerenciador de Elevadores"
module FD (
 input clock,
 input [3:0] origem,
 input [3:0] destino,
 input novaEntrada,
 input shift,
 input enableRAM,
 input enableTopRAM,
 input select1,
 input select2,
 input select3,
 input select4,
 input zeraT,
 input contaT,
 input clearAndarAtual,
 input clearSuperRam, 
 input enableAndarAtual,
 input enableRegOrigem,
 input enableRegDestino,
 output chegouDestino,
 output bordaNovaEntrada,
 output fimT,
 output [3:0] proxParada,
 input [3:0] andarAtual, // alterei pro TB
 output elevador_subindo
);
//Declaração de fios gerais 
wire [3:0] proxAndarD, proxAndarS ; // proximo andar caso suba e proximo andar caso desça
wire [3:0] saidaRegDestino, saidaRegOrigem;
wire usuario_subindo, elevadorSubindo;
wire [3:0]saidaSecundaria;
wire proxAndarMaior, saidaSecMaior;


// Multiplexadores
wire [3:0] mux1, mux2, mux3, mux4;
assign mux1 = select1? origem : destino ; // fio que entra da "data_in" da ram
assign mux2 = select2? proxAndarS : proxAndarD ;
assign mux3 = select3? saidaRegOrigem : saidaRegDestino;
assign mux4 = select4? andarAtual : proxParada;

assign mesmoSentido = (usuario_subindo & elevador_subindo) | (~usuario_subindo & ~elevador_subindo);
assign carona = mesmoSentido & (proxAndarMaior ^ saidaSecMaior);

// Registradores 

registrador_4 andarAtual_reg (
    .clock      (clock),
    .clear      (clearAndarAtual),
    .enable     (enableAndarAtual),
    .D          (mux2),
    .Q          () //Modificação para TB
);

//Somador e subtrator do registrador do andar atual

assign proxAndarD = andarAtual - 1;
assign proxAndarS = andarAtual + 1;

// Comparadores

comparador_85 destino_comp(
    .ALBi   (),
    .AGBi   (), 
    .AEBi   (1'b1), 
    .A      (proxParada), 
    .B      (andarAtual), 
    .ALBo   (), 
    .AGBo   (elevador_subindo), 
    .AEBo   (chegouDestino)
);

// falta o clear dela
sync_ram_16x4_mod fila_ram(
    .clk    (clock),
    .we     (enableRAM),
    .data   (mux1),
    .addrSecundario (4'b0001), //valor para teste
    .addr   (4'b0000),
    .shift  (shift),
    .weT    (enableTopRAM),
    .q      (proxParada),
    .saidaSecundaria (saidaSecundaria)
);

edge_detector detectorDePedido(
    .clock  (clock),
    .reset  (),
    .sinal  (novaEntrada),
    .pulso  (bordaNovaEntrada)
);

// tive que tirar o #(x,y) para compilar
contador_m timer_2seg(
    .clock      (clock),
    .zera_as    (),
    .zera_s     (zeraT),
    .conta      (contaT),
    .Q          (),
    .fim        (fimT),
    .meio       ()
);

registrador_4 reg_origem(
    .clock      (clock),
    .clear      (),
    .enable     (enableRegOrigem),
    .D          (origem),
    .Q          (saidaRegOrigem)
);

registrador_4 reg_destino(
    .clock     (clock),
    .clear     (),
    .enable    (enableRegDestino),
    .D         (destino),
    .Q         (saidaRegDestino)
);

comparador_85 sentido_usuario(
    .ALBi   (),
    .AGBi   (), 
    .AEBi   (1'b1), 
    .A      (saidaRegDestino), 
    .B      (saidaRegOrigem), 
    .ALBo   (), 
    .AGBo   (usuario_subindo), 
    .AEBo   ()
);

comparador_85 compara_entrada_proxAndar(
    .ALBi   (),
    .AGBi   (), 
    .AEBi   (1'b1), 
    .A      (mux4), 
    .B      (mux3), 
    .ALBo   (), 
    .AGBo   (proxAndarMaior), 
    .AEBo   ()
);

comparador_85 compara_entrada_saidasecundaria(
    .ALBi   (),
    .AGBi   (), 
    .AEBi   (1'b1), 
    .A      (saidaSecundaria), 
    .B      (mux3), 
    .ALBo   (), 
    .AGBo   (saidaSecMaior), 
    .AEBo   ()
);
 
 endmodule
