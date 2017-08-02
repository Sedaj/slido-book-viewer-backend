let express = require("express");
let app = express();
let bodyParser = require("body-parser");
let cors = require('cors');

let client = require("./app/client.js");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

let port = process.env.PORT || 8080;

app.use(cors());
app.options('*', cors());

app.use("/api", require("./app/routes.js"));

app.listen(port);
