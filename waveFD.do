onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fluxo_de_dados/clock
add wave -noupdate /tb_fluxo_de_dados/destino
add wave -noupdate /tb_fluxo_de_dados/origem
add wave -noupdate -divider -height 30 {New Divider}
add wave -noupdate /tb_fluxo_de_dados/uut/enableRegOrigem
add wave -noupdate /tb_fluxo_de_dados/uut/enableRegDestino
add wave -noupdate /tb_fluxo_de_dados/uut/saidaRegDestino
add wave -noupdate /tb_fluxo_de_dados/uut/saidaRegOrigem
add wave -noupdate /tb_fluxo_de_dados/uut/usuario_subindo
add wave -noupdate -divider -height 30 {New Divider}
add wave -noupdate /tb_fluxo_de_dados/uut/mux4
add wave -noupdate /tb_fluxo_de_dados/uut/andarAtual
add wave -noupdate /tb_fluxo_de_dados/uut/proxParada
add wave -noupdate /tb_fluxo_de_dados/uut/elevador_subindo
add wave -noupdate /tb_fluxo_de_dados/uut/mux3
add wave -noupdate /tb_fluxo_de_dados/uut/saidaSecundaria
add wave -noupdate /tb_fluxo_de_dados/uut/proxAndarMaior
add wave -noupdate /tb_fluxo_de_dados/uut/saidaSecMaior
add wave -noupdate /tb_fluxo_de_dados/uut/mesmoSentido
add wave -noupdate /tb_fluxo_de_dados/uut/carona
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {63 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 466
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
WaveRestoreZoom {50 ns} {74 ns}
