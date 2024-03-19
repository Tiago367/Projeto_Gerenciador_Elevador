module circuito_final(
    input iniciar,
    input clock,
    input [3:0]origem,
    input [3:0]destino,
    input novaEntrada,
    input reset,
    output dbQuintoBitEstado

);

wire enableAndarAtual, shift, enableRAM, enableTopRAM, select1, select2, select3, chegouDestino, fit, temDestino, sobe; 
wire bordaNovaEntrada, fimT, contaT, zeraT, clearAndarAtual, clearSuperRam, carona_origem, finalRam, enableRegOrigem;
wire enableRegDestino, contaAddrSecundario, zeraAddrSecundario, sentidoElevador, ramSecDifZero;
wire [3:0] proxParada, andarAtual;




FD fluxodeDados (
.clock                      (clock),
.origem                     (origem), 
.destino                    (destino),
.novaEntrada                (novaEntrada), // sinal que diz quando tem jogada nova
.enableAndarAtual           (enableAndarAtual), // enable da ram estado atual
.shift                      (shift), //shift ram
.fit                        (fit),
.enableRAM                  (enableRAM), // enable ram destinos
.enableTopRAM               (enableTopRAM), // enable top ram destinos
.select1                    (select1), // seleciona a origem ou destino
.select2                    (select2), // seleciona andar pra cima ou pra baixo
.select3                    (select3),
.chegouDestino              (chegouDestino), // chegou no andar
.bordaNovaEntrada           (bordaNovaEntrada), // borda do pronto
.proxParada                 (proxParada), // saida da ram com o prox destino
.andarAtual                 (andarAtual), // andar atual e entra no comparador
.fimT                       (fimT), //passou dois segundou 
.contaT                     (contaT),
.zeraT                      (zeraT),
.clearAndarAtual            (clearAndarAtual),
.clearSuperRam              (clearSuperRam),
.ramSecDifZero              (ramSecDifZero),
.enableRegDestino           (enableRegDestino),
.enableRegOrigem            (enableRegOrigem),
.enableRegCaronaOrigem      (enableRegCaronaOrigem),
.contaAddrSecundario        (contaAddrSecundario),
.zeraAddrSecundario         (zeraAddrSecundario),
.carona_origem              (carona_origem),
.carona_destino             (carona_destino),
.sentidoElevador            (sentidoElevador),
.reset                      (reset),
.temDestino                 (temDestino),
.sobe                       (sobe)
);


unidade_controle UC (
.clock                      (clock),
.reset                      (reset),
.iniciar                    (iniciar),
.chegouDestino              (chegouDestino),// saida do comparador de andares
.fimT                       (fimT),// timer do elevador normal
.shift                      (shift),
.enableRAM                  (enableRAM),
.contaT                     (contaT),
.zeraT                      (zeraT),
.clearAndarAtual            (clearAndarAtual),
.clearSuperRam              (clearSuperRam),
.select2                    (select2),
.enableAndarAtual           (enableAndarAtual),
.dbQuintoBitEstado          (dbQuintoBitEstado),// quinto bit do estado sai em led
.sobe                       (sobe),
.temDestino                 (temDestino)
);


uc_novajogada UC_NOVAJOGADA (
.bordaNovaEntrada           (bordaNovaEntrada),
.select1                    (select1),
.enableTopRAM               (enableTopRAM),
.fit                        (fit),
.iniciar                    (iniciar),
.reset                      (reset),
.clock                      (clock),
.carona_origem              (carona_origem),
.carona_destino             (carona_destino),
.ramSecDifZero              (ramSecDifZero),
.select3                    (select3),
.enableRegOrigem            (enableRegOrigem),
.enableRegDestino           (enableRegDestino),
.enableRegCaronaOrigem      (enableRegCaronaOrigem),
.contaAddrSecundario        (contaAddrSecundario),
.zeraAddrSecundario         (zeraAddrSecundario)
);








endmodule