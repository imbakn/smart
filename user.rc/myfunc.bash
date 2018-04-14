xb()
{
    echo $1
    cd $1 
    source ~/myspace/java/env17
    source ./build/envsetup.sh 
}

xbd()
{
    xb /home/ubuntu/kuspace/android/qcom/XBD_QCOM_MSM8917
    lunch zqp1168_p2lite-userdebug
}


xbu()
{
    xb /home/ubuntu/kuspace/android/qcom/XBD_QCOM_ZQP1168_User
    lunch zqp1168_p2lite-user
}

