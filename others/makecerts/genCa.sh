#!/usr/bin/expect -f
set timeout 10
set PASSWORD "imbakn\r"
spawn ./CA.sh -root
expect "Enter PEM pass phrase:"
send $PASSWORD
expect "Verifying - Enter PEM pass phrase:"
send $PASSWORD
expect "Enter pass phrase for ./demoCA/private/./cakey.pem:"
send $PASSWORD
expect eof

spawn openssl x509 -in cacert.pem -out testca.crt
expect eof

spawn ./CA.sh -server
expect "Enter PEM pass phrase:"
send $PASSWORD
expect "Verifying - Enter PEM pass phrase:"
send $PASSWORD
expect "Enter pass phrase for ./demoCA/private/cakey.pem:"
send $PASSWORD
expect "Sign the certificate?"
send "y\r"
expect "1 out of 1 certificate requests certified, commit?"
send "y\r"
expect eof

spawn openssl x509 -in server.crt -out testserver.crt
expect eof

spawn ./CA.sh -client
expect "Enter PEM pass phrase:"
send $PASSWORD
expect "Verifying - Enter PEM pass phrase:"
send $PASSWORD
expect "Enter pass phrase for ./demoCA/private/cakey.pem:"
send $PASSWORD
expect "Sign the certificate?"
send "y\r"
expect "1 out of 1 certificate requests certified, commit?"
send "y\r"
expect eof 

spawn openssl x509 -in client.crt -out testclient.crt
expect eof

spawn openssl rsa -in client.pem -out testclientkey.pem
expect "Enter pass phrase for client.pem:"
send $PASSWORD
expect eof


