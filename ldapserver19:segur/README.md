# LDAPS: Accés segur al servidor LDAP
## Ha d’utilitzar els seus propis certificats digitals i ha de permetre tant connexions ldaps com connexions ldap amb starttls.
## Utilitzarem sempre una autoritat de certificació CA anomenada Veritat Absoluta, que és qui emetrà tots els certificats per a l’organització edt.org. Aquí caldrà un certificat de servidor ldap.edt.org
## Un client ldap ha de poser-se conectar al servidor ldap usant ldaps connectant al port privilegiat, però també usant ldap (port insegur) i usant startls per generar una connexió segura.

  
