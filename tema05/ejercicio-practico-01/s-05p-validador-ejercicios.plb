whenever sqlerror exit rollback
create or replace procedure spv_clean wrapped 
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
26c 13c
a1aAlQxrMiIdnYbhOYjVK4vpDscwg/CzLgwdNXQ5cHJzlMf2mRyfHupjsIpZn/2jF+j6R7S6
FgYuohbS/gWeo0Szvp2uMLeiy29MySH4xNYi7Xq7h0nMA8oSMGdeqc3TMN8qFMl37mc/kV/b
UUqEdzZVq0mGd6DFFuavCtY2htlO4ykG6nxegNOoMWzCg48Sq8V3PXhc850rraeAv1bGY/Jo
fRsL1BhdO28GiTg7p7TJ8pSLuR7yXfi4o9ruYTn/qhXmzlRruSpBvNWba/lbeYyktD3dqBL+
3tVUChBw5Ldrv21tv8625Zo=

/
show errors
create or replace procedure spv_check_tables wrapped 
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
19c9 629
kzBvOKODFPNx7eQs6otIVJ4FvZYwg9d1VUgTWo7G/nuuf78U1aDCpMQFVRaN1HwbjAS4FzlJ
VRPzDd6s/LTzj4ouQX4g/pUj3XALdAS6azuJWsnJVw+dtW771Ec847l8rBXBH60Q0uiakV0/
WBLuOlR7bnyZEzYufOtIfB5Mypdy/y/sha7LOE94hsG7e5BtCpHmA6QMytl/W0Y7gFM3bLC1
yO2vqO+i7Nugrwk//9v+wHROMCHCKlbjvIJtstbzHUC3KuGC1uet1HQTEwEXHeBpmSuMA2gs
LGrXdgnTL12Ff2JBDAiBXDqE9UXxtv8meaGkmdhNLb0aaUxDpSTCsnUvdxQnn5yXRG/L6u7A
5nUnTjDmpMYqQ3GkBVkWcOHFA0qpaLbX8zbM6xR7Ao7IrOYguS7vIUzib7M6ux+FD6IM0v5O
Cx9s/5052UkaNLy5YKs1GmsfQPnAqBdIXRsMtRDS4SiKRJaHuDsWe1Na5bAWhUxHyCSEsU2Z
1ZSiYjgXTeKfxcdBSj+KTZfGSlHonN6odf6PB8xLdKho6eBLbUGnA2zsQoKq/BXQldNCmXVf
4VOe7njTn2tNH1jGf9ZXGhATOkbbULxbw/Vr5G7AwFA6SGISIHHZGXuzKZspMbJmnZAnudrM
P6hCh7xSoZYFnMFDZMVy+f2xwrXvXTFk9xeG0Rm3e0MLVqD9FXD3Khpg4o0gwVOet2+zNkb9
/qUUuTKCsKuh2r+ozwJn2wreoJ5x42Xnqehtyisfjfg7XoQNBPx3afxJSfRYLCKY825dNecA
Yyv7VR50I8ThquYbF/Psd8uBNiNcBpUlNU76W1vfvJIoCjsw/Jm0BLUB//JKEsCHuqJoMYrf
2sQucEqywnOo1zflzOitw7gmf9N4Fo387zDcazwIGLS9Y7I+ildUljvuVQWluZQwurW1/l1E
Uv2Er8nqkm0fv7kXyG2+dg66inSUDRFZDZaxYtziTw0YcB6pZeGuCnGlsloyj6VysPNiQLM5
d1HQ1nH4/eJzhr6nkaAHYdAVgHilySlCXubEwtHw+51tmj528R0TcR78pOjmlGHdjK7GTpfY
QdQmb17JkspBg9Zh+2txyz0HKTOLAN8SKhFHXe1uaRt2evHeXkezoYAlzcQ/+/K/7oNVs9gz
7Q0tmDPtoMtLIS23aTyJTX93JHjQEXergwit1YVzQIrw10Q0hRv+FLu+ZT9z10hQ0LCj7uKy
oJTiy5s7P8snpsR7nbfnLMXqC0csn7IuFr7ZBCBSyZrFFDwyb6oDBH3A+FLvTKe5J3mivZHT
qj1UBfuNkQsmjVNifmB0QNeGQwlvn/2jPk7r4mnFZdqhbA1cJ1b3nWGP3ZdgpJ/kDfZuWnCp
DbrWNWdFxQQ8hchK3BGKRCRibpVEKM2saK7BFEBcXN4YZAX3unpYO3TgNE89evqgYx9NHNfC
aN6ksxRBtr/eJsRomLkfv5LNqKaM+gcVKyibzukwsUzmLcIcsFoGZ1L9mYzVB9/vJFQEY9y6
tmBYxMA4zqij2ItOT2ZK5exuFEqX4bYMnZLN2khLwGs=

/
show errors
Prompt conectando como sys para iniciar Validación
connect sys/&&p_sys_password as sysdba
Prompt Realizando limpieza..
exec spv_clean('&&p_username');
Prompt invocando script s-01-config-compartido.sql
start s-01-config-compartido.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-02-conexiones.sql
start s-02-conexiones.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-03-consultas.sql
start s-03-consultas.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-04-procesos.sql
start s-04-procesos.sql
set serveroutput on
set linesize window
exec spv_print_header
host sha256sum &&p_script_validador
exec spv_check_tables('&&p_username')
define suffix='_shared'
exec spv_print_ok('Probando modo compartido @&&p_instance_name&&suffix');
connect sys/&&p_sys_password@&&p_instance_name&&suffix as sysdba
set serveroutput on 
exec spv_print_ok('Test modo conpartido @&&p_instance_name&&suffix');
define suffix='_dedicated'
exec spv_print_ok('Probando modo conpartido @&&p_instance_name&&suffix');
connect sys/&&p_sys_password@&&p_instance_name&&suffix as sysdba
set serveroutput on
exec spv_print_ok('Test modo conpartido @&&p_instance_name&&suffix');
exec spv_print_ok('Validación concluida');
exit