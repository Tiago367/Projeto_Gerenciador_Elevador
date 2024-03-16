`timescale 1ns/1ns

module tb_circuito;

reg iniciar, clock, reset, novaEntrada; 
reg [3:0] origem, destino;
wire dbQuintoBitEstado;

circuito_final uut(iniciar, clock, origem, destino, novaEntrada, 
reset, dbQuintoBitEstado
);
parameter clockPeriod = 20;

initial clock=0;

always #10 clock = ~clock;

initial begin
    iniciar = 0;
    reset=0;
    novaEntrada=0;
    origem = 4'b0000;
    destino = 4'b0000;

    #50;
    iniciar=1; 
    #50;
    origem = 4'b0001; 
    destino = 4'b0100;
    #100
    novaEntrada = 1;
    #50;
    novaEntrada = 0;
    #100;
    #200000
    #100;
    #200;
    #100;
    #200;
   



    $finish;
end
endmodule