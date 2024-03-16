module circuito_final(
    input iniciar,
    input clock,
    input [3:0]origem,
    input [3:0]destino,
    input novaEntrada,
    input reset,
    output dbQuintoBitEstado

);

wire enableAndarAtual, shift, enableRAM, enableTopRAM, select1, select2, chegouDestino; 
wire bordaNovaEntrada, fimT, contaT, zeraT, clearAndarAtual, clearSuperRam;
wire [3:0] proxParada, andarAtual;




FD fluxodeDados (
.clock              (clock),
.origem             (origem), 
.destino            (destino),
.novaEntrada        (novaEntrada), // sinal que diz quando tem jogada nova
.enableAndarAtual   (enableAndarAtual), // enable da ram estado atual
.shift              (shift), //shift ram
.enableRAM          (enableRAM), // enable ram destinos
.enableTopRAM       (enableTopRAM), // enable top ram destinos
.select1            (select1), // seleciona a origem ou destino
.select2            (select2), // seleciona andar pra cima ou pra baixo
.chegouDestino      (chegouDestino), // chegou no andar
.bordaNovaEntrada   (bordaNovaEntrada), // borda do pronto
.proxParada         (proxParada), // saida da ram com o prox destino
.andarAtual         (andarAtual), // andar atual e entra no comparador
.fimT               (fimT), //passou dois segundou 
.contaT             (contaT),
.zeraT              (zeraT),
.clearAndarAtual    (clearAndarAtual),
.clearSuperRam      (clearSuperRam)
);


unidade_controle UC (
.clock              (clock),
.reset              (reset),
.iniciar            (iniciar),
.proxParada         (proxParada),// saida da RAM da fila de paradas
.chegouDestino      (chegouDestino),// saida do comparador de andares
.fimT               (fimT),// timer do elevador normal
.shift              (shift),
.enableRAM          (enableRAM),
.contaT             (contaT),
.zeraT              (zeraT),
.clearAndarAtual    (clearAndarAtual),
.clearSuperRam      (clearSuperRam),
.select2            (select2),
.enableAndarAtual   (enableAndarAtual),
.dbQuintoBitEstado  (dbQuintoBitEstado),// quinto bit do estado sai em led
.andarAtual         (andarAtual)
);


uc_novajogada UC_NOVAJOGADA (
.bordaNovaEntrada  (bordaNovaEntrada),
.select1           (select1),
.enableTopRAM      (enableTopRAM),
.iniciar           (iniciar),
.reset             (reset),
.clock             (clock)
);








endmodule