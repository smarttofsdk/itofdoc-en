#/bin/bash
global_replace_str=itof
echo "*****************************************"
echo "****replace_before=dmcam_****************"
echo "****replace_after =${global_replace_str}******************"
echo "*****************************************"

#cd ../libdmcam/ && git checkout . && cd ../sdk_build/
declare -a arr
index=0
STR=$(cat ../../sdk/libdmcam/src/dmcam.h.in|tr -s ' '|sed "s/(/ /g"|sed "s/;/ /g"|sed "s/*/ /g"|sed "s/,/ /g"|sed "s/)/ /g"|sed "s/\./ /g"|sed "s#/# #g" )
for word in $STR;
do
    var1=`echo $word|grep dmcam_`;
    var2=`echo $word|grep DM_`;
    var3=`echo $word|grep DMCAM_`;
    if [ "$var1" != "" ]; then
        arr[$index]=$var1
        echo "Need to replace str : "${arr[$index]}
        let index++;
    fi

    if [ "$var2" != "" ]; then
        arr[$index]=$var2
        echo "Need to replace str : "${arr[$index]}
        let index++;
    fi

    if [ "$var3" != "" ]; then
        arr[$index]=$var3
        echo "Need to replace str : "${arr[$index]}
        let index++;
    fi
done

arr=($(echo ${arr[*]} |sed 's/ /\n/g'|sort|uniq))

declare -i length=${#arr[@]}
declare -i step=0
echo "length="$length

for ((step=0;step<length;step++));
do
    replace_before=${arr[${step}]}
    echo "replace_before="$replace_before
    result1=$(echo $replace_before|grep "dmcam_")
    result2=$(echo $replace_before|grep "DM_")
    result3=$(echo $replace_before|grep "DMCAM_")
    echo "result1="$result1
    echo "result2="$result2
    echo "result3="$result3
    if [ "$result1" != "" ]; then
        replace_after=`echo $replace_before|sed "s/dmcam_/itof_/g"`
    fi
    if [ "$result2" != "" ]; then
        replace_after=`echo $replace_before|sed "s/DM_/IT_/g"`
    fi
    if [ "$result3" != "" ]; then
        replace_after=`echo $replace_before|sed "s/DMCAM_/ITOF_/g"`
    fi

    echo "replace_after="$replace_after
    sed -i "s/$replace_before/$replace_after/g" `grep -rl $replace_before ./source`
done

#replace dmcam.i 
#sed -i "13s/dmcam/$global_replace_str/g" ../libdmcam/swig/dmcam.i

#replace dmcam_api.map
#sed -i "3s/dmcam/$global_replace_str/g" ../libdmcam/dmcam_api.map


