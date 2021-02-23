
Prompt Proporcionar el password de SYS
connect sys as sysdba
set serveroutput on

@s-00-funciones-validacion.plb

create or replace procedure spv_valida_datos_instancia wrapped 
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
61f 378
9KWHwYdDi1AlO6I2MSgf9QC7CfYwgwLDs0gTfI5Vx2P5ahB1XaLmITEzfCq6bOGg6e9XZRQS
ostX5WzdWKj3e0MXM7JzRvm0fvEv0/eJenAGEv8AwZKHrr1hTBdgcRbqEzCEgkElV2ONFguH
iZRi09yvmSAgpoqIvX+zZLTUNVdO7/adHS9FvPaAj0Q4kURh/Vs82ypBUgTNK8ecRhzLy7vO
Uov41MsmS/fpUTEhSnqUJnULcn+rUb2fcWoyNFpqKOcstZ+hu/rGC9lkttKvnmuBEOfPFDDh
TnJb34yUZUXtiJiuhw6ELI1iUdtPI05/QblVLsEIiTA1joYPANJml56e7IJ82hygVdMDUhks
Mn9NRZcn7fzb1UDWks3fFS1zfvccf64YRiXS0XK7hz0dlpYPvFXB5LxWzJ3aE8TagDw7vjwS
wEhVVvQWqbAfFLtUnxexssFb875aJNNrcjQTAmM0BvKFlPP4h7POpISECwJrDFFB3IzVg/xE
HWIJeyGcaHEKq6gLEXT4pabW6O5QKIe4Kr2I1SzchHIw4feWFB0BCFcANLQ0tV7HbGnEJrBZ
VhGfJownXs0rLDIF5mq7i+rHDqrnP+F/rsk77fZuzSobwVmn5HM7UJuCnguAoa5GiVYmfUTN
/bK+P8r4cbEIS3EXMVzPOw1/qhJIqmkSGZocHYyTUa3XRnqr80tR8az8i3Ww/lDsDetZxrXz
NlEGDEFpvdjYBHw+lIzFUPIYbNU9ko0VTzJMA5J3gux3AVaIJ+ta6EixnbsgRTStYnUaO5Ls
j15UUPE+jhTxJnwrfTjzcNqGYdyRfS8r4o6vrBVwnTI4M16QLr47VK8JqCSruni4/BKuEE1D
feuqvUtjNQ==

/
show errors
exec spv_print_header
exec spv_valida_datos_instancia

prompt Validando configuración en glogin.sql
!chmod 755 s-02-validador-glogin*.sh
!./s-02-validador-glogin-main-enc.sh

drop procedure spv_valida_datos_instancia;
drop function fv_hash;
drop procedure spv_crea_secuencia;
drop procedure spv_print_ok;
drop procedure spv_throw_error;
drop  procedure spv_assert;
drop procedure spv_print_header;


Prompt Listo!
exit