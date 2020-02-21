#secure-ssh.sh
#author bfretz
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
echo "Howdy there brotherman, we're gonna create you a secure passwordless SSH user"
read -p "What would you like the name of your new account to be? " name
sleep 1

sudo useradd -m -d /home/"$name" -s /bin/bash "$name"
echo "Alright sounds good, an account named $name has been created"
sleep 1

echo "Creating home directory .ssh folder"
sudo mkdir /home/"$name"/.ssh
echo "Done"

echo "Copying public RSA key from repository"
sudo cp /home/bfretz/Classwork/SYS265/linux/public-keys/id_rsa.pub /home/"$name"/.ssh/authorized_keys
echo "Done"

echo "Setting correct permissions"
sudo chmod 700 /home/"$name"/.ssh
sudo chmod 600 /home/"$name"/.ssh/authorized_keys
sudo chown -R "$name":"$name" /home/"$name"/.ssh
echo "Done"


