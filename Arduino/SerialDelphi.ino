// Init variables
bool LLedState = false;
int LVal = 0;

// Setup function
void setup() {
  // Init serial interface
  Serial.begin(9600);
  // Set pin mode
  pinMode(LED_BUILTIN, OUTPUT);
  // Print ready command to serial
  Serial.print("READY");
}

void loop() {
  // Check if we can read data from serial
  if(Serial.available() > 0) {
    // Read data from serial
    LVal = Serial.read();
    // Compare if not empty
    if(LVal != 0) {
      if(LVal == 45) {
        // Send connect string
        Serial.print("READY");
      } else {
        // Execute command
        OnSerialCommand(LVal);
        // Reset variable
      }
      LVal = 0;
    }
  }
}

void OnSerialCommand(int cmd) {
  // Check recived value
  if(cmd == 49) {
    // Turn on led
    LLedState = true;
  } else if(cmd == 48) {
    // Turn off led
    LLedState = false;
  }
  
  // Check led state
  if(LLedState) {
    // Turn on led
    digitalWrite(LED_BUILTIN, HIGH);
    // Send successful answer
    Serial.print("LED_ON_OK");
  } else {
    // Turn off led
    digitalWrite(LED_BUILTIN, LOW);
    // Send successful answer
    Serial.print("LED_OFF_OK");
  }
}
