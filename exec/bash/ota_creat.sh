#!/bin/base
echo "creat start!"

RELEASE=/home/em/dev/daily_image_release/par
if [ $# -eq 3 ]
    then
        old=$RELEASE/$1/*.zip
        new=$RELEASE/$2/*.zip
        echo $old
        echo $new
        ./build/tools/releasetools/ota_from_target_files -v -i  $old   -p out/host/linux-x86/ -k  build/target/product/security/testkey   $new   $3
    else
        echo "========================================================="
        echo "please put right charcter"
        echo "./ota_creat.sh  old_package_date   new_package_date  targert_update.zip"
        echo "example:  ./ota_creat.sh  140219   140220  update.zip"
        echo "========================================================="
fi
echo "creat end"

