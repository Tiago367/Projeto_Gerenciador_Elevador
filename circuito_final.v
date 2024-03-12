module gerenciadorDeElevador(
    input iniciar,
    input [3:0]entrada,
    input clock
);




FD fluxodeDados (
.clock          (clock),
.origem         (origem), 
.destino        (destino),
.novaEntrada    (novaEntrada), // usuário envia a entrada
.we_andarAtual  (we_andarAtual), // enable da ram estado atual
.shift          (shift), //shift ram
.enableRAM      (enableRAM), // enable ram destinos
.enableTopRAM   (enableTopRAM), // enable top ram destinos
.select1        (select1), // seleciona a origem ou destino
.select2        (select2), // seleciona andar pra cima ou pra baixo
.chegouDestino  (chegouDestino), // chegou no andar
.prontoBorda    (prontoBorda), // borda do pronto
.proxParada     (proxParada), // saida da ram com o prox destino
.andarAtual     (andarAtual), // andar atual e entra no comparador
.avanca         (avanca), //passou dois segundou 
.contaT         (contaT),
.zeraT          (zeraT)
);


unidade_controle UC (
 (clock),
 (reset),
 (iniciar),
 (proxParada), // saida da RAM da fila de paradas
 (chegouDestino), // saida do comparador de andares
 (novaEntrada), // BED do botao para passar as chaves
 (chaves), // não entendi 
 (fimT), // relacionado com o avanca?
 (db_estado), // estado tem 5 bits, mas o quinto sai como led
 (dbQuintoBitEstado), // quinto bit do estado, sai em led
 sobe,
 proxParada,
 shift,
 enableRAM,
 enableTopRAM,
 contaT,
 zeraT,









endmodule