

module sync_ram_16x4_mod(
    input        clk,
    input        we, // write enable para escrita no addr dado
    input  [3:0] data,
    input  [3:0] addr,
    input        shift,
    input        weT, // write enable top (coloca o dado novo no fim da fila)
    output [3:0] q
);

    // Variavel RAM (armazena dados)
    reg [3:0] ram[15:0];

    // Registra endereco de acesso
    reg [3:0] addr_reg;

    // Especifica conteudo inicial da RAM
    // a partir da leitura de arquivo usando $readmemb
    initial begin
        ram[0] = 0;
        ram[1] = 0;
        ram[2] = 0;
        ram[3] = 0;
        ram[4] = 0;
        ram[5] = 0;
        ram[6] = 0;
        ram[7] = 0;
        ram[8] = 0;
        ram[9] = 0;
        ram[10] = 0;
        ram[11] = 0;
        ram[12] = 0;
        ram[13] = 0;
        ram[14] = 0;
        ram[15] = 0;
    end
    always @ (posedge clk)
    begin
        // Escrita da memoria
        if (we)
            ram[addr] <= data;
        if (weT) begin
            if(ram[0] == 0) ram[0] = data;
            else if(ram[1] == 4'b0000) ram[1] = data;
            else if(ram[2] == 4'b0000) ram[2] = data;
            else if(ram[3] == 4'b0000) ram[3] = data;
            else if(ram[4] == 4'b0000) ram[4] = data;
            else if(ram[5] == 4'b0000) ram[5] = data;
            else if(ram[6] == 4'b0000) ram[6] = data;
            else if(ram[7] == 4'b0000) ram[7] = data;
            else if(ram[8] == 4'b0000) ram[8] = data;
            else if(ram[9] == 4'b0000) ram[9] = data;
            else if(ram[10] == 4'b0000) ram[10] = data;
            else if(ram[11] == 4'b0000) ram[11] = data;
            else if(ram[12] == 4'b0000) ram[12] = data;
            else if(ram[13] == 4'b0000) ram[13] = data;
            else if(ram[14] == 4'b0000) ram[14] = data;
            else if(ram[15] == 4'b0000) ram[15] = data;
        end
        if(shift) begin 
            ram[0] = 15;
            ram[0] = ram[1];
            ram[1] = ram[2];
            ram[2] = ram[3];
            ram[3] = ram[4];
            ram[4] = ram[5];
            ram[5] = ram[6];
            ram[6] = ram[7];
            ram[7] = ram[8];
            ram[8] = ram[9];
            ram[9] = ram[10];
            ram[10] = ram[11];
            ram[11] = ram[12];
            ram[12] = ram[13];
            ram[13] = ram[14];
            ram[14] = ram[15];
            ram[15] = 0;
        end    

        addr_reg <= addr;
    end

    // Atribuicao continua retorna dado
    assign q = ram[addr_reg];

endmodule