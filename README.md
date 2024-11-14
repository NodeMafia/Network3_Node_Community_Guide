# [Network3](https://account.network3.ai/register_page?rc=fdafa4fd). Another DePIN project with low server requirements.
*Disclaimer: The author of this guide, which is exclusively informational material, does not bear any responsibility for the actions of readers. There are no fraudulent or spam links in the guide. All materials were obtained from official sources, links to which can be found at the end of each guide. This post is copyrighted by Nod Mafia.*


![123332](https://github.com/user-attachments/assets/d334c632-96c1-405a-8e25-8c22ca5436ad)


Network3 is a revolutionary technology that builds a dedicated AI Layer2. It provides services to AI developers worldwide, helping them train and validate models quickly, conveniently. The project has an investment of $5,500,000 from investors such as SNZ Holding, Borderless Capital, Waterdrip and others

Node Requirements:

- Specifications: 1CPU/2RAM/60SSD - minimal
- OS: Ubuntu 22.04


## [Network3 Node](https://testnet.icn.global). Registration and installation

![image](https://github.com/user-attachments/assets/172a6154-5dc4-4c65-b052-519c672c3a11)


Go to the [Network3 site](https://account.network3.ai/register_page?rc=fdafa4fd) and register. At this point, these are all the interactions with the site. Let's move on to our server.

Start Ubuntu. Update all files and install the necessary applications

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y screen net-tools
```

If at this point you are prompted to restart some processes, select the last option “№. of them. no. of them” by specifying №.

Installing Network 3 Node

```
wget https://network3.io/ubuntu-node-v2.1.0.tar
```

Unzip the file and navigate to the /ubuntu-node folder

```
tar -xvf ubuntu-node-v2.1.0.tar
rm -rf ubuntu-node-v2.1.0.tar
cd ubuntu-node
```

Create a separate screen for a node 

```
screen -S network3
```

Run the script 

```
sudo bash manager.sh up
```

![image](https://github.com/user-attachments/assets/4abedc0e-02e0-453f-a47f-79c89f753e5e)


Now, we need to get our API Key, which we need to save. Copy it.

```
sudo bash manager.sh key
```

![N3-1](https://github.com/user-attachments/assets/a699d0a0-d908-4bae-bdbf-0945aadd79a6)


We need the copied key to synchronize our node with our browser account. Go to the link that was displayed to you after the command sudo bash manager.sh up - https://account.network3.ai/main?o=xx.xx.xx.xx:8080 (Replace xx.xx.xx.xx.xx with the ip of your server). Next, click on the “+” button and paste your API then click OK.

![N3-2](https://github.com/user-attachments/assets/e079fd60-e823-4973-b9a3-79c2f0cf974e)

To exit the screen use the key combination: 

```
CTRL+A, D
```
To open the screen:

```
screen -r network3
```

Congratulations you have connected node. In a few minutes you will be able to see your points and also the address of the server.



## [NodeMafia script fore Network3](https://raw.githubusercontent.com/NodeMafia/Network3_Node_Community_Guide/refs/heads/main/Network3Node_Setup.sh). Install, restart and track logs.

![image](https://github.com/user-attachments/assets/ff6e19c5-b266-4199-8a52-570f19dc691e)

You can also use our script to quickly install Network3 Node.

```
curl -sO https://raw.githubusercontent.com/NodeMafia/Network3_Node_Community_Guide/refs/heads/main/Network3Node_Setup.sh && chmod +x Network3Node_Setup.sh && ./Network3Node_Setup.sh
```

Functions:

1) First Start of Network3 Node
2) Start Network3 Node
3) Stop Network3 Node
4) Restart Network3 Node
5) View Network3 Node logs


# Links 
https://network3.ai

https://account.network3.ai/

## NodeMafia. We hope our content is useful for you.
![image](https://github.com/user-attachments/assets/e0dc7aee-f823-41d2-a406-9e8837778964)

GitHub: https://github.com/NodeMafia

Medium: https://medium.com/@nodemafia

Telegram: https://t.me/nodemafia

Teletype: https://teletype.in/@nodemafia

Twitter: https://x.com/NodeMafia
