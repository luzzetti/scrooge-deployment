FROM adorsys/keycloak-config-cli:6.2.1-23

# Copy Keycloak configuration files
COPY conf/001-create-realm-with-client.json /config/
COPY conf/002-create-user-and-admin-role.json /config/
COPY conf/003-create-test-users.json /config/