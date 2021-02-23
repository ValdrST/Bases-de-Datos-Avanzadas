create or replace procedure spv_valida_reset_params wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
2e4 288
hA+ObRaafFMCzokRcxsJK4xDz04wg3kJNUgFfC+KMWS0hKatAvNdSNKPtH72d6c2+p9K2+yj
raJsCe4JSOua0mJzVOoY8BpnMi+nAwOC2febZrrlPbxp3VWTTy0tlPxnWcy/BEsBVJx8WKZ2
0mUFsNpa/gVbXEdJt1uBAZDLkAl5d8BbCxKSCG88KdGYJWNzvoVhuFM+Ts/MVmEnsJ77LJ3F
LXpW3xIqBBoxyjQxWhf34sqUQYXdIX8QcCygMmQT6R5MZQzPH3n2qsxQO2QWWPq0pRTkaH0E
UOeJhVR3BOcqmV6pSV2wqqaxS2+hJQ0oYtR4WPxNqjb96byZGS+CLVBEO3lOo2HwSDQ6Infw
JCkLD7GOXcqLSrN09sDA2izr+igjzKfltC67JEwJWFVy4j19WIk2XV+/ZSw01n9CGK+Cev42
/4RV61DIKLYtKFShWzcSOfqVmZ6MSigzkaSX8b9pUDFlOQ45OTjAYZtp824gU5h9XqkfZ+i3
FjnoCrEW6SQ7VK0R26F9qj8PM/fdeXnXU69tfS33Ghoba2aiepe6cRnQXyM7F75xAh3MKyez
gbR0We6/FY1HdBnt2VaWXSQlMcTe8Z1jCBlzJPcELOFYFn6+pU1jJT3kag+rpk6F

/
show errors
set serveroutput on
exec spv_print_header
host sha256sum &&p_script_validador
Prompt El validador reiniciará la instancia para realizar la validación
pause  Presionar Enter para contunuar,  Ctrl -C para cancelar.
Prompt deteniendo la instanicia
shutdown immediate
Prompt Iniciando instancia
startup
pause Instancia iniciada, presionar Enter para iniciar
connect sys/&&p_sys_password as sysdba
set serveroutput on
host sha256sum &&p_script_validador
exec spv_print_ok('Iniciando la validación - restauración de parámetros');
exec spv_valida_reset_params 
exec spv_print_ok('Validación concluida');
exit