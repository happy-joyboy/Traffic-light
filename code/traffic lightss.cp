#line 1 "C:/Users/Lenovo/Desktop/embedded/task/task/code/traffic lightss.c"
#line 13 "C:/Users/Lenovo/Desktop/embedded/task/task/code/traffic lightss.c"
char led[ 4 ] = {0b00100001, 0b00110001, 0b00001100, 0b00001110};
char current_led = 0;
char counter = 0;
char delay_count = 50;
char temp_portd = 0;
char rr = 20;
char l = 0;
char i = 0;


void manual_mode() {
 while (portb.b0 == 0) {
 portc = 0;
 portd = led[current_led];

 if (portb.b1 == 0) {
 portd = led[++current_led];
 for (counter = 0; counter <= 3; counter++) {
 for (delay_count = 0; delay_count <= 50; delay_count++) {
 portb.b2 = 0;
 portb.b3 = 1;
 portb.b4 = 0;
 portb.b5 = 1;

 portc = 0;
 delay_ms(5);

 portb.b2 = 1;
 portb.b3 = 0;
 portb.b4 = 1;
 portb.b5 = 0;

 portc = (((3 - counter) % 10) << 4) | (((3 - counter) % 10) & 0x0F);
 delay_ms(10);
 }
 }
 current_led ++;
 }

 if (current_led ==  4  | portb.b0 == 1) {
 current_led = 0;
 }
 }
}


void interrupt() {
 if (intf_bit == 1) {
 intf_bit = 0;
 portc=0;
 temp_portd = portd;
  portd.b0 =1;
  portd.b5 =1;

 manual_mode();
 portd = temp_portd;
 }
}


void automatic_mode() {
  portd.b0  = 1;
  portd.b5  = 1;


 for (i=0; i < 23; i++) {
 l = 23 - i;

 if (l == 3) {
 rr = 3;
  portd.b4  = 1;
  portd.b5  = 0;
 }

 for (delay_count = 0; delay_count <= 50; delay_count++) {
 portb.b2 = 0;
 portb.b3 = 1;
 portb.b4 = 0;
 portb.b5 = 1;

 portc = ((rr / 10) << 4) | ((l / 10) & 0x0F);
 delay_ms(5);

 portb.b2 = 1;
 portb.b3 = 0;
 portb.b4 = 1;
 portb.b5 = 0;

 portc = ((rr % 10) << 4) | ((l % 10) & 0x0F);
 delay_ms(10);
 }
 rr--;
 }
  portd.b4  = 0;
  portd.b0  = 0;


 rr = 12;
  portd.b3  = 1;
  portd.b2  = 1;
 for (i = 0; i < 15; i++) {
 l = 15 - i;

 if (l == 3) {
 rr = 3;
  portd.b1  = 1;
  portd.b2  = 0;
 }

 for (delay_count = 0; delay_count <= 50; delay_count++) {
 portb.b2 = 0;
 portb.b3 = 1;
 portb.b4 = 0;
 portb.b5 = 1;

 portc = ((l / 10) << 4) | ((rr / 10) & 0x0F);
 delay_ms(5);

 portb.b2 = 1;
 portb.b3 = 0;
 portb.b4 = 1;
 portb.b5 = 0;

 portc = ((l % 10) << 4) | ((rr % 10) & 0x0F);
 delay_ms(10);
 }
 rr--;
 }
  portd.b3  = 0;
  portd.b1  = 0;
}


void main() {

 trisb = 0;
 trisb.b0 = 1;
 trisb.b1 = 1;
 trisc = 0;
 trisd = 0;


 portb.b2 = 1;
 portb.b4 = 1;
 portc = 0;
 portd = 0;


 gie_bit = 1;
 inte_bit = 1;
 intedg_bit = 0;
 option_reg.b7 = 0;

 while (1) {
 automatic_mode();
 }
}
