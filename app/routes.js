let express = require("express");
let client = require("./client.js");

let router = express.Router();

let authorController = require("./controllers/author.js");
let bookController = require("./controllers/book.js");

router.get("/", (req, res) => {
  res.json({ body: "" });
});

router
  .route("/authors")
  .get((req, res) => {
    authorController.cgetAction(req, res);
  })
  .post((req, res) => {
    authorController.postAction(req, res);
  });

router
  .route("/books")
  .post((req, res) => {
    bookController.postAction(req, res);
  })
  .get((req, res) => {
    bookController.cgetAction(req, res);
  });

router
  .route("/books/:book_id")
  .get((req, res) => {
    bookController.getAction(req, res);
  })
  .put((req, res) => {
    bookController.putAction(req, res);
  })
  .delete((req, res) => {
    bookController.deleteAction(req, res);
  });

module.exports = router;
