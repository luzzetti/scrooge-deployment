FROM postgres:17.2

# Copy initialization scripts
COPY sql/01-create-multiple-databases.sh /docker-entrypoint-initdb.d/

# Make sure the script is executable
RUN chmod +x /docker-entrypoint-initdb.d/01-create-multiple-databases.sh