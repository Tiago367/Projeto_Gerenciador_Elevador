onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 28 {Circuito Geral}
add wave -noupdate -height 30 /tb_circuito/iniciar
add wave -noupdate -height 30 /tb_circuito/clock
add wave -noupdate -height 30 /tb_circuito/reset
add wave -noupdate -height 30 /tb_circuito/origem
add wave -noupdate -height 30 /tb_circuito/destino
add wave -noupdate -divider FD
add wave -noupdate -height 30 -label {saida secundaria} /tb_circuito/uut/fluxodeDados/saidaSecundaria
add wave -noupdate -height 30 -label {carona destino} /tb_circuito/uut/fluxodeDados/carona_destino
add wave -noupdate -height 30 -label {carona origem} /tb_circuito/uut/fluxodeDados/carona_origem
add wave -noupdate -height 30 /tb_circuito/uut/fluxodeDados/enderecoMaiorQueOrigem
add wave -noupdate -height 30 /tb_circuito/uut/fluxodeDados/sentidoUsuario
add wave -noupdate -height 30 -label {saida ram dif de 0} /tb_circuito/uut/fluxodeDados/ramSecDifZero
add wave -noupdate -height 30 -label {endereço secundario} /tb_circuito/uut/fluxodeDados/addrSecundario
add wave -noupdate -height 30 -label {sentido elevador} /tb_circuito/uut/fluxodeDados/sentidoElevador
add wave -noupdate -height 30 -label {Objetivo maior} /tb_circuito/uut/fluxodeDados/objetivoMaiorAnterior
add wave -noupdate -height 30 -label {Objetivo menor} /tb_circuito/uut/fluxodeDados/objetivoMenorAtual
add wave -noupdate -height 30 -label mux1 /tb_circuito/uut/fluxodeDados/mux1
add wave -noupdate -height 30 -label {reg origem} /tb_circuito/uut/fluxodeDados/saidaRegOrigem
add wave -noupdate -height 30 -label {reg destino} /tb_circuito/uut/fluxodeDados/saidaRegDestino
add wave -noupdate -divider {UC jogada}
add wave -noupdate -height 30 -label Estado /tb_circuito/uut/UC_NOVAJOGADA/Eatual
add wave -noupdate -height 30 -label fit /tb_circuito/uut/UC_NOVAJOGADA/fit
add wave -noupdate -height 30 -label {select 1} /tb_circuito/uut/UC_NOVAJOGADA/select1
add wave -noupdate -height 30 -label {select 3} /tb_circuito/uut/UC_NOVAJOGADA/select3
add wave -noupdate -height 30 -label conta /tb_circuito/uut/UC_NOVAJOGADA/contaAddrSecundario
add wave -noupdate -height 30 -label zera /tb_circuito/uut/UC_NOVAJOGADA/zeraAddrSecundario
add wave -noupdate -height 30 -label {we reg carona} /tb_circuito/uut/UC_NOVAJOGADA/enableRegCaronaOrigem
add wave -noupdate -height 30 -label {we reg origem} /tb_circuito/uut/UC_NOVAJOGADA/enableRegOrigem
add wave -noupdate -height 30 -label {we reg destino} /tb_circuito/uut/UC_NOVAJOGADA/enableRegDestino
add wave -noupdate -divider RAM
add wave -noupdate -height 30 -label {ram 0} {/tb_circuito/uut/fluxodeDados/fila_ram/ram[0]}
add wave -noupdate -height 30 -label {ram 1} {/tb_circuito/uut/fluxodeDados/fila_ram/ram[1]}
add wave -noupdate -height 30 -label {ram 2} {/tb_circuito/uut/fluxodeDados/fila_ram/ram[2]}
add wave -noupdate -height 30 -label {ram 3} {/tb_circuito/uut/fluxodeDados/fila_ram/ram[3]}
add wave -noupdate -height 30 -label {ram 4} {/tb_circuito/uut/fluxodeDados/fila_ram/ram[4]}
add wave -noupdate /tb_circuito/uut/fluxodeDados/andarAtual
add wave -noupdate /tb_circuito/uut/fluxodeDados/chegouDestino
add wave -noupdate /tb_circuito/uut/fluxodeDados/shift
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {234 us} 0}
quietly wave cursor active 1
configure wave -namecolwidth 307
configure wave -valuecolwidth 65
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 us} {1427 us}
