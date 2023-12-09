-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: bolnica | type: SCHEMA --
-- DROP SCHEMA IF EXISTS bolnica CASCADE;
CREATE SCHEMA bolnica;
-- ddl-end --
-- ALTER SCHEMA bolnica OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,bolnica;
-- ddl-end --

-- object: bolnica.bolnica | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.bolnica CASCADE;
CREATE TABLE bolnica.bolnica (
	id_bolnice integer NOT NULL,
	ime_bolnice text,
	broj_telefona text,
	ulica text,
	CONSTRAINT "Bolnica_pk" PRIMARY KEY (id_bolnice)

);
-- ddl-end --

-- object: bolnica.lekar | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.lekar CASCADE;
CREATE TABLE bolnica.lekar (
	jmbg text NOT NULL,
	ime text NOT NULL,
	prezime text NOT NULL,
	email text,
	broj_telefona text,
	id_bolnice integer,
	id_struke integer,
	CONSTRAINT lekar_pk PRIMARY KEY (jmbg)

);
-- ddl-end --

-- object: bolnica.struka | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.struka CASCADE;
CREATE TABLE bolnica.struka (
	id_struke integer NOT NULL,
	naziv text NOT NULL,
	CONSTRAINT struka_pk PRIMARY KEY (id_struke)

);
-- ddl-end --

-- object: bolnica.pregled | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.pregled CASCADE;
CREATE TABLE bolnica.pregled (
	id_pregleda integer NOT NULL,
	datum date NOT NULL,
	dijagnoza text,
	vreme time,
	id_lekara text,
	id_pacijenta text,
	CONSTRAINT pregled_pk PRIMARY KEY (id_pregleda)

);
-- ddl-end --

-- object: bolnica.pacijent | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.pacijent CASCADE;
CREATE TABLE bolnica.pacijent (
	jmbg text NOT NULL,
	ime text NOT NULL,
	prezime text NOT NULL,
	broj_telefona integer,
	adresa text,
	id_lekara text,
	CONSTRAINT pacijent_pk PRIMARY KEY (jmbg)

);
-- ddl-end --

-- object: bolnica.boravak | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.boravak CASCADE;
CREATE TABLE bolnica.boravak (
	id_boravka integer NOT NULL,
	razlog text,
	od date,
	"do" date,
	id_pacijenta text,
	id_bolnicke_sobe integer,
	CONSTRAINT odsedanje_pk PRIMARY KEY (id_boravka)

);
-- ddl-end --

-- object: bolnica.bolnicka_soba | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.bolnicka_soba CASCADE;
CREATE TABLE bolnica.bolnicka_soba (
	id_sobe integer NOT NULL,
	broj_kreveta integer,
	id_bolnice integer,
	CONSTRAINT bolnicka_soba_pk PRIMARY KEY (id_sobe)

);
-- ddl-end --

-- object: bolnica.dodatno_osoblje | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.dodatno_osoblje CASCADE;
CREATE TABLE bolnica.dodatno_osoblje (
	jmbg text NOT NULL,
	ime text NOT NULL,
	prezime text NOT NULL,
	broj_telefona text,
	email text,
	id_bolnice integer,
	id_radnog_mesta integer,
	CONSTRAINT dodatno_osoblje_pk PRIMARY KEY (jmbg)

);
-- ddl-end --

-- object: bolnica.radno_mesto | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.radno_mesto CASCADE;
CREATE TABLE bolnica.radno_mesto (
	id_radnog_mesta integer NOT NULL,
	ime_radnog_mesta text,
	CONSTRAINT radno_mesto_pk PRIMARY KEY (id_radnog_mesta)

);
-- ddl-end --

-- object: bolnica.vozilo_hitne_pomoci | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.vozilo_hitne_pomoci CASCADE;
CREATE TABLE bolnica.vozilo_hitne_pomoci (
	tablice text NOT NULL,
	godiste integer,
	predjena_kilometraza integer,
	id_bolnice integer,
	CONSTRAINT vozilo_hitne_pomoci_pk PRIMARY KEY (tablice)

);
-- ddl-end --

-- object: bolnica.dezurni_lekar | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.dezurni_lekar CASCADE;
CREATE TABLE bolnica.dezurni_lekar (
	jmbg integer NOT NULL,
	broj_telefona text,
	ime text NOT NULL,
	prezime text NOT NULL,
	id_vozila text,
	CONSTRAINT dezurni_lekar_pk PRIMARY KEY (jmbg)

);
-- ddl-end --

-- object: bolnica.teren | type: TABLE --
-- DROP TABLE IF EXISTS bolnica.teren CASCADE;
CREATE TABLE bolnica.teren (
	id_terena integer NOT NULL,
	vreme_polaska time,
	vreme_dolaska time,
	dijagnoza text,
	ime_pacijenta text,
	prezime_pacijenta text,
	id_vozila text,
	CONSTRAINT teren_pk PRIMARY KEY (id_terena)

);
-- ddl-end --

-- object: radi | type: CONSTRAINT --
-- ALTER TABLE bolnica.lekar DROP CONSTRAINT IF EXISTS radi CASCADE;
ALTER TABLE bolnica.lekar ADD CONSTRAINT radi FOREIGN KEY (id_bolnice)
REFERENCES bolnica.bolnica (id_bolnice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poseduje | type: CONSTRAINT --
-- ALTER TABLE bolnica.lekar DROP CONSTRAINT IF EXISTS poseduje CASCADE;
ALTER TABLE bolnica.lekar ADD CONSTRAINT poseduje FOREIGN KEY (id_struke)
REFERENCES bolnica.struka (id_struke) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vrsi | type: CONSTRAINT --
-- ALTER TABLE bolnica.pregled DROP CONSTRAINT IF EXISTS vrsi CASCADE;
ALTER TABLE bolnica.pregled ADD CONSTRAINT vrsi FOREIGN KEY (id_lekara)
REFERENCES bolnica.lekar (jmbg) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: obavlja | type: CONSTRAINT --
-- ALTER TABLE bolnica.pregled DROP CONSTRAINT IF EXISTS obavlja CASCADE;
ALTER TABLE bolnica.pregled ADD CONSTRAINT obavlja FOREIGN KEY (id_pacijenta)
REFERENCES bolnica.pacijent (jmbg) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: leci | type: CONSTRAINT --
-- ALTER TABLE bolnica.pacijent DROP CONSTRAINT IF EXISTS leci CASCADE;
ALTER TABLE bolnica.pacijent ADD CONSTRAINT leci FOREIGN KEY (id_lekara)
REFERENCES bolnica.lekar (jmbg) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: odsedao_je | type: CONSTRAINT --
-- ALTER TABLE bolnica.boravak DROP CONSTRAINT IF EXISTS odsedao_je CASCADE;
ALTER TABLE bolnica.boravak ADD CONSTRAINT odsedao_je FOREIGN KEY (id_pacijenta)
REFERENCES bolnica.pacijent (jmbg) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: u | type: CONSTRAINT --
-- ALTER TABLE bolnica.boravak DROP CONSTRAINT IF EXISTS u CASCADE;
ALTER TABLE bolnica.boravak ADD CONSTRAINT u FOREIGN KEY (id_bolnicke_sobe)
REFERENCES bolnica.bolnicka_soba (id_sobe) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poseduje | type: CONSTRAINT --
-- ALTER TABLE bolnica.bolnicka_soba DROP CONSTRAINT IF EXISTS poseduje CASCADE;
ALTER TABLE bolnica.bolnicka_soba ADD CONSTRAINT poseduje FOREIGN KEY (id_bolnice)
REFERENCES bolnica.bolnica (id_bolnice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: radi | type: CONSTRAINT --
-- ALTER TABLE bolnica.dodatno_osoblje DROP CONSTRAINT IF EXISTS radi CASCADE;
ALTER TABLE bolnica.dodatno_osoblje ADD CONSTRAINT radi FOREIGN KEY (id_bolnice)
REFERENCES bolnica.bolnica (id_bolnice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: ima | type: CONSTRAINT --
-- ALTER TABLE bolnica.dodatno_osoblje DROP CONSTRAINT IF EXISTS ima CASCADE;
ALTER TABLE bolnica.dodatno_osoblje ADD CONSTRAINT ima FOREIGN KEY (id_radnog_mesta)
REFERENCES bolnica.radno_mesto (id_radnog_mesta) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poseduje | type: CONSTRAINT --
-- ALTER TABLE bolnica.vozilo_hitne_pomoci DROP CONSTRAINT IF EXISTS poseduje CASCADE;
ALTER TABLE bolnica.vozilo_hitne_pomoci ADD CONSTRAINT poseduje FOREIGN KEY (id_bolnice)
REFERENCES bolnica.bolnica (id_bolnice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: radi | type: CONSTRAINT --
-- ALTER TABLE bolnica.dezurni_lekar DROP CONSTRAINT IF EXISTS radi CASCADE;
ALTER TABLE bolnica.dezurni_lekar ADD CONSTRAINT radi FOREIGN KEY (id_vozila)
REFERENCES bolnica.vozilo_hitne_pomoci (tablice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: izlazi_na | type: CONSTRAINT --
-- ALTER TABLE bolnica.teren DROP CONSTRAINT IF EXISTS izlazi_na CASCADE;
ALTER TABLE bolnica.teren ADD CONSTRAINT izlazi_na FOREIGN KEY (id_vozila)
REFERENCES bolnica.vozilo_hitne_pomoci (tablice) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


