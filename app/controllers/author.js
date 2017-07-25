let express = require("express");
let client = require("../client.js");

let router = express.Router();

let authorController = new class AuthorController {
  cgetAction(req, res) {
    const query = {
      text: "SELECT * FROM author"
    };

    client.query(query, (err, ret) => {
      if (err) {
        res.json({ body: err.stack });
      } else {
        res.json({ body: ret.rows });
      }
    });
  }

  postAction(req, res) {
    const query = {
      text: "INSERT INTO author (name) VALUES ($1::text);",
      values: [req.body.name]
    };

    client.query(query).catch(e => console.error(e.stack));

    res.json({ body: "OK" });
  }
}();

module.exports = authorController;
