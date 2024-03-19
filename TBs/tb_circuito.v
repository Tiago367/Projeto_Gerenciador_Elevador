`timescale 1us / 1us

module tb_circuito;

reg iniciar, clock, reset, novaEntrada; 
reg [3:0] origem, destino;
wire dbQuintoBitEstado;

circuito_final uut(iniciar, clock, origem, destino, novaEntrada, 
reset, dbQuintoBitEstado
);
parameter clockPeriod = 1;

initial clock=0;

always #1 clock = ~clock;

initial begin
    iniciar = 0;
    reset=0;
    novaEntrada=0;
    origem = 4'b0000;
    destino = 4'b0000;
    reset = 1;
    #10;
    reset = 0;
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
    #200
    origem = 4'b0010; 
    destino = 4'b0110;
    #100
    novaEntrada = 1;
    #50;
    novaEntrada = 0;
    #100;
    #200
    origem = 4'b1000; 
    destino = 4'b0011;
    #100
    novaEntrada = 1;
    #50;
    novaEntrada = 0;
    #100000;
   



    $finish;
end
endmodule