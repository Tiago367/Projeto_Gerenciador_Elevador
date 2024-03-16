module unidade_controle (
    input      clock,
    input      reset,
    input      iniciar,
    input      [3:0]proxParada, // saida da RAM da fila de paradas tirei tirei o reg do input
    input      chegouDestino, // saida do comparador de andares
    input       fimT, // timer do elevador normal
    input [3:0]andarAtual,

    // TERMINAR

    //output reg [3:0]db_estado, // estado tem 5 bits, mas o quinto sai como led
    output reg dbQuintoBitEstado, // quinto bit do estado, sai em led
    //output reg sobe,
    //output reg proxParada, não entendi
    output reg  shift,
    output reg  enableRAM,
    output reg  contaT,
    output reg  zeraT,
    output reg  clearAndarAtual,
    output reg  clearSuperRam,
    output reg  select2,
    output reg  enableAndarAtual



); // ultimo sem virgula

// variaveis internas da UC

reg [1:0] acaoElevador;  // 00 vazio, 01 subindo, 10 descendo, 11 parado

reg [4:0] Eatual, Eprox;

reg buscouPassageiro;

// estados da máquina de estados
// UNDERLINE para separar palavras somente aqui !!
parameter inicial              = 5'b00000; // 0
parameter inicializa_elementos = 5'b00001; // 1
parameter parado               = 5'b00010; // 2
parameter busca_passageiro     = 5'b00011; // 3 INUTIL ATE AGORA
parameter leva_passageiro      = 5'b00100; // 4
parameter sobe_ou_desce        = 5'b00101; // 5
parameter descendo             = 5'b00110; // 6
parameter desce_andar          = 5'b00111; // 7
parameter subindo              = 5'b01000; // 8
parameter sobe_andar           = 5'b01001; // 9
parameter limpa_passageiro     = 5'b01010; // 10
parameter guarda_destino        = 5'b01011; // 11
parameter espera_destino       = 5'b01100; // 12
parameter guarda_origem       = 5'b01101; // 13
parameter shift_fila           = 5'b01110; // 14





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
        inicial:             Eprox = iniciar? inicializa_elementos : inicial;
        inicializa_elementos: Eprox = parado;
        parado:              Eprox = (proxParada == 4'b0000)? parado : busca_passageiro;
        busca_passageiro:    Eprox = sobe_ou_desce;
        sobe_ou_desce:       Eprox = (acaoElevador == 2'b01)? subindo : descendo; // futuramente botao parar poder entrar aqui 
        subindo:             Eprox = fimT? sobe_andar : (chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : subindo); 
        sobe_andar:          Eprox = chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : subindo;
        descendo:            Eprox = fimT? desce_andar : (chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : descendo);
        desce_andar:         Eprox = chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : descendo;
        shift_fila:          Eprox = leva_passageiro;
        leva_passageiro:      Eprox = sobe_ou_desce;
        limpa_passageiro:    Eprox =  parado;

        default:             Eprox = inicial;
    endcase
end

    // Logica dos sinais de controle
    always @* begin
        case (Eatual)

            inicial: begin
            end

            inicializa_elementos: begin 
                clearAndarAtual = 1;
                clearSuperRam = 1;
                buscouPassageiro = 0;
                zeraT = 1;
            end

            parado: begin
                zeraT=0;
                enableAndarAtual=0;
                clearAndarAtual = 0;
                clearSuperRam=0;
                acaoElevador = 2'b00;
                contaT=0;
            end

            sobe_ou_desce: begin 
                if (proxParada > andarAtual) begin
                    acaoElevador = 2'b01;
                end
                else begin
                    acaoElevador = 2'b10;
                end
            end

            subindo: begin
                contaT=1;
                enableAndarAtual = 0;
                select2=1;
                zeraT = 0;
            end    

            sobe_andar: begin
                select2=1;
                enableAndarAtual = 1;
                zeraT=1;
                contaT=0;
            end

            shift_fila: begin
                shift=1;
                zeraT = 0;
            end

            leva_passageiro: begin
                shift=0;
                buscouPassageiro=1;
            end

            limpa_passageiro: begin
                shift=1;
                buscouPassageiro=0;
            end

            descendo: begin
                enableAndarAtual = 0;
                contaT=1;
                select2=0;
            end

            desce_andar: begin
                select2=0;
                enableAndarAtual = 1;
                zeraT=1;
                contaT=0;
            end
            
        endcase
    end

endmodule