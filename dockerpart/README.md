as a before this part was easier because i worked before with docker, this part was done in fedora as i learned at ibm to do it. 

everything went smooth until git actions that gave me a headache. a lot of headache as i had done the automation in jenkins before.

docker.txt is the commands i done in the terminal to build and run the dockerfile

the dockerfile with the commands

also added to calculator.py "Ensure the application catches the Docker container's stop signal and performs a
clean shutdown" which is: 

import signal
import sys
def handle_sigterm(signal, frame):
    print("Received SIGTERM, shutting down gracefully...")
    sys.exit(0)

signal.signal(signal.SIGTERM, handle_sigterm)

i think thats it.
my dockerhub is lovecode23: https://hub.docker.com/repositories/lovecode23
