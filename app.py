from flask import Flask, render_template, jsonify, request
from motor import Ordinary_Car
from buzzer import Buzzer
from led import Led
import threading
import time

app = Flask(__name__)

# Initialize components
PWM = Ordinary_Car()
buzzer = Buzzer()
led = Led()

# Global state
current_speed = 1000
is_moving = False

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/forward")
def forward():
    global is_moving
    print("Moving FORWARD")
    PWM.set_motor_model(current_speed, current_speed, current_speed, current_speed)
    is_moving = True
    return render_template("index.html")

@app.route("/backward")
def backward():
    global is_moving
    print("Moving BACKWARD")
    PWM.set_motor_model(-current_speed, -current_speed, -current_speed, -current_speed)
    is_moving = True
    return render_template("index.html")

@app.route("/left")
def left():
    global is_moving
    print("Turning LEFT")
    PWM.set_motor_model(-current_speed, -current_speed, current_speed, current_speed)
    is_moving = True
    return render_template("index.html")

@app.route("/right")
def right():
    global is_moving
    print("Turning RIGHT")
    PWM.set_motor_model(current_speed, current_speed, -current_speed, -current_speed)
    is_moving = True
    return render_template("index.html")

@app.route("/stop")
def stop():
    global is_moving
    print("STOPPING")
    PWM.set_motor_model(0, 0, 0, 0)
    is_moving = False
    return render_template("index.html")

@app.route("/speed/<int:speed>")
def speed(speed):
    global current_speed
    current_speed = min(max(speed, 0), 2000)  # Limit to 0-2000
    print(f"Speed set to {current_speed}")
    return jsonify({"status": "ok", "speed": current_speed})

@app.route("/beep")
def beep():
    print("BEEP!")
    buzzer.set_state(True)
    threading.Timer(0.2, lambda: buzzer.set_state(False)).start()
    return jsonify({"status": "ok"})

@app.route("/led/<color>")
def set_led(color):
    colors = {
        'red': (255, 0, 0),
        'green': (0, 255, 0),
        'blue': (0, 0, 255),
        'yellow': (255, 255, 0),
        'white': (255, 255, 255)
    }
    if color in colors:
        r, g, b = colors[color]
        led.ledIndex(0xFF, r, g, b)
        print(f"LED set to {color}")
    return jsonify({"status": "ok", "color": color})

@app.route("/status")
def status():
    return jsonify({
        "moving": is_moving,
        "speed": current_speed,
        "status": "running"
    })

if __name__ == "__main__":
    print("Robot Car Flask Server Starting...")
    print("Access at http://192.168.1.164:5002")
    app.run(host="0.0.0.0", debug=False, port=5002)

