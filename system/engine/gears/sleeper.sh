#!/system/bin/sh
### FeraDroid Engine v0.25 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SDK=$(getprop ro.build.version.sdk);
LOG=/sdcard/Android/FDE_log.txt;
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
if [ -e $LOG ]; then
 $B echo "LOG - OK";
else
 LOG=/storage/emulated/0/Android/FDE_log.txt;
fi;
if [ "$SDK" -le "19" ]; then
 FS=false;
 TR=true;
 GR="mScreenOn";
else
 FS=FF;
 TR=N;
 GR="state=O";
fi;
sync;
ON=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'sleeper=1');
if [ "sleeper=1" = "$ON" ]; then
 $B echo "Sleeper daemon is active." >> $LOG;
 while true; do
  until [ "$FS" = "$(dumpsys power | $B grep $GR | $B grep -o "$FS")" ]; do
   $B sleep 120;
   if [ "$MAX" -ge "2000000" ]; then
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   else
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   fi;
  done;
  if [ "$FS" = "$(dumpsys power | $B grep -E $GR | $B grep -o "$FS")" ]; then
   $B sleep 9;
   RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
   if [ "$RAMfree" -le "64" ]; then
    sync;
    $B sleep 1;
    $B echo "3" > /proc/sys/vm/drop_caches;
    $B sleep 2;
   fi;
   $B killall -9 com.google.android.gms.persistent;
   service call activity 51 i32 0;
   $B sleep 1;
   am kill-all;
   $B sleep 3;
   BA=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'lowbatt=' | $B sed -e "s|lowbatt=|""|");
   DT=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'internet_control=1');
   if [ "$($B cat /sys/class/power_supply/battery/capacity)" -le "$BA" ]; then
    if [ "internet_control=1" = "$DT" ]; then
	   svc data disable;
     svc wifi disable;
    fi;
    svc nfc disable;
    svc power stayon false;
    service call bluetooth_manager 8;
    settings put global bluetooth_on 0;
    setprop ro.com.google.networklocation 0;
    am broadcast -a android.intent.action.BATTERY_LOW;
   fi;
   H=$($B pgrep -l '' | $B grep -E "launcher" | $B awk '{print $1}');
   L=$($B pgrep -l '' | $B grep -E "home" | $B awk '{print $1}');
   P=$($B pgrep -l '' | $B grep -E "phone" | $B awk '{print $1}');
   D=$($B pgrep -l '' | $B grep -E "dialer" | $B awk '{print $1}');
   T=$($B pgrep -l '' | $B grep -E "trebuchet" | $B awk '{print $1}');
   renice [-17] "$H";
   renice [-17] "$L";
   renice [-17] "$P";
   renice [-17] "$T";
   renice [-17] "$D";
   renice [-15] "$(pidof netd)";
   if [ "$MAX" -ge "2000000" ]; then
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "400" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   elif [ "$MAX" -ge "1700000" ]; then
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "300" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   elif [ "$MAX" -ge "1400000" ]; then
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
	 $B echo "200" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   elif [ "$MAX" -lt "1400000" ]; then
    if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/sprdemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/powersave_bias;
    fi;
    if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias ]; then
     $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/powersave_bias;
    fi;
   fi;
   service call activity 51 i32 -1;
   until [ "$TR" = "$(dumpsys power | $B grep $GR | $B grep -o "$TR")" ]; do
    $B sleep 360;
   done;
  fi;
 done;
else
 $B echo "Sleeper daemon is not active." >> $LOG;
fi;
