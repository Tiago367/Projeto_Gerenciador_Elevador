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
 input zeraT,
 input contaT,
 input clearAndarAtual,
 input clearSuperRam, 
 input enableAndarAtual,
 input enableRegOrigem,
 input enableRegDestino,
 input zeraAddrSecundario,
 input contaAddrSecundario,
 input reset,
 input fit,
 output chegouDestino,
 output bordaNovaEntrada,
 output fimT,
 output ramSecDifZero,
 output [3:0] proxParada,
 output [3:0] andarAtual, // alterei pro TB
 output sentidoElevador,
 output carona_origem,
 output carona_destino,
 output enableRegCaronaOrigem,
 output temDestino,
 output sobe
);
//Declaração de fios gerais 
wire [3:0] proxAndarD, proxAndarS ; // proximo andar caso suba e proximo andar caso desça
wire [3:0] saidaRegDestino, saidaRegOrigem, saidaSecundaria;
wire sentidoUsuario, elevadorSubindo, enderecoMaiorQueOrigem;
wire [3:0] saidaSecundariaAnterior, addrSecundarioAnterior;
wire objetivoMaiorAnterior, objetivoMenorAtual;
wire [3:0] addrSecundario, caronaOrigem;


// Multiplexadores
wire [3:0] mux1, mux2, mux3;
assign mux1 = select1? saidaRegOrigem : saidaRegDestino ; // fio que entra da "data_in" da ram
assign mux2 = select2? proxAndarS : proxAndarD ;
assign mux3 = select3? andarAtual : saidaSecundariaAnterior;
// Portas lógicas

assign mesmoSentido     = ~(sentidoElevador ^ sentidoUsuario);
assign carona_origem    = (mesmoSentido & objetivoMaiorAnterior & objetivoMenorAtual & ramSecDifZero);
assign carona_destino   = (objetivoMaiorAnterior & objetivoMenorAtual & ramSecDifZero & enderecoMaiorQueOrigem);
assign ramSecDifZero    = (saidaSecundaria[3] | saidaSecundaria[2] | saidaSecundaria[1] | saidaSecundaria[0]); 
assign temDestino       = (proxParada[0] | proxParada[1] | proxParada[2] | proxParada[3]);

// Registradores 

registrador_4 andarAtual_reg (
    .clock      (clock),
    .clear      (reset),
    .enable     (enableAndarAtual),
    .D          (mux2),
    .Q          (andarAtual) 
);

//Somador e subtrator do registrador do andar atual

assign addrSecundarioAnterior = addrSecundario - 1;
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
    .AGBo   (sobe), 
    .AEBo   (chegouDestino)
);

// falta o clear dela
sync_ram_16x4_mod fila_ram(
    .clk    (clock),
    .we     (enableRAM),
    .data   (mux1),
    .addrSecundario (addrSecundario), //valor para teste
    .addrSecundarioAnterior (addrSecundarioAnterior),
    .addr   (4'b0000),
    .shift  (shift),
    .weT    (enableTopRAM),
    .fit    (fit),
    .q      (proxParada),
    .saidaSecundaria (saidaSecundaria),
    .saidaSecundariaAnterior (saidaSecundariaAnterior)
);

edge_detector detectorDePedido(
    .clock  (clock),
    .reset  (reset),
    .sinal  (novaEntrada),
    .pulso  (bordaNovaEntrada)
);


contador_m #(2000,14) timer_2seg(
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
    .clear      (reset),
    .enable     (enableRegOrigem),
    .D          (origem),
    .Q          (saidaRegOrigem)
);

registrador_4 reg_destino(
    .clock     (clock),
    .clear     (reset),
    .enable    (enableRegDestino),
    .D         (destino),
    .Q         (saidaRegDestino)
);

registrador_4 reg_carona_origem(
    .clock     (clock),
    .clear     (reset),
    .enable    (enableRegCaronaOrigem),
    .D         (addrSecundario),
    .Q         (caronaOrigem)
);



comparador_85 sentido_usuario(
    .ALBi   (0),
    .AGBi   (0), 
    .AEBi   (1'b1), 
    .A      (saidaRegDestino), 
    .B      (saidaRegOrigem), 
    .ALBo   (), 
    .AGBo   (sentidoUsuario), 
    .AEBo   ()
);

comparador_85 sentido_elevador(
    .ALBi   (0),
    .AGBi   (0), 
    .AEBi   (1'b1), 
    .A      (saidaSecundaria), 
    .B      (saidaSecundariaAnterior), 
    .ALBo   (), 
    .AGBo   (sentidoElevador), 
    .AEBo   ()
);



comparador_85 verifica_se_maior(
    .ALBi   (0),
    .AGBi   (0), 
    .AEBi   (1'b1), 
    .A      (mux1), 
    .B      (mux3), 
    .ALBo   (), 
    .AGBo   (objetivoMaiorAnterior), 
    .AEBo   ()
);

comparador_85 verifica_se_menor(
    .ALBi   (0),
    .AGBi   (0), 
    .AEBi   (1'b1), 
    .A      (mux1), 
    .B      (saidaSecundaria), 
    .ALBo   (objetivoMenorAtual), 
    .AGBo   (), 
    .AEBo   ()
);

comparador_85 verifica_se_endereco_maior_que_origem(
    .ALBi   (0),
    .AGBi   (0), 
    .AEBi   (1'b1), 
    .A      (addrSecundario), 
    .B      (caronaOrigem), 
    .ALBo   (), 
    .AGBo   (enderecoMaiorQueOrigem), 
    .AEBo   ()
);

contador_p endereco_secundario(
    .clock      (clock),
    .zera_as    (),
    .zera_s     (zeraAddrSecundario),
    .conta      (contaAddrSecundario),
    .Q          (addrSecundario),
    .fim        (),
    .meio       ()
);




 endmodule
