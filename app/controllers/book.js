let express = require("express");
let client = require("../client.js");

let router = express.Router();

let bookController = (new class BookController {
  cgetAction(req, res) {
    const query = {
      text: `SELECT book.id, book.title, book.description, array_agg(author.name) authors
          FROM book 
          LEFT JOIN author_to_book 
          ON book.id = author_to_book.book_id 
          LEFT JOIN author 
          ON author_to_book.author_id = author.id
          GROUP BY book.id
          ORDER BY id`
    };

    client.query(query).then(ret => {
      res.json({ body: ret.rows });
    });
  }

  getAction(req, res) {
    let book_id = req.params.book_id;

    const query = {
      text: `SELECT book.*, array_agg(author.name) authors FROM book 
        LEFT JOIN author_to_book 
        ON book.id = author_to_book.book_id
        LEFT JOIN author
        ON author_to_book.author_id = author.id
        WHERE book.id = $1::integer
        GROUP BY book.id
        `,
      values: [book_id]
    };

    client.query(query).then(ret => {
      res.json({ body: ret.rows[0] });
    });
  }

  postAction(req, res) {
    const query = {
      text:
        "INSERT INTO book (title, description) VALUES ($1::text, $2::text);",
      values: [req.body.title, req.body.description]
    };

    client
      .query(query)
      .then(ret => {
        let authors = req.body.authors;

        client
          .query("SELECT currval('book_id_seq') current_value;")
          .then(ret => {
            let book_id = ret.rows[0].current_value;

            // we can create separate query for each author, this operation won't be expensive
            for (let i in authors) {
              let q = {
                text:
                  "INSERT INTO author_to_book (author_id, book_id) VALUES ($1::integer,$2::integer) ON CONFLICT DO NOTHING",
                values: [authors[i], book_id]
              };

              client.query(q);
            }
          });
      })
      .catch(e => console.error(e.stack));

    res.json({ body: "OK" });
  }

  putAction(req, res) {
    let book_id = req.params.book_id;

    const query = {
      text:
        "UPDATE book SET (title, description) = ($1::text, $2::text) WHERE id = $3::integer;",
      values: [req.body.title, req.body.description, book_id]
    };

    client
      .query(query)
      .then(ret => {
        let authors = req.body.authors;

        let q = {
          text: "DELETE FROM author_to_book WHERE book_id = $1::integer",
          values: [book_id]
        };

        client.query(q).then(ret => {
          for (let i in authors) {
            q = {
              text:
                "INSERT INTO author_to_book (author_id, book_id) VALUES ($1::integer,$2::integer) ON CONFLICT DO NOTHING",
              values: [authors[i], book_id]
            };

            client.query(q);
          }
        });
      })
      .catch(e => console.error(e.stack));

    res.json({ body: "OK" });
  }

  deleteAction(req, res) {
    let book_id = req.params.book_id;

    const query = {
      text: "DELETE FROM book WHERE id = $1::integer",
      values: [book_id]
    };

    client.query(query).then(ret => {
      res.json({ body: "OK" });
    });
  }
});

module.exports = bookController;
