`timescale 1ns / 1ns


module tb_ram_mod;
reg clk;
reg we=0;
reg [3:0] data, addrSecAnt, addrSec;
reg [3:0] addr;
reg shift=0;
reg weT=0;
reg fit=0;
wire [3:0]q, saidaSecundaria, saidaSecundariaAnterior;

sync_ram_16x4_mod duut (clk,we,data,addrSecAnt,addrSec,addr,shift,weT,fit,q,saidaSecundaria,saidaSecundariaAnterior);
initial clk=0;
always #2 clk = ~clk;

initial begin
    $dumpfile("tb_ram_mod.vcd");
    $dumpvars(0,tb_ram_mod);
     // Teste 1. Guardar 10 no endereço 2
      addr = 2;
      data = 10;
      #10;
      we = 1;
      #5
      we = 0;
      // Teste 2. guarda 8 no endereço 0, utilizando o weT
      data=8;
      #10;
      weT=1;
      #2;
      weT=0;
      // Teste 3. coloca 5 no endereço 1, utilizando o weT
      data=5;
      #10;
      weT=1;
      #2;
      weT=0;
      //Teste 4. Shift
      #2;
      shift=1;
      #2;
      shift=0;
      // Teste 6. coloca 3 no endereço 2, utilizando o wet
      data = 3;
      #4;
      weT = 1;
      #4;
      weT = 0;
      // Teste 5 Fit
      addrSec  = 1;
      data  = 5;
      #8
      fit   = 1;
      #4
      fit   = 0;
      #20
      
      $finish;
    end
endmodule















