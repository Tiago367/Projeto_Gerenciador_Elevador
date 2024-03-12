module tb_ram_mod;
reg clk;
reg we=0;
reg [3:0] data;
reg [3:0] addr;
reg shift=0;
reg weT=0;
wire [3:0]q;

sync_ram_16x4_mod duut (clk,we,data,addr,shift,weT,q);
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
      #10;
      
      $finish;
    end
endmodule















