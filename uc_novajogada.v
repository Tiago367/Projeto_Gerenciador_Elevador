module uc_novajogada(
    input bordaNovaEntrada,
    input clock,
    input iniciar,
    input reset,
    output reg select1,
    output reg enableTopRAM
    
);

reg [2:0] Eatual, Eprox;

parameter inicial        = 3'b000;
parameter inicializa     = 3'b001;
parameter guarda_origem  = 3'b010;
parameter espera_destino = 3'b011;
parameter guarda_destino = 3'b100;
parameter espera_origem  = 3'b101;



always @(posedge clock or posedge reset or posedge bordaNovaEntrada) begin
    if (reset)
        Eatual <= inicial;
    
    else
        Eatual <= Eprox;
end


always @* begin
    case (Eatual)

        inicial:         Eprox = iniciar? inicializa : inicial;
        inicializa:      Eprox = espera_origem;
        espera_origem:   Eprox = bordaNovaEntrada? guarda_origem : espera_origem;
        guarda_origem:   Eprox = espera_destino;
        espera_destino:  Eprox = guarda_destino;
        guarda_destino:   Eprox = espera_origem;  

        default:             Eprox = inicializa;
    endcase
end

always @* begin
    case (Eatual)

    inicializa: begin
        enableTopRAM = 0;
    end

    espera_origem: begin
        enableTopRAM = 0;
    end

    guarda_origem: begin
        select1 = 1;
        enableTopRAM = 1;
    end

    espera_destino: begin
        enableTopRAM = 0; 
    end

    guarda_destino: begin
        select1 = 0;
        enableTopRAM = 1;
    end

    endcase
end


endmodule