#!/bin/bash
# obs-status - toggle OBS recording/buffer/replay and notify
# Usage: obs-status -recording | -buffer | -replay

case "$1" in
-recording)
  s=$(obs-cmd recording status 2>&1)
  if echo "$s" | grep -q 'Active: true'; then
    obs-cmd recording stop >/dev/null 2>&1
    notify-send OBS "Recording stopped"
  else
    obs-cmd recording start >/dev/null 2>&1
    notify-send OBS "Recording started"
  fi
  ;;
-pause)
  obs-cmd recording toggle-pause >/dev/null 2>&1
  sleep 0.3
  s=$(obs-cmd recording status 2>&1)
  if echo "$s" | grep -q 'Paused: true'; then
    notify-send OBS "Recording paused"
  else
    notify-send OBS "Recording resumed"
  fi
  ;;
-buffer)
  s=$(obs-cmd replay status 2>&1)
  if echo "$s" | grep -q 'not running'; then
    obs-cmd replay start >/dev/null 2>&1
    notify-send OBS "Buffer started"
  else
    obs-cmd replay stop >/dev/null 2>&1
    notify-send OBS "Buffer stopped"
  fi
  ;;
-replay)
  s=$(obs-cmd replay status 2>&1)
  if echo "$s" | grep -q 'not running'; then
    notify-send OBS "Replay not saved"
  else
    obs-cmd replay save >/dev/null 2>&1
    notify-send OBS "Replay saved"
  fi
  ;;
*)
  echo "Usage: obs-status -recording | -pause | -buffer | -replay"
  exit 1
  ;;
esac
