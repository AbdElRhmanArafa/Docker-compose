const path = require('path');

const express = require('express');
const router = express.Router();

const { getAllPizzas_controller, postNewPizzas_controller } = require(path.join(__dirname, '..', 'controller', 'pizzaController.js'));

router.get('/pizzas', getAllPizzas_controller);

router.post('/pizzas', postNewPizzas_controller);

module.exports = router;