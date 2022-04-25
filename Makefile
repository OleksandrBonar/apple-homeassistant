run: install update

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	docker-compose restart

update:
	git pull
	docker-compose up -d

status:
	docker-compose ps

password:
	docker-compose exec mosquitto mosquitto_passwd -c /mosquitto/config/mosquitto.passwd mosquitto

install: install-before install-docker install-docker-compose install-motion
	sudo dnf clean all

install-before:
	sudo dnf -y install dnf-plugins-core

install-docker:
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf -y install docker-ce docker-ce-cli containerd.io
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo systemctl start docker
	sudo usermod -aG docker $(USER)

install-docker-compose:
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

install-motion:
	sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf -y install motion
	sudo systemctl enable motion.service
	sudo systemctl start motion
