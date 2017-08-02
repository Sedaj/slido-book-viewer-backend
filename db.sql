CREATE SEQUENCE book_id_seq;
CREATE SEQUENCE author_id_seq;

CREATE TABLE public.author
(
  id integer NOT NULL DEFAULT nextval('author_id_seq'::regclass),
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
 ON UPDATE NO ACTION ON DELETE CASCADE,
 CONSTRAINT fk_bid FOREIGN KEY (book_id)
 REFERENCES public.book (id) MATCH SIMPLE
 ON UPDATE NO ACTION ON DELETE CASCADE
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

 INSERT INTO author (name) VALUES
 ('Miguel De Cervantes'),
 ('John Bunyan'),
 ('Daniel Defoe'),
 ('Jonathan Swift'),
 ('Henry Fielding'),
 ('Samuel Richardson'),
 ('Laurence Sterne'),
 ('Pierre Choderlos De Laclos'),
 ('Jane Austen'),
 ('Mary Shelley'),
 ('Thomas Love Peacock'),
 ('Honoré De Balzac'),
 ('Stendhal'),
 ('Alexandre Dumas'),
 ('Benjamin Disraeli'),
 ('Charles Dickens'),
 ('Emily Brontë'),
 ('Charlotte Brontë'),
 ('William Makepeace Thackeray'),
 ('Nathaniel Hawthorne');

INSERT INTO book (title, description) VALUES
('Don Quixote', 'The story of the gentle knight and his servant Sancho Panza has entranced readers for centuries.'),
('Pilgrim''s Progress', 'The one with the Slough of Despond and Vanity Fair.'),
('Robinson Crusoe', 'The first English novel.'),
('Gulliver''s Travels', 'A wonderful satire that still works for all ages, despite the savagery of Swift''s vision.'),
('Tom Jones', 'The adventures of a high-spirited orphan boy: an unbeatable plot and a lot of sex ending in a blissful marriage.'),
('Clarissa', 'One of the longest novels in the English language, but unputdownable.'),
('Tristram Shandy', 'One of the first bestsellers, dismissed by Dr Johnson as too fashionable for its own good.'),
('Dangerous Liaisons', 'An epistolary novel and a handbook for seducers: foppish, French, and ferocious.'),
('Emma', 'Near impossible choice between this and Pride and Prejudice. But Emma never fails to fascinate and annoy.'),
('Frankenstein', 'Inspired by spending too much time with Shelley and Byron.'),
('Nightmare Abbey', 'A classic miniature: a brilliant satire on the Romantic novel.'),
('The Black Sheep', 'Two rivals fight for the love of a femme fatale. Wrongly overlooked.'),
('The Charterhouse of Parma', 'Penetrating and compelling chronicle of life in an Italian court in post-Napoleonic France.'),
('The Count of Monte Cristo', 'A revenge thriller also set in France after Bonaparte: a masterpiece of adventure writing.'),
('Sybil', 'Apart from Churchill, no other British political figure shows literary genius.'),
('David Copperfield', 'This highly autobiographical novel is the one its author liked best.'),
('Wuthering Heights', 'Catherine Earnshaw and Heathcliff have passed into the language. Impossible to ignore.'),
('Jane Eyre', 'Obsessive emotional grip and haunting narrative.'),
('Vanity Fair', 'The improving tale of Becky Sharp.'),
('The Scarlet Letter', 'A classic investigation of the American mind.');

INSERT INTO author_to_book (author_id, book_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20);
