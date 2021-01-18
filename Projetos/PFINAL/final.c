
//Projeto Final
//Testanto a comunicação PIC - ARDUINO - PC
//Inicializa a UART1

//Inicializa a UART2
void Init_UART1(unsigned char valor_baud)
{
    U1BRG = valor_baud; //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
    U1MODE = 0x0000;    //ver tabela para saber as outras configura??es
    U1MODEbits.ALTIO = 1;
    U1STA = 0x0000;
    IFS0bits.U1TXIF = 0;   //Zera a flag de interrupcao de Tx
    IEC0bits.U1TXIE = 0;   //Desabilita a interrupcao de Tx
    IFS0bits.U1RXIF = 0;   //Zera a flag de de interrupcao de Rx
    IEC0bits.U1RXIE = 0;   //Desabilita a flag de interrupcao de Rx
    U1MODEbits.UARTEN = 1; //Liga a UART
    U1STAbits.UTXEN = 1;   //Come?a a comunica??o
}

//Reseta flag da transmissao
void Tx_serial1() iv IVT_ADDR_U1TXINTERRUPT
{
    IFS0bits.U1TXIF = 0;
}

//envia um char pelo reg da uart
void send_char1(unsigned char c)
{
    while (U1STAbits.UTXBF);
    U1TXREG = c; // escreve caractere
}

//usa a função de char pra enviar uma string
void send_str1(unsigned char *str)
{
    unsigned int i = 0;
    while (str[i])
        send_char1(str[i++]);
}

//recebe char
char receive_char1(){
     char c;
     while(!U1STAbits.URXDA);
     c = U1RXREG; // escreve caractere
     return c;
}

char str1[100];
void receive_str1(){
     int i = 0;
     char c;
     do{
         c = receive_char1();
         str1[i] = c;
         i++;
     }while(c != 0x69);
     str1[i-1] = '\0';
}


//Inicializa a UART2
void Init_UART2(unsigned char valor_baud)
{
    U2BRG = valor_baud; //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
    U2MODE = 0x0000;    //ver tabela para saber as outras configura??es
    U2STA = 0x0000;
    IFS1bits.U2TXIF = 0;   //Zera a flag de interrupcao de Tx
    IEC1bits.U2TXIE = 0;   //Desabilita a interrupcao de Tx
    IFS1bits.U2RXIF = 0;   //Zera a flag de de interrupcao de Rx
    IEC1bits.U2RXIE = 0;   //Desabilita a flag de interrupcao de Rx
    U2MODEbits.UARTEN = 1; //Liga a UART
    U2STAbits.UTXEN = 1;   //Come?a a comunica??o
}

//Reseta flag da transmissao
void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT
{
    IFS1bits.U2TXIF = 0;
}

//envia um char pelo reg da uart
void send_char2(unsigned char c)
{
    while (U2STAbits.UTXBF);
    U2TXREG = c; // escreve caractere
}

//usa a função de char pra enviar uma string
void send_str2(unsigned char *str)
{
    unsigned int i = 0;
    while (str[i])
        send_char2(str[i++]);
}

//recebe char
char receive_char2(){
     char c;
     while(!U2STAbits.URXDA);
     c = U2RXREG; // escreve caractere
     return c;
}

char str2[100];
void receive_str2(){
     int i = 0;
     char c;
     //str2[0] = receive_char2();
     do{
         c = receive_char2();
         str2[i] = c;
         i++;
     }while(c != 0x0A);
     str2[i-1] = '\0';
}



void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO
{
    IFS0bits.INT0IF = 0;
}

/*
void Init_ADC()
{
    //Configruação dos registradores  AD e das PORTAS

    ADPCFGbits.PCFG6 = 0;
    ADPCFGbits.PCFG7 = 0;
    ADPCFGbits.PCFG8 = 0;
    IFS0 = 0;
    IFS1 = 0;
    TRISB = 0;
    LATBbits.LATB0 = 1;
    LATBbits.LATB1 = 1;
    TRISE = 0x0100;
    LATEbits.LATE0 = 1;
    TRISBbits.TRISB6 = 1;
    TRISBbits.TRISB7 = 1;
    TRISBbits.TRISB8 = 1;
    TRISD = 0;
    ADCON1 = 0;
    ADCON1bits.SSRC = 0b010; // Sincando o tempo de conversao com o timer 3

    //Configurando o timer para 8kHz sem psk
    TMR3 = 0x0000;
    PR3 = 1500;
    T3CON = 0x8000;

    // Conectando o canal as entradas em que estão os sensores
    ADCHS = 0x0002; // Connect RB2/AN2 as CH0 input ..
    ADCSSL = 0;
    ADCON3 = 0x0007;
    ADCON3bits.ADCS = 8;
    ADCON3bits.SAMC = 32;
    ADCON2 = 0;
    ADCON2bits.SMPI = 0b1111;
    ADCON1.ADON = 1;
    IEC0bits.INT0IE = 1;
    INTCON2bits.INT0EP = 0;

    T2CON = 0x8030;
    PR2 = 1250;
    OC1CON = 0x0006;
    OC1RS = 0;

    /*IEC0bits.T1IE = 1;
    //Configurando o Timer para 0.5

    TMR1 = 0x0000;
    PR1 = 31250;
    T1CON = 0x8030;

    T1CONbits.TCKPS = 0b11;
    IEC0bits.T1IE = 1;
    IFS0bits.T1IF = 0;
}*/


//Funcao para validar a entrada do usuario



int menu;
char flag_menu;

void funcao1(){
  //Fazer algo
  LATB = 1;
  send_char2('1');
  send_char2('\n');
  send_str1(flag_menu);
  receive_str1();
  send_char2('\n');
  send_str2(str1);
  send_char2('\n');
}

void funcao2(){
  //Fazer algo
  LATB = 0;
  send_char2('2');
  send_char2('\n');
  send_str1(flag_menu);
  receive_str1();
  send_char2('\n');
  send_str2(str1);
  send_char2('\n');
}

void funcao3(){
  //Fazer algo
  LATB = 1;
  send_char2('3');
  send_char2('\n');
  send_str1(flag_menu);
  receive_str1();
  send_char2('\n');
  send_str2(str1);
  send_char2('\n');
}

void funcao4(){
  //Fazer algo
  LATB = 0;
  send_char2('4');
  send_char2('\n');
  send_str1(flag_menu);
  receive_str1();
  send_char2('\n');
  send_str2(str1);
  send_char2('\n');
}

void funcao5(){
  //Fazer algo
  LATB = 1;
  send_char2('5');
  send_char2('\n');
  send_str1(flag_menu);
  send_char2('\n');
  send_str2(str1);
  send_char2('\n');
}


//Variaveis que guardarao os nomes de 10 pessoas para validar a demo do sistema
char nomes[10][200] = {"",
                       "",
                       "",
                       "",
                       "",
                       "",
                       "",
                       "",
                       "",
                       ""};
char txt;
void main()
{
    ADPCFG = 0xFFFF;
    TRISB = 0;
    Init_UART1(51);
    Init_UART2(51);

    while(1){
       //receive_str2();
       //receive_str1();
       //send_str1(str2);
       //send_str2(str2);
       //send_char2('\n');
       //receive_str1();
       //delay_ms(220);
       //send_str2(str1);
       //send_char2('\n');
       //receive_str2();
       //send_str1(str2);
       /*Isso DAQUI FUNCIONA
       receive_str1();
       send_str2(str1);
       send_char2('\n');
       delay_ms(200);*/
       receive_str2();   //Recebendo o Comando
       send_str1(str2);  //Enviando  o Comanod para o arduino
       delay_ms(200);    //Atraso para garantir que a mensagem foi enviada
       receive_str1();   //Recebendo a mensagem do arduino
       send_str2(str1);  //Mostrando a mensagem recebida do arduino
       send_char2('\n'); //Formatando a linha para mostrar as coisas 'okay'
       delay_ms(200);    //
       //delay_ms(220);
       //send_str2(str1);
       //send_char2('\n');
       //delay_ms(2000);
    }
    /*
    while(!U2STAbits.URXDA);
    do{
       send_str2("Sistema de Controle por Acquisição de DIGITAIS");
       send_char2('\n');
       send_str2("1. Cadastrar Digital: ");
       send_char2('\n');
       send_str2("2. Buscar Digital: ");
       send_char2('\n');
       send_str2("3. Mostrar Banco: ");
       send_char2('\n');
       send_str2("4. Deletar Digital: ");
       send_char2('\n');
       send_str2("5. Testar Nulidade do Banco de Digitais: ");
       send_char2('\n');
       flag_menu = receive_char2();
       menu = flag_menu - '0';
       switch(menu)
       {
         case 1:
           funcao1();
         break;

         case 2:
           funcao2();
         break;

         case 3:
           funcao3();
         break;

         case 4:
           funcao4();
         break;

         case 5:
           funcao5();
         break;

         default:
           send_str2("Digite uma opcao valida: \n ");
           flag_menu = receive_char2();
           menu = flag_menu - '0';
        }
   }while(1); */
}