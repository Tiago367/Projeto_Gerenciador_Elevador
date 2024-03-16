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
 input zeraT,
 input contaT,
 input clearAndarAtual,
 input clearSuperRam, 
 input enableAndarAtual,
 output chegouDestino,
 output bordaNovaEntrada,
 output fimT,
 output [3:0] proxParada,
 output [3:0] andarAtual
);
//Declaração de fios gerais 
wire [3:0] proxAndarD, proxAndarS ; // proximo andar caso suba e proximo andar caso desça

// Multiplexadores
wire [3:0] mux1, mux2;
assign mux1 = select1? origem : destino ; // fio que entra da "data_in" da ram
assign mux2 = select2? proxAndarS : proxAndarD ;

// Registradores 

registrador_4 andarAtual_reg (
    .clock      (clock),
    .clear      (clearAndarAtual),
    .enable     (enableAndarAtual),
    .D          (mux2),
    .Q          (andarAtual)
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
    .AGBo   (), 
    .AEBo   (chegouDestino)
);

// falta o clear dela
sync_ram_16x4_mod fila_ram(
    .clk    (clock),
    .we     (enableRAM),
    .data   (mux1),
    .addr   (4'b0000),
    .shift  (shift),
    .weT    (enableTopRAM),
    .q      (proxParada)
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

   
 
 endmodule
