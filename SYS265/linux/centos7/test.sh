#secure-ssh.sh
#author bfretz
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
echo "Howdy there brotherman, we're gonna create you a secure passwordless SSH user"
read -p "What would you like the name of your new account to be? " name
sleep 1
echo -ne '\n' | sudo adduser "$name" --disabled-password
echo "Alright sounds good, an account named $name has been created"
sleep 1

echo "Setting user in sudo group"
sudo usermod -aG sudo "$name"
echo "$name ALL=(ALL:ALL) ALL" | sudo EDITOR='tee -a' visudo

echo "Creating home directory .ssh folder"
sudo mkdir /home/"$name"/.ssh/
sudo chsh -s /bin/bash "$name"
echo "Done"

echo "Copying public RSA key from repository"
sudo cp /home/bfretz/Classwork/SYS265/linux/public-keys/id_rsa.pub /home/"$name"/.ssh/authorized_keys
echo "Done"

echo "Setting correct permissions"
sudo chmod 700 /home/"$name"/.ssh
sudo chmod 600 /home/"$name"/.ssh/authorized_keys
sudo chown -R "$name":"$name" /home/"$name"/.ssh
echo "Done"


