

https://www.scrooge.lan
https://sso.scrooge.lan/

https://superuser.com/questions/463081/adding-self-signed-certificate-to-trusted-root-certificate-store-using-command-l


Aggiungere al file-host:
127.0.0.1	api.scrooge.lan sso.scrooge.lan www.scrooge.lan

Aggiungere il certificato alle ca-root affidabili

Modificare il file _postgres/sql/01-create-multiple-databases.sh
su windows: impostare LF come carattere terminatore
su mac: Impostare i permessi (wip)
su unix: Non dovrebbe servire alcuna modifica



todo:
[] Configs: KC self registration
[] Configs: KC email as username