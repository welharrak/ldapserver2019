# Pràctica LDAP: ACLs / Access Control Lists
## M06-ASO Curs 2018-19
## UF1 Administració avançada

## Documentació:
- Consultar la documentació de Openldap: Administator’s guide capítol 8 Access
Control.

- Consultar la documentació  Mastering OpenLDAP, capítol 4 apartat “ Controlling Authorization with ACLs ”.

## Implementar a la base de dades edt.org les següents ACLS:
1. L’usuari “Anna Pou” és ajudant de l’administrador i té permisos per modificar-ho tot. Tothom pot veure totes les dades de tothom.
> olcAccess: to * by dn.exact="cn=Anna Pou,ou=usuaris,dc=edt,dc=org" write by * read

2. L’usuari “Anna Pou” és ajudant d’administració. Tothom es pot modificar el seu propi mail i homePhone. Tothom pot veure totes les dades de tothom.
> olcAccess: to * by dn.exact="cn=Anna Pou,ou=usuaris,dc=edt,dc=org" write by * read
> olcAccess: to attrs=mail by self write
> olcAccess: to attrs=homePhone by self write

3. Tot usuari es pot modificar el seu mail. Tothom pot veure totes les dades de tothom.
> olcAccess: to attrs=mail by self wite
> olcAccess: to * by * read

4. Tothom pot veure totes les dades de tothom, excepte els mail dels altres.
> olcAccess: to attrs=mail by self read
> olcAccess: to * by * read
