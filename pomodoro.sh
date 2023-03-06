#!/bin/bash

# Set the length of each pomodoro in minutes
pomodoro_length=25

# Set the number of pomodoros before a break
pomodoros_per_break=4

# Set the length of each break in minutes
break_length=5

# Initialize the pomodoro and break counters
pomodoros_completed=0
breaks_taken=0

# Get the pomodoro length in seconds
pomodoro_length_sec=$((pomodoro_length * 60))

# Start the timer
echo "Starting pomodoro for $pomodoro_length minutes..."
afplay "./alarm.wav"
for ((i = pomodoro_length_sec; i >= 0; i--)); do
  # Calculate the minutes and seconds remaining
  minutes=$((i / 60))
  seconds=$((i % 60))

  # Print the remaining time
  printf "\rTime remaining: %02d:%02d" $minutes $seconds

  # Sleep for 1 second
  sleep 1
done

# Print a newline after the timer is done
echo ""

while true; do
  # Display the remaining time for the current pomodoro or break
  if [[ pomodoros_completed -gt 0 ]]; then
    if [[ $((pomodoros_completed % pomodoros_per_break)) -eq 0 ]]; then
      # It's time for a break
      minutes_remaining=$break_length
      echo "Taking a break for $minutes_remaining minutes..."
    else
      # It's time for a pomodoro
      minutes_remaining=$pomodoro_length
      echo "Working for $minutes_remaining minutes..."
    fi
  fi

  # Sleep for one minute and then update the remaining time
  sleep 60
  minutes_remaining=$((minutes_remaining - 1))

  # Check if the current pomodoro or break is finished
  if [ $minutes_remaining -eq 0 ]; then
    if [ $((pomodoros_completed % pomodoros_per_break)) -eq 0 ]; then
      # A break just ended
      breaks_taken=$((breaks_taken + 1))
      echo "Break is over. Time to get back to work!"
      afplay "./alarm.wav"
    else
      # A pomodoro just ended
      pomodoros_completed=$((pomodoros_completed + 1))
      echo "Pomodoro is over. Time for a break!"
      # Play a sound to indicate that the pomodoro is over
      # Replace "sound.mp3" with the path to the desired sound file
      afplay "./alarm.wav"
    fi
  fi
done
