#https://askubuntu.com/questions/508143/operation-not-possible-due-to-rf-kill-phy0-hard-blocked

sudo nano /etc/modprobe.d/blacklist.conf

#Add all line to End of file
blacklist wmi
blacklist asus-wmi
blacklist asus-nb-wmi
blacklist asus-nb-wmi
blacklist asus_nb_wmi
