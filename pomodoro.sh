# Set the amount of time for each pomodoro (in minutes)
pomodoro_length=25

# Set the length of the break (in minutes)
break_length=5

# Set the number of pomodoros before taking a longer break
pomodoros_before_long_break=4

# Set the length of the long break (in minutes)
long_break_length=15

# Set the number of pomodoros completed to 0
pomodoros_completed=0

# Set the path to the sound file
sound_file="./alarm.wav"

while true; do
  # Print a message to let the user know a pomodoro is starting
  printf "Starting pomodoro %d\n" $pomodoros_completed

  # Sleep for the length of a pomodoro
  sleep $(($pomodoro_length * 60))

  # Play the sound to signal the end of the pomodoro
  # This works for Linux. On Mac use the "afplay" command instead.
  aplay $sound_file

  # Increment the number of pomodoros completed
  pomodoros_completed=$(($pomodoros_completed + 1))

  # Check if it's time for a long break
  if [ $pomodoros_completed -eq $pomodoros_before_long_break ]; then
    # Print a message to let the user know a long break is starting
    printf "Starting long break\n"

    # Sleep for the length of the long break
    sleep $(($long_break_length * 60))

    # Play the sound to signal the end of the long break
    aplay $sound_file

    # Reset the number of pomodoros completed
    pomodoros_completed=0
  else
    # Print a message to let the user know a short break is starting
    printf "Starting short break\n"

    # Sleep for the length of the short break
    sleep $(($break_length * 60))

    # Play the sound to signal the end of the short break
    aplay $sound_file
  fi
done
