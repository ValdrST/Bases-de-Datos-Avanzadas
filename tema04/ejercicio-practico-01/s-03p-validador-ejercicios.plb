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
194 f7
mOV4ikTpRfeetHK/+i81DbscxxQwg5By7Z4VfI5EcMEi6WFhjw6BFymJG7GrfHju6GI8Q2YG
G2bnIp2Dy8vFw7FqOst2rtw34r3bgcCGailTJElBHqZGJawRFCYNGlaUG+NNqSVwFKKlsvbA
QdWTfsr0CvqJhD6TrR6k4SuoHJ1gJeTv+ntRBYCVTZp92IwrSJo6pgC7Da+d0lGxcKQNfrhD
OXUBF+esMa+C+PlvacGM2g2LuNA=

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
1275 6d3
fV7J1Hp/XKPSsIgC9cosZ6kwFB0wg+1UVcD83y+5MkHmv0BKSQtuBGUH+gK98vJtqMY5I4P9
0OCiBl61fGFra2rZXcJkuEhO4D3QqpELdFhHib3hKzwnnVWumAp67OvaV24TL9seO800cMGW
2jWuHEq60DNorIuieMpUfYtVlkUmYa+FRVOmcDiqkIROKBLo9Zu+p+gWzT/eCfbsijwu0dII
dqz6aARnA3K/ZQ44cvVO+//ArZSa0Lyva3nw+UZsf7OtJVsLMFeCdrTWOnMAITvxtEZq3s3b
fnvrxmGBDh+LdI9qEeYbNTNhHB9hSPOW14qYKTBIWVav9vjt9VgWpNo/YGG2kh583TXTDGVM
5xQs+Dig77xKQVLgZMxGz0JDvAZjpJi1cEJtZpxAN7WjZtO2jgv43gOj7haLe2Y0dMeh0xuF
jBKh9Uq+t1j+EUobghKSugysUtN5bpG2qEvv9k9Mm9pf+8tufFpmoBSaJogO1MniSryVhaq+
RAlfAIoUj4QRdQhbyPyzpnha5qUBcyX3KU3CCPIbaiqkIeJfzx6sXI6SZ4O7rmCpNzeaj1XP
Oa+FfI+4GrcgZiEGA970EsKFV74VgkhGWn++WVaTDraMMjVuK2QSx7qD9Odd8am2yTc0fGa5
uBUWZtEoQktLgCSams9ZrJPLHdCjWB05EN3pppW5x6mnkRBQGuFxyZbUxUuabUANCmnysMCm
F52EV/urUEmEUMyOk4Nl5xQ58xsGpGmUhMXaYXQy+PmLvtnhKfi6RvNU4EgUNy3AneuohpO2
4DMWk/yoZ3L1/OnDytg0nt0CQiqp2Tobas9jFnQy0FGH501k+tvL9ZSeemwuWKEHOBvzZTlo
RNszdEKfUezKF3JumZipccImOQ3IDIKFkI7AxJ6+asoKZpHubnZrgbimMMWmy8CHGbV5rJOY
Dr3eNwN8GjmRJmWRfFw5CQA2+nzxWkPKDMEkeJ+hEX7xWVvU7sfJf/ClUbj7xYq2MiEwDtze
XhrQSGkyNcwdguQAYgEzLpUdAC6MIsrAoUefsPEfDNJmNffBfnoJX1e7EwY/z9682fN3vjJZ
2rXajIkK2MhWv/ubTLDoGsHTE3o3AReE2MokEcnCc0mtcYbnbEgEyGMTyvcAjkmfqFmfHqAh
K0lxLAzAgLdcY9T9weqBjIuqR5nqWfDQhyhcf4BuuB01Zr8iAoz6pv/uAy1xx1xIuDbZkxGg
rmveZe7WESHiGB+4eFQC8VY9/dcOJsKSPtkoxPb+lsVznVBmK18Wq5igUgyuwaFpj7sfWZuy
RDlIk66Fq0XoP9zZkq0/7XW6jPodyHTS/JL9T0PLbZ8oc2oG3CxyXg+j7kjl+p3GxWjwFZiI
YU1/zVx46CZKGb4vaaCDRr/SQgZB7/rio3L0LrWq9SLzbvjnCzl1AfikUMSFgVRqx2byJ6ts
O6tsjemh2trygGIWvp3Rh8E7enRxeTT/2pJMbwfn66UtbadUkFTTyJEuuc/iqSF58T0vCD+W
JW0rNDxyzcdCPUuNhXx4EX9EqZqy1eqEI9UahNDLeM23WYo8ZVLd+CbaJSvgQUkJg1SW42iT
rwsEIyZxq+u6XqGb1YNR8d1mcaI/Vpfy/GDrJYaEwC45A+dEUpXjP439Oxl5YB6H3Ljem/lq
xl2jgIMUnxIYlR62krz0MSQS24sDQGbD+mxnPUOJBr4YU9HzpGWr3EBzT/kdrpPlKA==

/
show errors
exec spv_print_header
host sha256sum &&p_script_validador
Prompt Realizando limpieza..
exec spv_clean('&&p_nombre'||'0401');
Prompt invocando script s-01-sga-components.sql
start s-01-sga-components.sql
connect sys/&&p_sys_password as sysdba
set serveroutput on
Prompt  Iniciando validación - Componentes de la SGA
Prompt =============================================
exec spv_check_tables('&&p_nombre'||'0401');
exec spv_print_ok('Validación concluida');
exit