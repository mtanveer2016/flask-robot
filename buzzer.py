import time
import rgpio
import os

class Buzzer:
    def __init__(self, pi_host='localhost', pi_port=8889):
        self.PIN = 17
        
        # Step 1: Connect to the rgpiod daemon
        self.sbc = rgpio.sbc(host=pi_host, port=pi_port)
        
        if not self.sbc.connected:
            raise Exception(f"Could not connect to rgpio daemon at {pi_host}:{pi_port}")
        
        # Step 2: Open the GPIO chip (chip 0 is the main GPIO controller)
        self.chip_handle = self.sbc.gpiochip_open(0)
        
        if self.chip_handle < 0:
            raise Exception(f"Could not open GPIO chip: {self.chip_handle}")
        
        # Step 3: Claim the GPIO pin as output using the chip handle
        result = self.sbc.gpio_claim_output(self.chip_handle, self.PIN)
        
        if result < 0:
            raise Exception(f"Could not claim GPIO pin {self.PIN}: {result}")

    def set_state(self, state: bool) -> None:
        """Set the buzzer state (True = ON, False = OFF)."""
        # Write to the GPIO using the chip handle and pin number
        self.sbc.gpio_write(self.chip_handle, self.PIN, 1 if state else 0)

    def close(self) -> None:
        """Clean up and close the connection to the daemon."""
        # Free the GPIO pin
        self.sbc.gpio_free(self.chip_handle, self.PIN)
        # Close the GPIO chip
        self.sbc.gpiochip_close(self.chip_handle)
        # Stop the connection
        self.sbc.stop()

if __name__ == '__main__':
    PI_HOST = os.environ.get('PIGPIO_ADDR', 'localhost')
    PI_PORT = int(os.environ.get('PIGPIO_PORT', 8889))
    
    print(f'Program is starting ... connecting to rgpiod at {PI_HOST}:{PI_PORT}')
    buzzer = Buzzer(pi_host=PI_HOST, pi_port=PI_PORT)
    
    try:
        for _ in range(3):
            buzzer.set_state(True)
            print("Buzzer ON")
            time.sleep(0.1)
            buzzer.set_state(False)
            print("Buzzer OFF")
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("\nProgram interrupted")
    finally:
        buzzer.close()
        print("Buzzer closed")
