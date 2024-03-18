onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_circuito/clock
add wave -noupdate /tb_circuito/origem
add wave -noupdate /tb_circuito/iniciar
add wave -noupdate /tb_circuito/uut/UC/Eatual
add wave -noupdate /tb_circuito/uut/fluxodeDados/proxParada
add wave -noupdate /tb_circuito/uut/fluxodeDados/andarAtual
add wave -noupdate /tb_circuito/uut/fluxodeDados/chegouDestino
add wave -noupdate /tb_circuito/uut/fluxodeDados/mux1
add wave -noupdate -divider -height 30 {UC NOVA}
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/Eatual
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/enableTopRAM
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/bordaNovaEntrada
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/contaAddrSecundario
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/saidaSecundaria
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/carona
add wave -noupdate /tb_circuito/uut/fluxodeDados/elevador_subindo
add wave -noupdate /tb_circuito/uut/fluxodeDados/finalRam
add wave -noupdate /tb_circuito/uut/fluxodeDados/saidaRegDestino
add wave -noupdate /tb_circuito/uut/fluxodeDados/saidaRegOrigem
add wave -noupdate /tb_circuito/uut/fluxodeDados/saidaSecundaria
add wave -noupdate /tb_circuito/uut/fluxodeDados/addrSecundario
add wave -noupdate /tb_circuito/uut/fluxodeDados/mesmoSentido
add wave -noupdate /tb_circuito/uut/fluxodeDados/mux4
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/select4
add wave -noupdate /tb_circuito/uut/fluxodeDados/addrSecundarioAnterior
add wave -noupdate /tb_circuito/uut/fluxodeDados/saidaSecundariaAnterior
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {276 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 406
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {182 ns} {434 ns}
