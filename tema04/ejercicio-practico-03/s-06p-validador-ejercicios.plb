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
fa db
CWoNFeehX7/T69VDBS33csInc9Ywg/ByAJkVfC/UUsE/GAWDrNYrxNzex/ACdXa/obGM4xPj
ys46EJM2Un35EvmlL8YceclG+M1rsNlCvCsak8jWrWZZQPjW7uhAzA59UPBrpi/sd8AULuhO
VI3eA1xg/T2AsEwcOV3Aczt3zZoujJvyjFwYs5al2mwXw/Ghwme7JOwZ/l2xC0vN/L2uxaLE


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
1069 51d
9NLB/bhC30K17+ZOKQ5Lg96Ybkgwgw3qVUiDfI4ZKq7umBpew0SDuVFM1US42iFawkYOMnin
DC5t7I8Wf1V7CGUSqe3dSPjgx9N0OXYREW1pP0rNt7v4/wgtzSPcmWEdKKwhP6JqEmXPZ3Sa
RhQ9TI7OUAM7HDYd2fYQLTTU+33ODaumHdJiqRmBFeJPdYuvkxl8S0X7Np9Q9ua72H0eTtFL
8HHGKWaxm9gZUULtPZ3Caca89fLaMFC75KkrA5jbGrGVsENKYrDBe9+g+E270jtIJmoMKOZ3
1gxaDRs0/LQ0LE1DqpqkytnB5tK+ckhQAxChdTFZ2ooTMssKzQ7ixwLsr0Ns0iHv/SigRmgJ
9YKk8FqsJQggrOBuj+fpeNTy2aRghvrjbzPYD+id1ExdNGWm4rHuWW5kRTlep1kHfuxwfBqh
5kB01kfVcHZguSoav8dyoyIcWgh7AFuj8uYiGNBB3HX5CKZfSV+s6868y2C98KnfEzubXq3/
5BW7S5TSqH3SI0tVLc63zp7G/ONZhV5wJmuHJE94BDKEet4zTp3jFI5o08jImH+wWl5K9tzI
JCALzhV8fwM3JRJHpA51JWlGWmVijO/9PbM+YB3K/nYlFui2ZTjjzEBqlJaMRi+O9+Mbrj0d
mJ40DjQmvOeKCgTNrxdYZzmdIcLZzJ+t32WGvYVzp2M8xSr3rf1Eammc9OHHkwJ8YSs2hExb
/ycTtg/qynt4sutpqGIlJ6mE7Fo+2HRDa8XDlRpVWtAVODK/j3y13q3YMVk3VH8C9Q1oH+hr
N5lwJ7pqLVu/Pu+a47xd84klH1NcnjbimQDtVg3L/w32ffZgUmIu3cUjepcgWqNbMx8aRwEm
ytOvkKEt35DCaFO0hV+BrcSdyvaVTaKNPPkc2Rf6q/RVJeOjUTyioLzmdMwQmlZ4RmpiDebd
4sIGHGt1cmqJOKfhLY9gzupIQ22unwtXvu/YFupGCFXISxd/NXWW4+TfxPBJEezT+nUSR6Ma
Q1r1SrZ7FN4YmxBKeuRJLhxXx25megGgkidW9+Wgc1dg01ZrQGf6QeDgjm7BGwjUxo98GoRH
MEtXxGNYt/pWPYjYZiYV7jZVTlVYFKm06e4Wy71FQ8rwAB0040NgiQ+Oj4HuZPCbOevFZRCj
y4dtxFbDgbTBIhmWlo5LH9jZ/hNjW/RCiDFYhLpymbJOTgbbUHwfgEDmLlJI40G13NSzgzo3
WY44XcosT7VGhrrl4pDHtXYp0a67qNfJpt2Y5YzOGfnhJt0Xqz0nUEhPEM4o/WihuA==

/
show errors
Prompt Realizando limpieza..
exec spv_clean('&&p_nombre'||'0403');
Prompt invocando script s-01-redo-log-buffer.sql
start s-01-redo-log-buffer.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-02-shared-pool.sql
start s-02-shared-pool.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-03-pga-stats.sql
start s-03-pga-stats.sql
connect sys/&&p_sys_password as sysdba
Prompt invocando script s-04-pga-process.sql
start s-04-pga-process.sql
set serveroutput on
set linesize window
exec spv_print_header
host sha256sum &&p_script_validador
exec spv_check_tables('&&p_nombre'||'0403');
exec spv_print_ok('Validación concluida');
exit