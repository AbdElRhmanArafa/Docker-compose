const path = require('path');

const express = require('express');
const app = express();

const cors = require('cors');

const mongoose = require('mongoose');
const CONNECTION_URL = process.env.MONGO_URL || 'mongodb://localhost:27017';

const PORT = process.env.PORT || 3000;

const menuRouter = require(path.join(__dirname, 'routes', 'menu.js'));

app.use(cors()); // Enable cross-origin resource sharing (CORS) for all requests. This is a security measure to prevent potential attacks.

app.use(express.json());
app.use('/menu', menuRouter)

mongoose.connect(CONNECTION_URL)
    .then(() => console.log("Connected to MongoDB successfully"))
    .then(() => app.listen(PORT, () => console.log(`Server listening on port ${PORT}`)))
    .catch((error) => console.error(error.message));