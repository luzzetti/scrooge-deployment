
# Scrooge Deployment

## Setup dell'ambiente

Affinché l'app funzione correttamente, c'è la necessità di:
1. Aggiungere i domain names al file hosts
2. Aggiungere i certificati SSL come CA root affidabili
3. Avviare lo stack con docker compose

### Automated Setup

We provide scripts to automate tasks 1 and 2 for both Windows and Unix systems:

#### Windows (CMD)
Run the batch file as Administrator:
```batch
setup-scrooge-environment.bat
```

#### Unix (Linux/macOS)
Run the shell script with sudo:
```bash
sudo ./setup-scrooge-environment.sh
```

### Manual Setup

If you prefer to set up manually:

1. Add the following line to your hosts file:
   ```
   127.0.0.1 api.scrooge.io sso.scrooge.io www.scrooge.io
   ```
   - Windows: `%windir%\System32\drivers\etc\hosts`
   - Unix: `/etc/hosts`

2. Add the SSL certificate to your trusted root CA store:
   - Windows: Double-click on `_nginx\certs\scrooge.io.crt` and follow the wizard
   - Unix: Varies by distribution (see the shell script for details)


After setup, you can access:
- https://www.scrooge.io
- https://sso.scrooge.io/
- https://api.scrooge.io/


