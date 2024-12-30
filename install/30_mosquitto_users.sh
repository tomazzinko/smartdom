# Mosquitto password file
set -e

su - $SMARTDOM_USER << EOF
  cd "$SMARTDOM_HOME"
  docker-compose up -d mosquitto
  docker-compose kill mosquitto 
EOF

cp $SMARTDOM_HOME/.config/mosquitto/passwd $SMARTDOM_HOME/.config/mosquitto/passwd.bak
mosquitto_passwd -U $SMARTDOM_HOME/.config/mosquitto/passwd.bak
chown 1000:1000 $SMARTDOM_HOME/.config/mosquitto/passwd.bak
chmod 700 $SMARTDOM_HOME/.config/mosquitto/passwd.bak

docker cp "$SMARTDOM_HOME/.config/mosquitto/passwd.bak" "mosquitto:/mosquitto/config/passwd"

