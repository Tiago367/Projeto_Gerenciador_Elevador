onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_circuito/clock
add wave -noupdate /tb_circuito/origem
add wave -noupdate /tb_circuito/iniciar
add wave -noupdate /tb_circuito/uut/UC/Eatual
add wave -noupdate /tb_circuito/uut/fluxodeDados/proxParada
add wave -noupdate /tb_circuito/uut/fluxodeDados/andarAtual
add wave -noupdate /tb_circuito/uut/fluxodeDados/chegouDestino
add wave -noupdate /tb_circuito/uut/fluxodeDados/enableRAM
add wave -noupdate /tb_circuito/uut/fluxodeDados/mux1
add wave -noupdate /tb_circuito/uut/fluxodeDados/fila_ram/shift
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/Eatual
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/enableTopRAM
add wave -noupdate /tb_circuito/uut/UC_NOVAJOGADA/bordaNovaEntrada
add wave -noupdate /tb_circuito/uut/UC/zeraT
add wave -noupdate /tb_circuito/uut/UC/contaT
add wave -noupdate /tb_circuito/uut/UC/fimT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2312 ns} 0}
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
WaveRestoreZoom {2243 ns} {2599 ns}
