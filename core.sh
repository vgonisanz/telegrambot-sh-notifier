#!/bin/bash

# Contain API key: ${TOKEN} and ${USER_ID}
source "${BASH_SOURCE%/*}/config.sh"

# Available methods
###################
get_me () {
    echo "Getting bot info"
    URL=$API_URL"bot"$TOKEN"/getMe"

    $CURL -X  POST $URL -F chat_id="$USER_ID"
}

send_message () {
    if [ $# -eq 0 ]
    then
      echo "send_message require an argument"
      return
    fi

    local MSG=$1
    echo "Sending to user: $USER_ID message: $MSG"

    URL=$API_URL"bot"$TOKEN"/sendMessage"

    $CURL -s -X POST $URL -d chat_id=$USER_ID -d text="$MSG"
}

send_audio () {
    if [ $# -eq 0 ]
    then
      echo "send_audio require an argument"
      return
    fi

    local PATH=$1
    local CAPTION=$2
    if ! [[ "$PATH" =~ ^http* ]]; then
    PATH="@$PATH"
    fi
    echo "Sending to user: $USER_ID audio: $PATH"

    URL=$API_URL"bot"$TOKEN"/sendAudio"

    $CURL -s -X POST $URL -F chat_id=$USER_ID -F audio=$PATH -F caption="$CAPTION"
}

send_image () {
    if [ $# -eq 0 ]
    then
      echo "send_image require an argument"
      return
    fi

    local PATH=$1
    local CAPTION=$2
    if ! [[ "$PATH" =~ ^http* ]]; then
    PATH="@$PATH"
    fi
    echo "Sending to user: $USER_ID image: $PATH"

    URL=$API_URL"bot"$TOKEN"/sendPhoto"

    $CURL -s -X POST $URL -F chat_id=$USER_ID -F photo=$PATH -F caption="$CAPTION"
}

send_video () {
    if [ $# -eq 0 ]
    then
      echo "send_video require an argument"
      return
    fi

    local PATH=$1
    local CAPTION=$2
    if ! [[ "$PATH" =~ ^http* ]]; then
    PATH="@$PATH"
    fi
    echo "Sending to user: $USER_ID image: $PATH"

    URL=$API_URL"bot"$TOKEN"/sendVideo"

    $CURL -s -X POST $URL -F chat_id=$USER_ID -F video=$PATH -F caption="$CAPTION"
}

send_document () {
    if [ $# -eq 0 ]
    then
      echo "send_document require an argument"
      return
    fi

    local PATH=$1
    local CAPTION=$2
    if ! [[ "$PATH" =~ ^http* ]]; then
    PATH="@$PATH"
    fi
    echo "Sending to user: $USER_ID document: $PATH"

    URL=$API_URL"bot"$TOKEN"/sendDocument"

    $CURL -X  POST $URL -F chat_id="$USER_ID" -F caption="$CAPTION" -F document="$PATH"
}

send_gif () {
    if [ $# -eq 0 ]
    then
      echo "send_gif require an argument"
      return
    fi

    local PATH=$1
    local CAPTION=$2
    if ! [[ "$PATH" =~ ^http* ]]; then
    PATH="@$PATH"
    fi
    echo "Sending gif to user $USER_ID from: $PATH"

    URL=$API_URL"bot"$TOKEN"/sendAnimation"

    $CURL -s -X POST $URL -F chat_id=$USER_ID -F animation=$PATH -F caption="$CAPTION"
}

# Custom requests
#################
send_public_ip () {
    send_message "Your IP is: $($CURL ifconfig.co)"
}
