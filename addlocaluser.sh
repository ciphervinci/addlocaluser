#! /bin/bash

#Purpose : Use to add new users in Linux
#Author : Rishikesh

#Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -eq 0 ]]
then
	echo 'Checking root !'
	echo 'OK'
else
	echo 'Please execute the script with sudo or as root !'
	exit 1
fi

#Get the username (login)

read -p 'Enter the username to create: ' USER_NAME

#Get the real name (contents for the description field)

read -p 'Enter the real name of the user: ' COMMENT

#Get the password

read -p 'Enter the password: ' PASSWORD

#Create the user with the password

useradd -c "${COMMENT}" -m ${USER_NAME}
echo "${USER_NAME}:${PASSWORD}" | chpasswd

#Check to see if the useradd command succeeded

if [[ "${?}" -eq 0 ]]
then
	echo 'User created successfully !'
else
	echo "Something went wrong ! error ${?}"
	exit 1
fi

#Force password change on first login

passwd -e ${USER_NAME}

#Display the username, password, and the fost where the user was created

echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Host: $(hostname)"
