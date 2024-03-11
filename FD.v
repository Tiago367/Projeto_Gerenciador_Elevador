// Modulo do fluxo de dados para o projeto "Gerenciador de Glevadores"
module FD (
 input clock,
 input [3:0] origem,
 input [3:0] destino,
 input pronto,
 input we_andarAtual,
 input shift_ram,
 input we_ram,
 input weT_ram,
 input select1,
 input select2,
 output parar,
 output pronto_borda,
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
    .clear      (),
    .enable     (we_andarAtual),
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
    .AEBo   (parar)
);

sync_ram_16x4_mod fila_ram(
    .clk    (clock),
    .we     (we_ram),
    .data   (mux1),
    .addr   (4'b0000),
    .shift  (shift_ram),
    .weT    (weT_ram),
    .q      (proxParada)
);

edge_detector detectorDePedido(
    .clock  (clock),
    .reset  (),
    .sinal  (pronto),
    .pulso  (pronto_borda)
);


   
 
 endmodule
