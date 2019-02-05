var mysql = require('mysql');
var util = require('util');
const connection = mysql.createConnection({
    host:          'localhost',
    port:          3306,
    user:          'root',
    password:      'root',
    database:      'tnews',
    dateStrings:    true
});
connection.query = util.promisify(connection.query);
module.exports = connection 