module tb_fluxo_de_dados;
 reg clock;
 reg [3:0] origem;
 reg [3:0] destino;
 reg novaEntrada;
 reg shift;
 reg enableRAM;
 reg enableTopRAM;
 reg select1;
 reg select2;
 reg select3;
 reg select4;
 reg zeraT;
 reg contaT;
 reg clearAndarAtual;
 reg clearSuperRam; 
 reg enableAndarAtual;
 reg enableRegOrigem;
 reg enableRegDestino;
 wire chegouDestino;
 wire bordaNovaEntrada;
 wire fimT;
 wire [3:0] proxParada;
 reg [3:0] andarAtual;
 wire elevador_subindo;


FD uut (
clock,
origem,
destino,
novaEntrada,
shift,
enableRAM,
enableTopRAM,
select1,
select2,
select3,
select4,
zeraT,
contaT,
clearAndarAtual,
clearSuperRam, 
enableAndarAtual,
enableRegOrigem,
enableRegDestino,
chegouDestino,
bordaNovaEntrada,
fimT,
proxParada,
andarAtual,
elevador_subindo
);

initial clock=0;
always #2 clock = ~clock;

initial begin
    select4 = 0;
    andarAtual = 4'b0000;
    origem = 4'b0001;
    destino = 4'b0100;
    #10;
    enableRegOrigem = 1;
    enableRegDestino = 1;
    #10;
    enableRegOrigem = 0;
    enableRegDestino = 0;
    #10;
    select3 = 1;
    #10;
    select3 = 0;
    #10;
    origem = 4'b0100;
    destino = 4'b0001;
    #10;
    enableRegOrigem = 1;
    enableRegDestino = 1;
    #10;
    enableRegOrigem = 0;
    enableRegDestino = 0;
    #10;
    select3 = 1;
    #10;
    select3 = 0;
    #10;
    $finish;

end

endmodule