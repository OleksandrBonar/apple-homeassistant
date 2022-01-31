run: install update

start:
	sudo docker-compose start

stop:
	sudo docker-compose stop

restart:
	sudo docker-compose restart

update:
	sudo docker-compose up -d

status:
	sudo docker-compose ps

password:
	sudo docker-compose exec mosquitto mosquitto_passwd -c /mosquitto/config/mosquitto.passwd mosquitto

install:
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf -y install docker-ce docker-ce-cli containerd.io
	sudo dnf clean all
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo systemctl start docker
	sudo usermod -aG docker $(USER)
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
