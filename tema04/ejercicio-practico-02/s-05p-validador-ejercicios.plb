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
a3 c2
s9LX/MQYU3li9seFzU3bPsJ9/Kgwg5nnm7+fMr2ywFwW0RZtrv+hLkfr5+Mosp+ym8fSMlzn
x3TAM7h0ZSXDpXQrj8DAMv7Shglp58vnbb+9myjjKFL1m1I9aSh/fEq/Uhi/njLHx7IYv5/1
M7hcsTV1Ud7wXNC98UGPhY+PL8bIcCF54j/RPHSmhXNibw==

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
968 3bd
ucxQE3xNUuhj6coBE73FbQYQIN4wgw0rVUgTfI4ZMkEVv8i96aEFVSEnbObYRCo3dOagh5PL
V7KrvYXfjXtD+p+YHwV/RkNbJQ0mb+mLjwtPx7y75OMmwaMwBDAE9IpYRtVv+crx0dMb0j69
z4qtizaMvimT7+uYJ+8FIA0v7Lcg+zMctbkeD0VVn51pR9dSqfe2WTm0HpwXBx1lBJg81q5W
66vNjfIXvkog+IKKR6uJ67OMILqLUylBg6jvEmB6xxGYEgcd5D2fj+cnlKqqe0noKFfdvNrL
G0qqqfaYPXvCEi5RRJNd2WyGFBpnN8lN+Fq6FD5LqAZPR+fH/zFgp5ZDkzhal091FD321DHH
Qg7I5c0VK9unIa4U+iUhPv8RS0x86OFuI9+Pvyz1spn6TmmLblF8RJxrGhaMpTyOyVIspBqG
M8verGy4mUjB/SaqSIww7171EzsjEfrrKiVhBaqG6p8Iv35Egl+K+jYoebYal5nb/Cv00WU0
wVS7Vc2OYHJNFNc6c/bXMJ4Uyv9B4Kl1nuP2Wy9dsS+8rfB4W8SVbS/x8swBCd7DZUQ3Rr1R
dRYABDhF8y/3l80mxbrt41cave5fYFF7ZCvCGGzuIRjr/rAtf0fTF5CbxRMflQ9nqpnjEPAE
S3EmQ6NieAICAzLr4xrlSrdBltYmxJhSg11gOw34OyOWHipb/kyEhP5NCogXz/bH7BrkDoqH
DFrBVu4B6z3Th6u1dd53N08rNphVPGkhoKyHwU7IQKuxH6W4vDQi3NtCBX3j415211l2nLOo
KElEn/uZLi7SUuQuK22rfXYfFVLkzeg/V9qOElDuE+cw8E0aPSFf79a3F5dqlEPKzRx8NrS2
XgmJi6X7DjbFPYTU9jmoZAP+rpgLtbuIweoYwsBppPDA+1IU2HTNmy3j+XK4ZEQ7LwsXtLXS
W7IzHdk=

/
show errors
create or replace procedure spv_valida_memoria_flash wrapped 
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
307 1ca
u5BFwCby7BK7Y57ZexqSnbQ7L8gwg2Px2SfWZ45AmP9ebultLVoNqDHDwnyLGvI0f4eeVXRe
C+MOKhHs6frZ0pOS4KSwbBbtyFDXdAfH/8a1tYL7CC5uxjZrMbkpQZQ6GLNl1Qp7F/VMS8kd
n1emWk3edW8lAs3KFDl/YtZfQLYut4HceKAs8zS0kKizW4I0xAAZdLM1ggYM3F9wEveaB2Lj
u+bAiATbuH/m4ShvwK0cZOgl/CleNi6TRfp9e5ZlobW3PhRuan6bsacx5tZGqzjjFKszjnsz
0zUJD6Atg5pcZKJS756h7uO26EURLfFLUeWoqm/u6ksBKtbYEbv+xGUFPZTkiazPiXYvHKaB
nGqWCaM9Mqe53GxVN9s1pgeEcqDkuhR53eu6eSG8b8aiXiPpv1nzj4yvgkb0gPMPHrUbujy/
twZPoBuzEx4fLLPWuZ8=

/
show errors
exec spv_print_header
host sha256sum &&p_script_validador
Prompt Realizando limpieza..
exec spv_clean('&&p_nombre'||'0402');
Prompt invocando script s-01-crea-objetos.sql
start s-01-crea-objetos.sql
connect sys/&&p_sys_password as sysdba
set serveroutput on
Prompt  Iniciando validación - Monitoreo DB Buffer cache
Prompt =============================================
exec spv_check_tables('&&p_nombre'||'0402');
exec spv_valida_memoria_flash
Prompt Datos del archivo flash cache
!ls -l /u04/db_flash_cache/
exec spv_print_ok('Validación concluida');
exit