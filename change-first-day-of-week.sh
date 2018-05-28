#https://www.faqforge.com/linux/set-monday-first-day-week-unity-calendar-ubuntu/

sudo sed 's/first_weekday .*/first_weekday 2/' -i /usr/share/i18n/locales/${LANG%.UTF-8}

sudo locale-gen

killall unity-panel-service

