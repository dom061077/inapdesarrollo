INSERT INTO saie.pais(id,VERSION,nombre)VALUES(1,0,'ARGENTINA');
INSERT INTO saie.pais(id,VERSION,nombre)VALUES(2,0,'MEXICO');

ALTER TABLE `saie`.`provincia` CHANGE `id` `id` BIGINT(20) NOT NULL;
INSERT INTO saie.provincia(id,VERSION,nombre,pais_id)
SELECT id,0,nombre,1 FROM expoant.provincia;
ALTER TABLE `saie`.`provincia` CHANGE `id` `id` BIGINT(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `saie`.`localidad` CHANGE `id` `id` BIGINT(20) NOT NULL;
INSERT INTO saie.localidad(id,VERSION,codigo_postal,nombre,provincia_id)
SELECT id,0,codigo_postal,nombre_loc,provincia_id FROM expoant.localidad;
ALTER TABLE `saie`.`localidad` CHANGE `id` `id` BIGINT(20) NOT NULL AUTO_INCREMENT;