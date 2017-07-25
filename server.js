let express = require("express");
let app = express();
let bodyParser = require("body-parser");

let client = require("./app/client.js");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

let port = process.env.PORT || 8080;

app.use("/api", require("./app/routes.js"));

app.listen(port);
