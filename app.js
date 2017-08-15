const express = require('express');
const { Client} = require('pg');
const bodyParser =  require('body-parser');

const app = express();

app.use(bodyParser.json());
const client = new Client({
  user:'AdrianRodriguez',
  host:'localhost',
  database:'tacodb',
  password:'',
  port:5432
});
client.connect();

app.get('/', function (request, response){
  response.send('ok');
});

app.get('/restaurants', function(request, response){
  client.query('SELECT * FROM franchise', function(request, dbResponse){
  response.json({ restaurants: dbResponse.rows})
});
});

app.get('/restaurants/:franchise_id', function (request,response){
  client.query('SELECT * FROM franchise WHERE franchise_id =$1', [request.params.franchise_id],function (err,dbResponse){
    response.json({ restaurant: dbResponse.rows})
  });
});

app.get('/restaurants/:franchise_id/locations', function (request,response){
  client.query('SELECT * FROM location WHERE franchise_id =$1', [request.params.franchise_id], function (request, dbResponse){
    response.json({locations:dbResponse.rows})
  });
});

app.get('/restaurants/:franchise_id/menuItems', function(request, response){
  client.query('SELECT * FROM menu_item WHERE franchise_id =$1', [request.params.franchise_id], function (request, dbResponse){
    response.json({menuItems: dbResponse.rows})
  });
});

app.post('/restaurants/:franchise_id',function(request,response){
  client.query('INSERT INTO menu_item (name,course,price,picture,franchise_id) VALUES($1, $2, $3, $4, $5)',[request.body.name, request.body.course, request.body.price, request.body.picture, request.params.franchise_id], function (err, dbResponse){
    response.json({status:'ok', payload: {menu_item: dbResponse.rows[0]}})
  })
});

app.listen(3000, function(){
  console.log('Server farted');
});
