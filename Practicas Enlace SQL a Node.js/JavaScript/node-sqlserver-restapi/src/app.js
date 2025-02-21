import express from 'express';
import { json } from 'express';
import sql from 'mssql';

const app = express();
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`+` el numero de la bestia`);
});

app.get('/', (req, res) => {
  res.send('Servidor de la bestia funcionando');
});

//middleware
app.use(json());

// Configuracion conexion a BD
const config = {
  user: 'sa', //Usuario de SQL
  password: 'Toro.2800', //Contraseña de usuario SQL
  server: 'MSI\\SQLEXPRESS', //servidor donde esta el SQL Server
  database: 'Guia_Comandos', //base de datos a usar
  options: {
    // Por default, SQL siempre corre en el 1433
    port: 1433, 
    encrypt: false, //Si le ponen true deberan agregar los certificados
  },
};

// Conectar a la BD
sql.connect(config, (err) => {
  if (err) {
    console.error('No jaló la conexion xD', err);
  } else {
    console.log('Conexion a BD exitosa');
  }
});