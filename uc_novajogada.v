module uc_novajogada(
    input bordaNovaEntrada,
    input clock,
    input iniciar,
    input reset,
    input carona_origem,
    input carona_destino,
    input ramSecDifZero,
    output reg select1,
    output reg enableTopRAM,
    output reg fit,
    output reg select3,
    output reg enableRegDestino,
    output reg enableRegOrigem,
    output reg enableRegCaronaOrigem,
    output reg contaAddrSecundario,
    output reg zeraAddrSecundario
);

reg [3:0] Eatual, Eprox;



parameter espera_jogada             = 4'b0000; // 0
parameter registra_jogada           = 4'b0001; // 1
parameter compara_primeiro_origem   = 4'b0010; // 2
parameter compara_origem            = 4'b0011; // 3
parameter proximo_origem            = 4'b0100; // 4
parameter encaixa_origem            = 4'b0101; // 5
parameter escreve_topo_origem       = 4'b0110; // 6
parameter escreve_topo_destino      = 4'b0111; // 7
parameter prepara_destino           = 4'b1000; // 8
parameter pula                      = 4'b1001; // 9
parameter proximo_destino           = 4'b1010; // A
parameter compara_destino           = 4'b1011; // B 
parameter encaixa_destino           = 4'b1100; // C


initial Eatual = espera_jogada;

always @(posedge clock or posedge reset) begin
    if (reset)
        Eatual <= espera_jogada;
    
    else
        Eatual <= Eprox;
end

    // Transição de Estados
always @* begin
    case (Eatual)

        espera_jogada:              Eprox = bordaNovaEntrada? registra_jogada : espera_jogada;
        registra_jogada:            Eprox = compara_primeiro_origem;
        compara_primeiro_origem:    Eprox = carona_origem? encaixa_origem : proximo_origem;
        compara_origem:             Eprox = carona_origem? encaixa_origem : proximo_origem;
        proximo_origem:             Eprox = ramSecDifZero? compara_origem : escreve_topo_origem;
        encaixa_origem:             Eprox = prepara_destino;
        escreve_topo_origem:        Eprox = escreve_topo_destino;
        escreve_topo_destino:       Eprox = espera_jogada;
        prepara_destino:            Eprox = pula;
        pula:                       Eprox = proximo_destino;
        proximo_destino:            Eprox = ramSecDifZero? compara_destino : escreve_topo_destino;
        compara_destino:            Eprox = carona_destino? encaixa_destino : proximo_destino;
        encaixa_destino:            Eprox = espera_jogada;
        default:                    Eprox = espera_jogada;
    endcase
end
    // Atribuições sinais de saída
always @* begin

    // Contador
    zeraAddrSecundario      = ((Eatual == registra_jogada) || (Eatual == prepara_destino));
    contaAddrSecundario     = ((Eatual == proximo_destino) || (Eatual == proximo_origem));

    // RAM
    enableTopRAM            = ((Eatual == escreve_topo_destino) || (Eatual == escreve_topo_origem));
    fit                     = ((Eatual == encaixa_origem) || (Eatual == encaixa_destino));

    // Loads
    enableRegDestino        = (Eatual == registra_jogada);
    enableRegOrigem         = (Eatual == registra_jogada);
    enableRegCaronaOrigem   = (Eatual == encaixa_origem);

    // Muxs
    select3                 = (Eatual == registra_jogada);
    select1                 = ((Eatual == registra_jogada) || (Eatual == compara_origem) || (Eatual == compara_primeiro_origem) || (Eatual == proximo_origem) || (Eatual == encaixa_origem) || (Eatual == escreve_topo_origem) );

end


endmodule