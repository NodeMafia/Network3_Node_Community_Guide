#!/bin/bash

# Node Mafia ASCII Art
echo "
     __             _                        __  _        
  /\ \ \  ___    __| |  ___   /\/\    __ _  / _|(_)  __ _ 
 /  \/ / / _ \  / _\` | / _ \ /    \  / _\` || |_ | | / _\` |
/ /\  / | (_) || (_| ||  __// /\/\ \| (_| ||  _|| || (_| |
\_\ \/   \___/  \__,_| \___|\/    \/ \__,_||_|  |_| \__,_|

EN Telegram: soon..
RU Telegram: https://t.me/nodemafia
GitHub: https://github.com/NodeMafia
Medium: https://medium.com/@nodemafia
Teletype: https://teletype.in/@nodemafia
Twitter: https://x.com/NodeMafia
"

# Function to remove all screen sessions with 'network3' in their name
remove_network3_screens() {
    echo "Removing all screen sessions with 'network3'..."
    screen -list | grep "network3" | awk '{print $1}' | xargs -I {} screen -S {} -X quit
}

# Function for the first start of Network3 Node
first_start_network3() {
    echo "Starting initial setup for Network3 Node..."

    # Removing old screen sessions with 'network3'
    remove_network3_screens

    # Updating apt files
    echo "Updating apt files..."
    sudo apt update && sudo apt upgrade -y

    # Installing necessary packages
    echo "Installing screen and net-tools..."
    sudo apt install -y screen net-tools

    # Downloading Network3 Node
    echo "Downloading Network3 Node..."
    wget https://network3.io/ubuntu-node-v2.1.0.tar

    # Unzipping the downloaded file
    echo "Unzipping the downloaded file..."
    tar -xvf ubuntu-node-v2.1.0.tar
    rm -rf ubuntu-node-v2.1.0.tar
    cd ubuntu-node || exit

    # Creating a separate screen session for the node
    echo "Creating a new screen session named 'network3'..."
    screen -S network3 -dm bash -c "sudo bash manager.sh up; exec bash"

    # Wait a few seconds for the node to start
    sleep 5

    # Getting the full output from the 'key' command
    echo "Fetching API key information..."
    api_output=$(sudo bash manager.sh key)

    # Extracting the information after 'System architecture is x86_64 (64-bit)'
    api_key=$(echo "$api_output" | awk '/System architecture is x86_64 \(64-bit\)/ {found=1; next} found')

    # Displaying the extracted API key information
    if [ -n "$api_key" ]; then
        echo -e "\033[1;32mAPI KEY INFO:\033[0m"
        echo -e "\033[1;34m$api_key\033[0m"
    else
        echo -e "\033[1;31mFailed to retrieve API key information.\033[0m"
    fi

    # Prompt to access synchronization link
    server_ip=$(hostname -I | awk '{print $1}')
    sync_link="https://account.network3.ai/main?o=${server_ip}:8080"

    echo "Go to the following link to complete synchronization with your registered account:"
    # Кликабельная ссылка
    echo -e "\033]8;;${sync_link}\033\\${sync_link}\033]8;;\033\\"

    echo "Initial setup of Network3 Node is complete. Please follow the synchronization steps in the browser."
}

# Function to start Network3 Node
start_network3() {
    echo "Starting Network3 Node..."

    # Removing old screen sessions with 'network3'
    remove_network3_screens

    # Проверяем, существует ли директория ubuntu-node
    if [ ! -d "ubuntu-node" ]; then
        echo -e "\033[1;31mDirectory 'ubuntu-node' does not exist. Please ensure the node is installed correctly.\033[0m"
        return 1
    fi

    cd ubuntu-node || exit

    # Проверяем, есть ли активная сессия с именем 'network3'
    if screen -list | grep -q "network3"; then
        echo -e "\033[1;33mScreen session 'network3' already exists. Attaching to it...\033[0m"
        screen -r network3
    else
        echo -e "\033[1;32mCreating a new screen session 'network3'...\033[0m"
        screen -S network3 -dm bash -c "sudo bash manager.sh up; exec bash"
    fi

    echo "Network3 Node has started."
}

# Function to stop Network3 Node
stop_network3() {
    echo "Stopping Network3 Node..."

    # Убедимся, что мы в директории ubuntu-node внутри screen, если нет — переходим туда
    if [ "$(basename "$PWD")" != "ubuntu-node" ]; then
        echo -e "\033[1;32mChanging directory to 'ubuntu-node'...\033[0m"
        cd ubuntu-node || exit
    fi

    # Проверяем, существует ли screen сессия 'network3'
    if screen -list | grep -q "network3"; then
        echo -e "\033[1;32mStopping screen session 'network3'...\033[0m"
        sudo bash manager.sh down
        screen -S network3 -X quit
        echo "Network3 Node has stopped."
    else
        echo -e "\033[1;31mNo active screen session found for 'network3'.\033[0m"
    fi

    # Удаление старых сессий screen
    remove_network3_screens
}

# Function to restart Network3 Node
restart_network3() {
    echo "Restarting Network3 Node..."

    # Переходим в директорию ubuntu-node, если мы не в ней
    if [ "$(basename "$PWD")" != "ubuntu-node" ]; then
        echo -e "\033[1;32mChanging directory to 'ubuntu-node'...\033[0m"
        cd ubuntu-node || exit
    fi

    # Проверяем, существует ли screen сессия 'network3'
    if screen -list | grep -q "network3"; then
        echo -e "\033[1;32mStopping screen session 'network3'...\033[0m"
        sudo bash manager.sh down
        screen -S network3 -X quit
    fi

    # Удаляем старые сессии screen
    remove_network3_screens

    # Создаем новый screen и запускаем новый узел
    screen -S network3 -dm bash -c "sudo bash manager.sh up; exec bash"
    echo "Network3 Node has restarted."
}

# Function to view logs of Network3 Node
view_logs_network3() {
    echo "Viewing logs of Network3 Node..."
    screen -r network3
}

# Main menu
while true; do
    echo -e "\033[1;33mIMPORTANT:\033[0m To detach from the screen session, use \033[1;32mCTRL+A, D\033[0m."
    echo -e "If you use \033[1;31mCTRL+C\033[0m, the screen session will be terminated."

    echo "Select an action:"
    echo "1) First Start of Network3 Node"
    echo "2) Start Network3 Node"
    echo "3) Stop Network3 Node"
    echo "4) Restart Network3 Node"
    echo "5) View Network3 Node logs"
    echo "0) Exit"

    read -rp "Enter your choice: " choice

    case $choice in
        1)
            first_start_network3
            ;;
        2)
            start_network3
            ;;
        3)
            stop_network3
            ;;
        4)
            restart_network3
            ;;
        5)
            view_logs_network3
            ;;
        0)
            echo "Exiting the script..."
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
