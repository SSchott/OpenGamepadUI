extends Object
class_name BluetoothManager

# Start bluetooth
#  sudo systemctl start bluetooth

# Scan
#  bluetoothctl --timeout 15 scan on
#  william@bravo:~ $ bluetoothctl --timeout 15 scan on
#  Discovery started
#  [CHG] Controller AA:FF:DD:16:4C:BB Discovering: yes
#  [NEW] Device FC:69:47:7C:9D:A3 one
#  [NEW] Device FC:69:47:7C:9D:A3 two
#  [NEW] Device FC:69:47:7C:9D:A3 three

# Make your Bluetooth adapter discoverable to others
#  bluetoothctl --timeout 30 discoverable on

# Pair 
#  bluetoothctl pair FC:69:47:7C:9D:A3
 
# Connect to already paired 
#  bluetoothctl connect FC:69:47:7C:9D:A3
 

# Show devices in range after scan
#  william@bravo:~ $ bluetoothctl devices
#  Device FC:69:47:7C:9D:A3 Some Device

# Unpair 
#  bluetoothctl remove FC:69:47:7C:9D:A3
 
