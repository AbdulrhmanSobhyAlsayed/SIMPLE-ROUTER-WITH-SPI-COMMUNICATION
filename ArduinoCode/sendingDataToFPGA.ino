

#include <Keypad.h> //The keypad 

//keypad

const byte numRows= 4; //number of rows on the keypad
const byte numCols= 4; //number of columns on the keypad
//keymap defines the key pressed according to the row and columns just as appears on the keypad
char keymap[numRows][numCols]=
{
{'1', '2', '3', 'A'},
{'4', '5', '6', 'B'},
{'7', '8', '9', 'C'},
{'*', '0', '#', 'D'}
};

byte rowPins[numRows] = {9,8,7,6}; //Rows 0 to 3 //if you modify your pins you should modify this too
byte colPins[numCols]= {5,4,3,2}; //Columns 0 to 3
//initializes an instance of the Keypad class
Keypad myKeypad= Keypad(makeKeymap(keymap), rowPins, colPins, numRows, numCols);

//pins

uint8_t const clk=10;
uint8_t const selector=11;
uint8_t const bitOut =12;
uint8_t const bitIn =13;


//variables
String destnation = "";
String data = "";
String checkSum = "";
String backet="";
bool enableDes=true;
bool enableData=true;
bool enableCheck=true;
bool sendBacket=false;
long dataSend=0.0;
char key ;
int len =8;



void setup()
{
        
        Serial.begin(9600);
        pinMode(clk,OUTPUT);
        pinMode(selector,OUTPUT);
        pinMode(bitOut,OUTPUT);
        pinMode(bitIn,INPUT);
           
}

void loop()
{
 //initialize all variable
 
         
         digitalWrite(selector,0);
         digitalWrite(clk,0);
         digitalWrite(bitOut,0);
         
        
//         dataSend=0.0;

         
  //destnation entering 
  
         if(enableDes){
         destnation = "";
         key=' ';
         Serial.println("Enter the port number then press#");
         while (key != '#'){
          
         key = myKeypad.getKey();
         
         if(key!='#'){
         Serial.print(key);
         destnation +=String(key); 
         }
         }
         Serial.println("");
         Serial.println("destnation is:");
         Serial.println(destnation);
         
         destnation = String(destnation.toInt(),BIN);
         
         if (destnation.length()>len){
          enableData=false;
          enableCheck=false;
          Serial.println("the maximum size is 8-bit please reenter");
         }

         else if (destnation.length()<len){
         enableData=true;
         enableCheck=true;
          int siz= destnation.length();
          for (int i=0; i<len-siz; i++){
            destnation=String('0')+destnation;
          }
         }
         else{
         enableData=true;
         enableCheck=true;
         }
         }
         delay(1000);
         
 //data entering 

 
         if (enableData){
         data = "";
         key=' ';
         Serial.println("Enter the data then press#");
         while (key != '#'){
          
         key = myKeypad.getKey();
         
         if(key!='#'){
         Serial.print(key);
         data +=String(key); 
         }
         }
         Serial.println("");
         Serial.println("data is:");
         Serial.println(data);

         data = String(data.toInt(),BIN);

         if (data.length()>len){
          enableDes=false;
          enableCheck=false;
          Serial.println("the maximum size is 8-bit please reenter");
         }

         else if (data.length()<len){
          enableDes=true;
         enableCheck=true;
          int siz= data.length();
          for (int i=0; i<len-siz; i++){
            data=String('0')+data;
          }
         }
         else{
         enableDes=true;
         enableCheck=true;
         }
         
         }
         delay(1000);

  //check sum entering 
  
         if(enableCheck){
         checkSum = "";
         key=' ';
         Serial.println("Enter check sum then press#");
         while (key != '#'){
          
         key = myKeypad.getKey();
         
         if(key!='#'){
         Serial.print(key);
         checkSum +=String(key); 
         }
         }
         Serial.println("");
         Serial.println("check sum is:");
         Serial.println(checkSum);  
         checkSum = String(checkSum.toInt(),BIN);

          if (checkSum.length()>len+1){
          enableData=false;
          enableDes=false;
          Serial.println("the maximum size is 9-bit please reenter");
         }

         else if (checkSum.length()<len+1){
         enableData=true;
         enableDes=true;
          int siz= checkSum.length();
          for (int i=0; i<len+1-siz; i++){
            checkSum=String('0')+checkSum;
          }
         }
         else{
         enableData=true;
         enableDes=true;
         }
         
         }
         delay(1000);

 

 // modify the backet
 if (enableDes&&enableData&&enableCheck){
        backet="";
        backet=destnation+data+checkSum;

        sendBacket=true;
   
 }
 //send data
        if(sendBacket){
          digitalWrite(selector,1);
          
          for (int i=0; i<backet.length(); i++){

             digitalWrite(bitOut,String(backet[i]).toInt());
             
              
             digitalWrite(clk,1);
        
              

             digitalWrite(clk,0);
             
          
             
          }

          if(digitalRead(bitIn)==HIGH){Serial.println("there is an error resend thepacket");}
          else{Serial.println("the packet sended");}

          Serial.println("Enter * for new operation");

          

          while (key!= '*'){

            key = myKeypad.getKey();
            
          }

          sendBacket=false;
          digitalWrite(selector,0);
          digitalWrite(bitOut,0);            
        }

 

 

            
}
