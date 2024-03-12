module unidade_controle (
    input      clock,
    input      reset,
    input      iniciar,
    input reg  [3:0]proxParada, // saida da RAM da fila de paradas
    input      chegouDestino, // saida do comparador de andares
    input      novaEntrada, // BED do botao para passar as chaves
    input      [3:0]chaves,
    input       fimT, // timer do elevador normal

    // TERMINAR

    output reg [3:0]db_estado, // estado tem 5 bits, mas o quinto sai como led
    output reg dbQuintoBitEstado, // quinto bit do estado, sai em led
    output reg sobe,
    output reg proxParada,
    output     shift,
    output     enableRAM,
    output     enableTopRAM,
    output     contaT,
    output     zeraT,
    output     clearAndarAtual,
    output     clearSuperRam,
    output     select1,
    output     select2,
    



); // ultimo sem virgula

// variaveis internas da UC
reg [3:0] andarAtual, 
        andarDestino; // precisa??

reg [1:0] acaoElevador;  // 00 vazio, 01 subindo, 10 descendo, 11 parado

reg [4:0] Eatual, Eprox;

reg buscouPassageiro;

// estados da máquina de estados
// UNDERLINE para separar palavras somente aqui !!
parameter inicial              = 5'b00000; // 0
parameter inicializa_elementos = 5'b00001; // 1
parameter parado               = 5'b00010; // 2
parameter busca_passageiro     = 5'b00011; // 3
parameter leva_passageiro      = 5'b00100; // 4
parameter sobe_ou_desce        = 5'b00101; // 5
parameter descendo             = 5'b00110; // 6
parameter desce_andar          = 5'b00111; // 7
parameter subindo              = 5'b01000; // 8
parameter sobe_andar           = 5'b01001; // 9
parameter limpa_passageiro     = 5'b01010; // 10
parameter guarda_origem        = 5'b01011; // 11
parameter espera_destino       = 5'b01100; // 12
parameter guarda_destino       = 5'b01101; // 13
parameter shift_fila           = 5'b01110; // 14





// Transicao de estado todo clock
always @(posedge clock or posedge reset or posedge novaEntrada) begin
    if (reset)
        Eatual <= inicial;

    else if (novaEntrada)  // interrompe a transição usual de estados para cadastarar novo passageiro
        Eatual <= guarda_origem;

    // Futuramente o botao parar pode entrar aqui
    
    else
        Eatual <= Eprox;
end

// Logica de proximo estado (Moore)
always @* begin
    case (Eatual)

        // Transicao usual 
        inicial:             Eprox = iniciar? inicializaElementos : inicial;
        inicializaElementos: Eprox = parado;
        parado:              Eprox = (proxParada == 4'b0000)? parado : busca_passageiro;
        busca_passageiro:    Eprox = sobe_ou_desce
        sobe_ou_desce:       Eprox = (acaoElevador == 2'b01)? subindo : descendo; // futuramente botao parar poder entrar aqui 
        subindo:             Eprox = fimT? sobe_andar : (chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : subindo); 
        sobe_andar           Eprox = chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : subindo;
        descendo:            Eprox = fimT? desce_andar : (chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : descendo);
        desce_andar:         Eprox = chegouDestino? (buscouPassageiro? limpa_passageiro : shift_fila) : descendo;
        shift_fila:          Eprox = leva_passageiro;
        leva_passageiro      Eprox = sobe_ou_desce
        limpa_passageiro:    Eprox = (proxParada == 4'b0000)? parado : busca_passageiro;

        // Transicao de estado para cadastrar novo passageiro
        guarda_origem:       Eprox = espera_destino;
        espera_destino:      Eprox = novaEntrada? guarda_destino : espera_destino;
        guarda_destino:      Eprox = (acaoElevador == 2'b00)? parado : (acaoElevador == 2'b01)? subindo : descendo;

        default:             Eprox = inicial;
    endcase
end

    // Logica dos sinais de controle
    always @* begin
            
        inicial: begin
        end

        inicializaElementos: begin // completar
            clearAndarAtual = 1;
            clearSuperRam = 1;
            buscouPassageiro = 0;
            andarAtual = 1;
        end

        parado: begin
            we_andarAtual=0;
            clearAndarAtual = 0;
            clearSuperRam=0;
        end
        
        guarda_origem: begin
            select1 = 1;
            enableRAM = 1;
        end

        espera_destino: begin
            enableRAM = 0;
        end

        guarda_destino begin
            select1 = 0;
            enableRAM = 1;
        end

        busca_passageiro: begin
            // por enquanto esta inutil 
            // podemos tirar depois
        end

        sobe_ou_desce: begin // CHECAR SINTAXE
            if (proxParada > andarAtual) begin
                acaoElevador = 2'b01;
                select2 = 1;
            end
            else begin
                acaoElevador = 2'b10;
                select2 = 0;
            end
            
        end


        // nao aceitar andarOrigem = andarDestino

        dbEstado              = Eatual;
    end

endmodule