-- DROP TABLE IF EXISTS songs2.rsCollectionTrack;
-- DROP TABLE IF EXISTS songs2.rsSingerAlbum;
-- DROP TABLE IF EXISTS songs2.rsSingerGenre;
-- DROP TABLE IF EXISTS songs2.tracks;
-- DROP TABLE IF EXISTS songs2.singer;
-- DROP TABLE IF EXISTS songs2.albums;
-- DROP TABLE IF EXISTS songs2.collection;
-- DROP TABLE IF EXISTS songs2.country;
-- DROP TABLE IF EXISTS songs2.genre;

DROP SCHEMA IF EXISTS songs2 CASCADE;
CREATE SCHEMA IF NOT EXISTS songs2;

CREATE TABLE IF NOT EXISTS songs2.genre (
	id serial4 NOT NULL,
	genre_name varchar(100) NOT NULL,
	CONSTRAINT genre_pk PRIMARY KEY (id),
	CONSTRAINT genre_un UNIQUE (genre_name)
);
-- Permissions
ALTER TABLE songs2.genre OWNER TO py44;
GRANT ALL ON TABLE songs2.genre TO py44;

CREATE TABLE IF NOT EXISTS songs2.country (
	id serial4 NOT NULL,
	country varchar(100) NOT NULL,
	CONSTRAINT country_pk PRIMARY KEY (id),
	CONSTRAINT country_fk UNIQUE (country)
);
-- Permissions
ALTER TABLE songs2.country OWNER TO py44;
GRANT ALL ON TABLE songs2.country TO py44;

CREATE TABLE IF NOT EXISTS songs2.collection (
	id serial4 NOT NULL,
	col_name varchar(100) NOT NULL,
	year_release int4 NOT NULL,
	CONSTRAINT collection_pk PRIMARY KEY (id)
);
-- Permissions
ALTER TABLE songs2.collection OWNER TO py44;
GRANT ALL ON TABLE songs2.collection TO py44;

CREATE TABLE IF NOT EXISTS songs2.albums (
	id serial4 NOT NULL,
	album_name varchar(100) NOT NULL DEFAULT 'No name'::character varying,
	year_release int4 NOT NULL,
	CONSTRAINT albums_pk PRIMARY KEY (id)
);
-- Permissions
ALTER TABLE songs2.albums OWNER TO py44;
GRANT ALL ON TABLE songs2.albums TO py44;

CREATE TABLE IF NOT EXISTS songs2.singer (
	id serial4 NOT NULL,
	singer_name varchar(100) NOT NULL,
	nickname varchar(100) NULL,
	country int4 NOT NULL,
	CONSTRAINT singer_pk PRIMARY KEY (id),
	CONSTRAINT singer_fk FOREIGN KEY (country) REFERENCES songs2.country(id)
);
-- Permissions
ALTER TABLE songs2.singer OWNER TO py44;
GRANT ALL ON TABLE songs2.singer TO py44;

CREATE TABLE IF NOT EXISTS songs2.tracks (
	id serial4 NOT NULL,
	track_name varchar(100) NOT NULL,
	duration time NOT NULL,
	album_id int4 NOT NULL,
	CONSTRAINT tracks_pk PRIMARY KEY (id),
	CONSTRAINT tracks_fk FOREIGN KEY (album_id) REFERENCES songs2.albums(id)
);
-- Permissions
ALTER TABLE songs2.tracks OWNER TO py44;
GRANT ALL ON TABLE songs2.tracks TO py44;

CREATE TABLE IF NOT EXISTS songs2.rsSingerGenre (
	id serial4 NOT NULL,
	singer_id int4 NOT NULL,
	genre_id int4 NOT NULL,	
	CONSTRAINT rsSingerGenre_pk PRIMARY KEY (id),
	CONSTRAINT rsSingerGenre_singer_fk FOREIGN KEY (singer_id) REFERENCES songs2.singer (id),
	CONSTRAINT rsSingerGenre_genre_fk FOREIGN KEY (genre_id) REFERENCES songs2.genre (id)
);
-- Permissions
ALTER TABLE songs2.rsSingerGenre OWNER TO py44;
GRANT ALL ON TABLE songs2.rsSingerGenre TO py44;

CREATE TABLE IF NOT EXISTS songs2.rsSingerAlbum (
	id serial4 NOT NULL,
	singer_id int4 NOT NULL,
	album_id int4 NOT NULL,
	CONSTRAINT rsSingerAlbum_pk PRIMARY KEY (id),
	CONSTRAINT rsSingerAlbum_singer_fk FOREIGN KEY (singer_id) REFERENCES songs2.singer (id),
	CONSTRAINT rsSingerAlbum_album_fk FOREIGN KEY (album_id) REFERENCES songs2.albums (id)
);
-- Permissions
ALTER TABLE songs2.rsSingerAlbum OWNER TO py44;
GRANT ALL ON TABLE songs2.rsSingerAlbum TO py44;

CREATE TABLE IF NOT EXISTS songs2.rsCollectionTrack (
	id serial4 NOT NULL,
	collection_id int4 NOT NULL,
	track_id int4 NOT NULL,
	CONSTRAINT rsCollectionTrack_pk PRIMARY KEY (id),
	CONSTRAINT rsCollectionTrack_collection_fk FOREIGN KEY (collection_id) REFERENCES songs2.collection (id),
	CONSTRAINT rsCollectionTrack_track_fk FOREIGN KEY (track_id) REFERENCES songs2.tracks (id)
);
-- Permissions
ALTER TABLE songs2.rsCollectionTrack OWNER TO py44;
GRANT ALL ON TABLE songs2.rsCollectionTrack TO py44;
