
# Scrooge Deployment

## Setup Semplificato

1. Assicurarsi di avere "Docker Desktop" installato ed avviato sul PC 
2. Su windows, cliccare con il tasto destro sul file "setup-scrooge-environment.bat" nella root di questo repository e selezionare "Avvia come amministratore"
3. Attendere che vengano scaricate ed avviate su docker tutte le immagini necessarie
4. Recarsi su "https://www.scrooge.io"

## Setup Manuale dell'ambiente

Affinché l'app funzione correttamente, c'è la necessità di:
1. Aggiungere i domain names al file hosts
   ```
   127.0.0.1 api.scrooge.io sso.scrooge.io www.scrooge.io
   ```
2. Aggiungere i certificati SSL come CA root affidabili del computer
   - Windows: Fare doppio click su `_nginx\certs\scrooge.io.crt` e seguire il wizard
   - Unix: Dipende dalla distribuzione
   
- Nota: Assicurarsi di riavviare il browser e/o il computer. Se raggiungendo le pagine del progetto si riceve un errore del browser relativo al certificato non valido, non sarà possibile far funzionare correttamente il progetto

3. Avviare lo stack con docker compose, buildando le immagini necessarie, lanciando il seguente comando *dalla root di questo progetto*
   - docker compose scrooge-deployment up -d --build

## Link & indirizzi

Dopo l'installazione, se tutto è andato a buon fine, dovresti essere in grado di raggiungere i seguenti indirizzi:
* Frontend
  - https://www.scrooge.io
* Keycloak
  - https://sso.scrooge.io/
* Documentazione Backend
  - https://api.scrooge.io/swagger-ui/index.html