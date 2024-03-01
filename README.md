# config-files
Some of my server configuration files

## Commands to run as unprivileged user

Create user:

```bash
sudo useradd -M -c "Application runtime" app
sudo usermod -aG app MYUSER
```

Create app directory

```bash
sudo mkdir /opt/SOMEAPP
sudo chown app:app /opt/SOMEAPP
sudo chmod 770 /opt/SOMEAPP
```