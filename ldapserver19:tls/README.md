# LDAPS: Accés segur al servidor LDAP
## Ha d’utilitzar els seus propis certificats digitals i ha de permetre tant connexions ldaps com connexions ldap amb starttls.
## Utilitzarem sempre una autoritat de certificació CA anomenada Veritat Absoluta, que és qui emetrà tots els certificats per a l’organització edt.org. Aquí caldrà un certificat de servidor ldap.edt.org
## Un client ldap ha de poser-se conectar al servidor ldap usant ldaps connectant al port privilegiat, però també usant ldap (port insegur) i usant startls per generar una connexió segura.

### Pasos al server:
1. Crear les claus necessaries pel certificat del servidor:
```
[root@ldap certs]# openssl genrsa -out ca-key.pem 1024
[root@ldap certs]# openssl genrsa -out server-key.pem 1024
```
![foto1](./aux/1.png)

2. Crear entitat CA propia (Veritat Absoluta):
```
[root@ldap certs]# openssl req -new -x509 -nodes -sha1 -days 365 -key ca-key.pem -out ca-crt.pem
```
![foto2](./aux/2.png)

3. Creem una petició de certificat request per enviar a l'entitat certificadora CA:
```
[root@ldap certs]# openssl req -new -key server-key.pem -out server-csr.pem
```
![foto3](./aux/3.png)

4. Creem/editem el fitxer de configuració de la generació de certificats, **ca.conf** (indica què certifiquen):
```
basicConstraints = critical,CA:FALSE
extendedKeyUsage = serverAuth,emailProtection
```

5. Hem de fer que l'autoritat CA signi el certificat:
```
[root@ldap certs]# openssl x509 -CA ca-crt.pem -CAkey ca-key.pem -req -in server-csr.pem -days 365 -sha1 -extfile ca.conf -CAcreateserial -out server-crt.pem
```
![foto4](./aux/4.png)

6. Una vegada creats els certificats, el copiem a **/etc/openldap/certs**; i afegim les següent línies al fitxer de configuració de ldap, **slapd.conf**:
```
[...]
# Allow LDAPv2 client connections. This is NOT the default.
allow bind_v2
pidfile               /var/run/openldap/slapd.pid
TLSCACertificateFile  /etc/openldap/certs/ca-crt.pem
TLSCertificateFile    /etc/openldap/certs/server-crt.pem
TLSCertificateKeyFile /etc/openldap/certs/server-key.pem
TLSVerifyClient       never
TLSCipherSuite        HIGH:MEDIUM:LOW:+SSLv2
[...]
```

7. Tot seguit, editem el fitxer **ldap.conf** (editem lo següent):
```
BASE dc=edt,dc=org
URI ldaps://ldap.edt.org

#TLS_CACERTDIR  /etc/openldap/certs  #cal comentar aquesta linia
TLS_CACERT /etc/openldap/certs/ca-crt.pem
```

8. Finalment, a l'hora de engegar el servidor ldap, hem d'utilitzar **-h** per a que faci diferents bind depenent del mètode que s'utilizi:
- **ldap:///** --> port 389
- **ldaps:///** --> port 636 (TLS)
```
/sbin/slapd -d0 -h "ldap:/// ldaps:///"
```

### Pasos al client:
1. Al client caldria editar el **ldap.conf**:
```
BASE    dc=edt,dc=org
URI     ldaps://172.17.0.2 #aqui posem la ip/servername del servidor ldap

TLS_CACERT /var/tmp/certs/ca-crt.pem  #ruta local on tinguem el certificat
TLS_REQCERT allow
```

### Comprobacions:
- **ldapserch -x -LLL -ZZ: sense certificat:**
![foto5](./aux/5.png)

- **ldapserch -X -LLL -ZZ: amb certificat:**
![foto6](./aux/6.png)

- **ldapserch -x -LLL -H ldap://172.17.0.2 (insegur):**
![foto7](./aux/7.png)

- **ldapserch -x -LLL -H ldaps://172.17.0.2 (segur):**
![foto8](./aux/8.png)

- **Utilitzant StartTls sense certificat:**
![foto9](./aux/9.png)

- **Utilitzant StartTls amb certificat:**
![foto10](./aux/10.png)
