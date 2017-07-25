const { Client } = require("pg");
const client = new Client({
  user: "pguser",
  password: "aaabbb",
  database: "slido"
});

client.connect();

module.exports = client;
