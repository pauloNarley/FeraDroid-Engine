#!/system/bin/sh
### FeraDroid Engine v0.25 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
KERNEL=$($B uname -r);
ARCH=$($B uname -m);
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
ROM=$(getprop ro.build.display.id);
SDK=$(getprop ro.build.version.sdk);
SF=$($B df -Ph /system | $B grep -v ^Filesystem | $B awk '{print $4}');
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq);
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
AXI=$($B cat /sys/power/cpufreq_max_axi_freq);
LOG=/sdcard/Android/FDE_log.txt;
TIME=$($B date | $B awk '{ print $4 }');
setprop ro.feralab.engine 25;
svc power stayon true;
$B sleep 90;
$B rm -f $LOG;
$B touch $LOG;
if [ -e $LOG ]; then
 $B echo "LOG - OK";
 CONFIG=/sdcard/Android/FDE_config.txt;
else
 LOG=/data/media/0/Android/FDE_log.txt;
 CONFIG=/data/media/0/Android/FDE_config.txt;
fi;
$B rm -f $LOG;
$B touch $LOG;
$B chown 0:0 $LOG;
$B chown 0:0 $CONFIG;
$B chmod 777 $LOG;
$B chmod 777 $CONFIG;
$B sleep 1;
{
 $B echo "### FeraLab ###"
 $B echo ""
 $B echo "[$TIME] FeraDroid Engine v0.25"
 $B echo "[$TIME] Firing up.."
 $B echo "[$TIME] Device: $(getprop ro.product.brand) $(getprop ro.product.model)"
 $B echo "[$TIME] Architecture: $ARCH"
 $B echo "[$TIME] RAM: $RAM MB"
 $B echo "[$TIME] MAX CPU freq: $((MAX/1000))Mhz"
 $B echo "[$TIME] MIN CPU freq: $((MIN/1000))Mhz"
 $B echo "[$TIME] Current CPU freq: $((CUR/1000))Mhz"
 $B echo "[$TIME] CPU Cores online: $CORES"
 if [ -e /sys/power/cpufreq_max_axi_freq ]; then
  $B chmod 664 /sys/power/cpufreq_max_axi_freq
  $B echo "[$TIME] CPU max AXI freq: $AXI MHz"
 fi;
 $B echo "[$TIME] Kernel version: $KERNEL"
 $B echo "[$TIME] ROM version: $ROM"
 $B echo "[$TIME] Android version: $(getprop ro.build.version.release)"
 $B echo "[$TIME] SDK: $SDK"
 $B echo "[$TIME] SElinux state: $(getenforce)"
 $B echo "[$TIME] /system free space: $SF"
} >> $LOG;
$B echo "[$TIME] Mounting partitions as RW.." >> $LOG;
$B mount -o remount,rw /data;
$B mount -o remount,rw /system;
if [ -e /sbin/sysrw ]; then
 $B echo "[$TIME] Remapped partition layout detected.." >> $LOG;
 /sbin/sysrw;
fi;
$B mount -t debugfs debugfs /sys/kernel/debug;
$B mount -t debugfs none /sys/kernel/debug;
sync;
if [ -e /engine.sh ]; then
 $B echo '50' > /sys/class/timed_output/vibrator/enable;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
else $B echo 50 > /sys/devices/virtual/timed_output/vibrator/enable;
 am start -a android.intent.action.MAIN -e message 'FDE v0.25 - firing up..' -n com.rja.utility/.ShowToast;
fi;
if [ -e /system/engine/prop/firstboot ]; then
 $B echo "[$TIME] First boot after deploy" >> $LOG;
 $B rm -f $CONFIG;
 $B cp /system/engine/bin/boost /system/xbin/boost;
 $B cp /system/engine/bin/dynbsd /system/xbin/dynbsd;
 $B chmod 777 /system/xbin/boost;
 $B chmod 777 /system/xbin/dynbsd;
 $B cp /system/engine/assets/FDE_config.txt $CONFIG;
fi;
TIME=$($B date | $B awk '{ print $4 }');
if [ -e $CONFIG ]; then
 $B echo "[$TIME] Loading FDE_config.." >> $LOG;
 $B rm -f /system/engine/assets/FDE_config.txt;
 $B cp $CONFIG /system/engine/assets/FDE_config.txt;
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B echo "[$TIME] Set SElinux permissive.." >> $LOG;
 $B chmod 666 /sys/fs/selinux/enforce;
 setenforce 0;
 $B echo 0 > /sys/fs/selinux/enforce;
 $B chmod 444 /sys/fs/selinux/enforce;
fi;
$B echo "[$TIME] Correcting permissions.." >> $LOG;
$B chmod 644 /system/build.prop;
$B chmod -R 777 /cache/*;
$B chmod -R 777 /system/engine/*;
$B chmod 777 /system/engine/assets/*;
$B chmod 777 /system/engine/gears/*;
$B chmod 777 /system/engine/prop/*;
$B rm -f /system/etc/sysctl.conf;
$B touch /system/etc/sysctl.conf;
$B chmod 777 /system/etc/sysctl.conf;
if [ -e /system/engine/gears/01network.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 NETWORK=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'network=1');
 if [ "network=1" = "$NETWORK" ]; then
  $B echo "[$TIME] Running Network gear.." >> $LOG;
  /system/engine/gears/01network.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/02cleaner.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 CLEANER=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'cleaner=1');
 if [ "cleaner=1" = "$CLEANER" ]; then
  $B echo "[$TIME] Running Cleaner gear.." >> $LOG;
  /system/engine/gears/02cleaner.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/03battery.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 BATTERY=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'battery=1');
 if [ "battery=1" = "$BATTERY" ]; then
  $B echo "[$TIME] Running Battery gear.." >> $LOG;
 /system/engine/gears/03battery.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/04vm.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 VM=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'vm=1');
 if [ "vm=1" = "$VM" ]; then
  $B echo "[$TIME] Running VM gear.." >> $LOG;
  /system/engine/gears/04vm.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/05gps.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 GPS=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'gps=1');
 if [ "gps=1" = "$GPS" ]; then
  $B echo "[$TIME] Running GPS gear.." >> $LOG;
  /system/engine/gears/05gps.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/06kernel.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 KERNEL=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'kernel=1');
 if [ "kernel=1" = "$KERNEL" ]; then
  $B echo "[$TIME] Running Kernel gear.." >> $LOG;
  /system/engine/gears/06kernel.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/07memory.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 MEMORY=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'memory=1');
 if [ "memory=1" = "$MEMORY" ]; then
  $B echo "[$TIME] Running Memory gear.." >> $LOG;
  /system/engine/gears/07memory.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/08cpu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 CPU=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'cpu=1');
 if [ "cpu=1" = "$CPU" ]; then
  $B echo "[$TIME] Running CPU gear.." >> $LOG;
  /system/engine/gears/08cpu.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/09gpu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 GPU=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'gpu=1');
 if [ "gpu=1" = "$GPU" ]; then
  $B echo "[$TIME] Running GPU gear.." >> $LOG;
  /system/engine/gears/09gpu.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/10adblocker.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 ADBLOCKER=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'adblocker=1');
 if [ "adblocker=1" = "$ADBLOCKER" ]; then
  $B echo "[$TIME] Running Ad-Blocker gear.." >> $LOG;
  /system/engine/gears/10adblocker.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/11ram.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 RAM=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'ram=1');
 if [ "ram=1" = "$RAM" ]; then
  $B echo "[$TIME] Running RAM gear.." >> $LOG;
  /system/engine/gears/11ram.sh | $B tee -a $LOG;
 fi;
fi;
if [ -e /system/engine/gears/end.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }');
 $B echo "[$TIME] END init.." >> $LOG;
 /system/engine/gears/end.sh;
fi;
sync;
$B sleep 1;
svc power stayon false;
TIME=$($B date | $B awk '{ print $4 }');
if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system;
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw;
 fi;
 $B rm -f /system/engine/prop/firstboot;
 $B echo "[$TIME] First boot completed." >> $LOG;
fi;
am kill-all;
$B sleep 2;
TIME=$($B date | $B awk '{ print $4 }');
$B mount -o remount,ro /system;
if [ -e /sbin/sysrwo ]; then
 /sbin/sysro;
fi;
if [ -e /engine.sh ]; then
 $B echo '96' > /sys/class/timed_output/vibrator/enable;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '96' > /sys/class/timed_output/vibrator/enable;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '96' > /sys/class/timed_output/vibrator/enable;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '255' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo '0' > /sys/class/leds/lv5219lg:rgb1:green/brightness;
else
 $B echo '96' > /sys/devices/virtual/timed_output/vibrator/enable;
 $B sleep 0.3;
 $B echo '96' > /sys/devices/virtual/timed_output/vibrator/enable;
 $B sleep 0.3;
 $B echo '96' > /sys/devices/virtual/timed_output/vibrator/enable;
 am start -a android.intent.action.MAIN -e message 'FDE status - OK' -n com.rja.utility/.ShowToast;
fi;
$B echo "[$TIME] FDE status - OK" >> $LOG;
$B echo "" >> $LOG;
if [ -e /engine.sh ]; then
 $B run-parts /system/etc/init.d;
fi;
