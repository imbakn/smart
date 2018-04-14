#! /bin/bash
if [ $# -lt 1 ]
then
	echo "please input key path"
	exit
fi
FILE_NAME=$1
PK8_NAME=$FILE_NAME.pk8
X509_NAME=$FILE_NAME.x509.pem
PRI_NAME=$FILE_NAME.pem
P12_NAME=$FILE_NAME.p12
JKS_NAME=$FILE_NAME.jks
NORMAL_NAME=$(basename $FILE_NAME)

STORE_PASS=123456
KEY_PASS=123456

echo "normal name: "$NORMAL_NAME

echo "change pkcs8 to normal pem"
openssl pkcs8 -in $PK8_NAME -inform DER -nocrypt -out $PRI_NAME  >/dev/null 2>&1
echo "generating $NORMAL_NAME.p12"
openssl pkcs12 -export -in $X509_NAME -inkey $PRI_NAME -out $P12_NAME -name $NORMAL_NAME -passin pass:$STORE_PASS -passout pass:$STORE_PASS  >/dev/null 2>&1
echo "generating $NORMAL_NAME.jks"
rm $JKS_NAME
keytool -importkeystore -srckeystore $P12_NAME -srcstoretype PKCS12 -srcstorepass $STORE_PASS -alias $NORMAL_NAME -deststorepass $STORE_PASS -destkeypass $KEY_PASS -destkeystore $JKS_NAME  >/dev/null 2>&1
rm $PRI_NAME $P12_NAME
echo "DONE"

