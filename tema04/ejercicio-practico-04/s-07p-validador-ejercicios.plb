whenever sqlerror exit rollback
create or replace procedure spv_clean wrapped 
a000000
367
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
d7 ca
SU+6fofer2vd9xypNInQtrRLjhIwg/BHAJ4VZy85aR5u4EUUcGstWSr6P/zmMwcxiqw9yuBJ
ZudBmvKiLaWmu+m971lvUHMzUOtDzzTfzMesMJ8OFWW5k0WnflEn3f+SGBaVUWDmd1gHvS4A
ZDz8j6x2iURu/EOYEfhPDhI3hRXcma6ItVPXsAM//byONCkfrhMQ2js=

/
show errors
create or replace procedure spv_check_tables_usr_local wrapped 
a000000
367
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
15ea 75d
m1x2VNN84qNi2feRGz8ClnFQJJUwg9fqVUgGYI65Kq5/v0AnjvsxeQqRNcBwcFXh6N+iMSs9
EeG25pmfkRPSgEJYEEAZgd+WPIZYLYi18X49SGPjtMF2LHI6vE7XiHKkEmdADAcOpe734rk6
/B+rLQWkKCmodH3/Dy1Mx9yc0VLJi4kO9uuINHiQSJmTSIw3UCpzP6FuKCbtOmFVSEyext2H
/28RYW6H84CjaC2hTB5bCXxKduZ9iVl5hRr46IuykNaablmKN77Kal+xdtCkZTkD45N1/3VW
fWj1R96rPFNmC/Y5s02o+Witeovmf5lUGZGtkL6jUq6u1DFRVcyZa+iEWbHdCGqFS0C0KrBO
vWuEMKifhVDo6tmz41dRZtjiW4uPAPdvH4/KhHvEzfQh46K3MI3sCLpOg3dItka4y5RxZ+bo
CkDdpp3KZtFCuVQDRA2d9qsUX6xqxXs2dDvkyo8K42tbOb8CFe448NRtHCfGMWBhHd/23xR4
hexr/zExrey0MzSop7f1HaJtEqbRXdowvZ54X0AFJFdKlrnh/ylBu3OPvzQXnbNbSy1MaPbz
DwuBFOZ+A73OOX5myuCvQIAhh4qHAn7thYAfKP6kdCRVzsF6+UKMaL83nYDU616n7ueejbvo
Vo9Ww6+dGU6pjM2rgQZfIPAMOB8kXUB0p5ms2CmJdGKm2ju2aQ0NvNQCSNwYPt4BcQXdDLHs
8LYalmxFxot5J6P8/i8Ry1gDa+JLv+3cmPg5/ctO3yKS82a4fs76V+IWTA1S158/phHlSqUB
gBqJocOmWg1uPAFFbgsL+naBiC+XwRZkDJrLDjRKh5C5ErH4kgogJavaeXTEOp4yZSeePbqb
LD0SZswtjwYcSQwrXIWXbTWwJ5YzuumB6fs/wHOW8lyiDmA5bGl3ok8VGpKzhuheNwmBh9Ip
uO3RSRRspmc0MRgTnC4DSMImbWUpDa2T8eVr6GZs0eDhJgyzgD6flxZtRyi+tk55MGPwhbHQ
TZsno70clfCDLwrDghFDLDRNOgEeV3irMgtRE1+9Nb0QkZgdnOvm/xjoj03WBkg3Cnhi7gsZ
qybBFIxNKGJo3BA48ip6zyGZMRpzadMvGWqgo+tbmpr0ACqGaJUIlLxPMe/ZRWn8upollNaE
D/xl4E/sJ+ClmREqDZ8SlzeYV75lOby/xFWmOArNTk8co8f03W+j5C86+MHQs5+VyMHZH8fI
px9Eftf/yNnzKCww3UhYB0Xnl5rh+D/ncUIRW7WEhZhDh9uE0gQM4wcfZqHLzxpQZAKdnrXr
NneCaQw1YluUFOfMjvUIZYm2+s/RXOffRSfaYsL3FfFJhIwm7NA/3+js9yPy/K0mymNZBEVl
eyZle5bMQHdwWXYdGcM+nlYEGhwFpQDSENirTHzAsQDlORTI44sayfUn8nU+H6HcIkOgXRQz
tW/yABlFP/Fk1HIODk6x1RYeV+nDrV5zo/uBHjaJMsm+/LUMkvsZy37+mvTBNMxy+vZbz7kR
aZVgpB8qWYlOpaPXbhVTV7iHuFYAchxd2DGF3MtjA0OOxjdUbrmlyF9HQ5GociO0wD0Acb7b
Y14SEfBWTifTmGgoRe6BsNnC6SbWvyk5aUm1xQhPF5WdgbnkYGbP0M01cxwnq2C8lHQd/WDi
REZiDO33qRFnjW7NanHSLXiVeej0MgzkqJyjXNRZSfqBzv0jElOYhjXsej9pkrpgza3C6yKX
7ZD8TDLdTg8Sy/FGG3oc5w0oZblrCcoNhhpJZUPSdPdyLP563L/ML/3/1VnRG22WYERxLRsw
blVvS4Mam3UG2MXu1z7IZboY4GMr77l5seFrCRRKLOxRN+6YCJttnfsLvFHa

/
show errors
Prompt conectando como sys para iniciar Validación
connect sys/&&p_sys_password as sysdba
Prompt Realizando limpieza..
exec spv_clean('&&p_nombre'||'0404');
Prompt invocando script s-01-objetos-iniciales.sql
start s-01-objetos-iniciales.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-02-obten-datos-reinicio.sql
start s-02-obten-datos-reinicio.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-03-carga-maxima.sql
Pause 'La instancia será reiniciada. Presione Enter para continuar, Ctrl c para cancelar.'
start s-03-carga-maxima.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-04-automatic-shared.sql 
start s-04-automatic-shared.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-05-manual-shared.sql 
start s-05-manual-shared.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-06-automatic-memory.sql 
start s-06-automatic-memory.sql 
set serveroutput on
set linesize window
exec spv_print_header
host sha256sum &&p_script_validador
exec spv_check_tables_usr_local('&&p_username')
exec spv_print_ok('Validación concluida');
exit