#/bin/bash
global_replace_str=itof
echo "*****************************************"
echo "****replace_before=dmcam_****************"
echo "****replace_after =${global_replace_str}******************"
echo "*****************************************"

cd ../libdmcam/ && git checkout . && cd ../sdk_build/
declare -a arr
index=0
STR=$(cat ./source/Reference/C_C++/dmcam.h|tr -s ' '|sed "s/(/ /g"|sed "s/;/ /g"|sed "s/*/ /g"|sed "s/,/ /g"|sed "s/)/ /g"|sed "s/\./ /g"|sed "s#/# #g" )
for word in $STR;
do
    var1=`echo $word|grep dmcam_`;
    if [ "$var1" != "" ]; then
        arr[$index]=$var1
        echo "Need to replace api : "${arr[$index]}
        let index++;
    fi
done
echo ${arr[0]}
echo ${arr[1]}
echo ${arr[2]}
arr=($(echo ${arr[*]} |sed 's/ /\n/g'|sort|uniq))

declare -i length=${#arr[@]}
declare -i step=0
echo "length="$length

for ((step=0;step<length;step++));
do
    replace_before=${arr[${step}]}
    echo "replace_before="$replace_before
    replace_after=`echo $replace_before|sed "s/dmcam/$global_replace_str/g"`
    echo "replace_after="$replace_after
    sed -i "s/$replace_before/$replace_after/g" `grep -rl $replace_before ./source`
done

#replace dmcam.i 
#sed -i "13s/dmcam/$global_replace_str/g" ../libdmcam/swig/dmcam.i

#replace dmcam_api.map
#sed -i "3s/dmcam/$global_replace_str/g" ../libdmcam/dmcam_api.map


