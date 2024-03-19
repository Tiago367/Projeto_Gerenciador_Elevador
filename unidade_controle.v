module unidade_controle (
    input       clock,
    input       reset,
    input       iniciar, 
    input       chegouDestino, 
    input       fimT,
    input       temDestino,
    input       sobe,  
    output reg  dbQuintoBitEstado, 
    output reg  shift,
    output reg  enableRAM,
    output reg  contaT,
    output reg  zeraT,
    output reg  clearAndarAtual,
    output reg  clearSuperRam,
    output reg  select2,
    output reg  enableAndarAtual



);

// variaveis internas da UC

reg [1:0] acaoElevador;  // 00 vazio, 01 subindo, 10 descendo, 11 parado

reg [4:0] Eatual, Eprox;

reg buscouPassageiro;

// estados da máquina de estados
// UNDERLINE para separar palavras somente aqui !!
parameter inicial               = 5'b00000; // 0
parameter inicializa_elementos  = 5'b00001; // 1
parameter prox_pedido           = 5'b00010; // 2
parameter subindo               = 5'b00011; // 3 INUTIL ATE AGORA
parameter descendo              = 5'b00100; // 4
parameter registra_subindo        = 5'b00101; // 5
parameter checa                 = 5'b00110; // 6
parameter shift_fila            = 5'b00111; // 7
parameter aguarda_passageiro    = 5'b01000; // 8
parameter registra_descendo     = 5'b01001; // 9




initial Eatual = inicial;

// Transicao de estado todo clock
always @(posedge clock or posedge reset) begin
    if (reset)
        Eatual <= inicial;
    
    else
        Eatual <= Eprox;
end

// Logica de proximo estado (Moore)
always @* begin
    case (Eatual)

        // Transicao usual 
        inicial:                    Eprox = iniciar? inicializa_elementos : inicial;
        inicializa_elementos:       Eprox = prox_pedido;
        prox_pedido:                Eprox = temDestino? (sobe? subindo : descendo) : prox_pedido;
        subindo:                    Eprox = fimT? registra_subindo : subindo;
        descendo:                   Eprox = fimT? registra_descendo : descendo;
        checa:                      Eprox = chegouDestino ? shift_fila : sobe? subindo : descendo;
        registra_subindo:           Eprox = checa;
        registra_descendo:          Eprox = checa;
        shift_fila:                 Eprox = aguarda_passageiro; 
        aguarda_passageiro:         Eprox = fimT? prox_pedido : aguarda_passageiro;

        default:                    Eprox = inicial;
    endcase
end

    // Logica dos sinais de controle
    always @* begin

        shift               = (Eatual == shift_fila);

        contaT              = ((Eatual == descendo) || (Eatual == subindo) || (Eatual == aguarda_passageiro));
        zeraT               = ((Eatual == prox_pedido) || (Eatual == shift_fila));

        select2             = (Eatual == registra_subindo);
        enableAndarAtual    = ((Eatual == registra_subindo) || (Eatual == registra_descendo));
    end

endmodule