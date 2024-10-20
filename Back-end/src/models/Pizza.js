const path = require('path');
const mongoose = require('mongoose');
const { type } = require(path.join('express', 'lib', 'response'));


const itemSchema = new mongoose.Schema({
    name: { type: 'string', required: true, unique: true },
    ingredients: { type: 'string', required: true },
    price: { type: 'number', required: true },
    photoName: { type: 'string', required: true },
    soldOut: { type: 'boolean', required: true, default: false }
});

module.exports = mongoose.model('pizza', itemSchema);