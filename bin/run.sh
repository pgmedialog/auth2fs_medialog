#!/bin/sh

rundir=`dirname ${BASH_SOURCE[0]}`
#SecretKeyGen
LIB_DIR=$rundir"/lib/*"
LIBS=`echo ${LIB_DIR} | sed -e "s/ /:/g"`


#echo $LIBS:${rundir}/otp;
java -cp ${LIBS} otp.GoogleOTPAuth $1 $2 $3 $4 $5 $6 $7 $8
#java -cp ${LIBS}:./otp $1 $2
