module circuito_final(
    input iniciar,
    input clock,
    input [3:0]origem,
    input [3:0]destino,
    input novaEntrada,
    input reset,
    output dbQuintoBitEstado

);

wire enableAndarAtual, shift, enableRAM, enableTopRAM, select1, select2, select3, select4, chegouDestino; 
wire bordaNovaEntrada, fimT, contaT, zeraT, clearAndarAtual, clearSuperRam, carona, finalRam, enableRegOrigem;
wire enableRegDestino, contaAddrSecundario, zeraAddrSecundario, elevador_subindo;
wire [3:0] proxParada, andarAtual, saidaSecundaria;




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
.select3            (select3),
.select4            (select4),
.chegouDestino      (chegouDestino), // chegou no andar
.bordaNovaEntrada   (bordaNovaEntrada), // borda do pronto
.proxParada         (proxParada), // saida da ram com o prox destino
.andarAtual         (andarAtual), // andar atual e entra no comparador
.fimT               (fimT), //passou dois segundou 
.contaT             (contaT),
.zeraT              (zeraT),
.clearAndarAtual    (clearAndarAtual),
.clearSuperRam      (clearSuperRam),
.finalRam           (finalRam),
.saidaSecundaria    (saidaSecundaria),
.enableRegDestino   (enableRegDestino),
.enableRegOrigem    (enableRegOrigem),
.contaAddrSecundario (contaAddrSecundario),
.zeraAddrSecundario (zeraAddrSecundario),
.carona             (carona),
.elevador_subindo   (elevador_subindo)
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
.clock             (clock),
.carona            (carona),
.saidaSecundaria   (saidaSecundaria),
.select4           (select4),
.enableRegOrigem   (enableRegOrigem),
.enableRegDestino  (enableRegDestino),
.contaAddrSecundario (contaAddrSecundario),
.zeraAddrSecundario (zeraAddrSecundario)
);








endmodule