select * 
from bolnica.bolnicka_soba
where id_sobe =  (select id_bolnicke_sobe
from bolnica.boravak b
where od = '01-02-2023')