count=$(curl -u rodolfo@talentua.com:daqkhgvlpkdqimqi --silent "https://mail.google.com/mail/feed/atom" | grep -oP '(?<=<fullcount>).*(?=</fullcount>)')

echo -e "%{F#dfdfdf}\u2709 $count"
