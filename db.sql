CREATE SEQUENCE book_id_seq;

CREATE TABLE public.author
(
  id integer NOT NULL DEFAULT nextval('book_id_seq'::regclass),
  name character varying(255),
  CONSTRAINT author_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE public.book
(
  id integer NOT NULL DEFAULT nextval('book_id_seq'::regclass),
  title character varying(255),
  description text,
  CONSTRAINT book_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE public.author_to_book
 (
 author_id integer NOT NULL,
 book_id integer NOT NULL,
 CONSTRAINT author_to_book_pkey PRIMARY KEY (author_id, book_id),
 CONSTRAINT fk_aid FOREIGN KEY (author_id)
 REFERENCES public.author (id) MATCH SIMPLE
 ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT fk_bid FOREIGN KEY (book_id)
 REFERENCES public.book (id) MATCH SIMPLE
 ON UPDATE NO ACTION ON DELETE NO ACTION
 )
 WITH (
 OIDS=FALSE
 );

 CREATE INDEX idx_d2a068812469de2
 ON public.author_to_book
 USING btree
 (author_id);

 CREATE INDEX idx_d2a0688a832c1c9
 ON public.author_to_book
 USING btree
 (book_id);