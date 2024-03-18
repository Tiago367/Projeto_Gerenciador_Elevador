module uc_novajogada(
    input bordaNovaEntrada,
    input clock,
    input iniciar,
    input reset,
    input carona,
    input [3:0]saidaSecundaria,
    output reg select1,
    output reg enableTopRAM,
    output reg select4,
    output reg enableRegDestino,
    output reg enableRegOrigem,
    output reg contaAddrSecundario,
    output reg zeraAddrSecundario
);

reg [2:0] Eatual, Eprox;

parameter inicial        = 3'b000;
parameter inicializa     = 3'b001;
parameter registra_jogada = 3'b010;
parameter encontra_posicao_origem = 3'b011;
parameter atualiza_parametros = 3'b100;
parameter armazena_origem = 3'b101;
parameter espera_jogada = 3'b110;


always @(posedge clock or posedge reset or posedge bordaNovaEntrada) begin
    if (reset)
        Eatual <= inicial;
    
    else
        Eatual <= Eprox;
end


always @* begin
    case (Eatual)

        inicial:                  Eprox = iniciar? inicializa : inicial;
        inicializa:               Eprox = espera_jogada;
        espera_jogada:            Eprox = bordaNovaEntrada? registra_jogada : espera_jogada;
        registra_jogada:          Eprox = encontra_posicao_origem;
        encontra_posicao_origem:  Eprox = (saidaSecundaria == 4'b0000)? armazena_origem : (carona)? armazena_origem : atualiza_parametros;
        atualiza_parametros:      Eprox = encontra_posicao_origem;
        armazena_origem:           Eprox = espera_jogada;
        default:             Eprox = inicializa;
    endcase
end

always @* begin
    case (Eatual)

    inicializa: begin
        zeraAddrSecundario=1;
        contaAddrSecundario=0;
    end

    espera_jogada: begin     
        zeraAddrSecundario=0;  
    end

    registra_jogada: begin
        enableRegOrigem=1;
        enableRegDestino=1;
        select1=1;
        select4=1;
    end

    encontra_posicao_origem: begin
        contaAddrSecundario = 1;
        contaAddrSecundario=0;
    end

    atualiza_parametros: begin
        select4=0;
        contaAddrSecundario=1;
    end

    armazena_origem: begin
    end

    endcase
end


endmodule