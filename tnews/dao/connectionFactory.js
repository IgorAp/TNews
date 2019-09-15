var mysql = require('mysql');
var util = require('util');
console.log(process.env.DBHOST)
const connection = mysql.createConnection({
    host:          process.env.DBHOST,
    port:          process.env.DBPORT,
    user:          process.env.DBUSER,
    password:      process.env.DBPASS,
    database:      'tnews',
    dateStrings:    true
});
connection.query = util.promisify(connection.query);
module.exports = connection 