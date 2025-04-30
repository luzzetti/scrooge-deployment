FROM postgres:17.2

# Copy initialization scripts
COPY sql/01-create-multiple-databases.sh /docker-entrypoint-initdb.d/

# Purtroppo, spesso, git cambia il line-separator da 'LF' in 'CRLF', e questo crea problemi.
# Infatti, se il file viene copiato nel docker-container con il separatore sbagliato, viene bellamente
# ignorato e NON eseguito. Facendo fallire il resto dello stack per via della mancata creazione dei database.

# Per ovviare a questo problema, mi vedo costretto ad installare dos2unix e cambiare automaticamente il formato del file
RUN apt-get update && apt-get install -y dos2unix && \
    dos2unix /docker-entrypoint-initdb.d/01-create-multiple-databases.sh && \
    chmod +x /docker-entrypoint-initdb.d/01-create-multiple-databases.sh