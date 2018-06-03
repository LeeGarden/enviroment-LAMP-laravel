#https://www.faqforge.com/linux/set-monday-first-day-week-unity-calendar-ubuntu/

#1. View locale default with command
sudo nano /etc/default/locale

#2. In line LC_TIME 
#LC_TIME="en_US.UTF-8"

#3. Edit locale file with value LC_TIME
#=> value = en_US
#Run command to edit file with value
sudo nano /usr/share/i18n/locales/en_US

#4. add "first_weekday 2" before line "END LC_TIME"
#(1-> Sunday| 2-> Monday | 3->Tuesday ....)

#5. Refresh new config locale
sudo locale-gen




#DELETE sudo sed 's/first_weekday .*/first_weekday 2/' -i /usr/share/i18n/locales/${LANG%.UTF-8}


