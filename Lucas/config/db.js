const Sequelize = require("sequelize")
const database = require("../docs/database.js")

//Conexão com o DB MYSQL

const sequelize = new Sequelize(database.name, database.user, database.password, {
    host: database.host,
    dialect: database.dialect
})

sequelize.authenticate().then(() => console.log("Conectado ao banco de dados!")).catch(err => console.log("Falha ao se conectar: " + err))

module.exports = {
    Sequelize: Sequelize,
    sequelize: sequelize
}

