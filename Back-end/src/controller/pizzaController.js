const path = require('path');

const Pizza = require(path.join(__dirname, '..', 'models', 'Pizza.js'));

const getAllPizzas_controller = async (req, res) => {
    try {
        const pizzas = await Pizza.find({});
        return res.json(pizzas);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Something went wrong' });
    }
}

const postNewPizzas_controller = async (req, res) => {
    try {
        const pizza = req.body;
        if (!pizza.name || !pizza.ingredients || !pizza.price || !pizza.photoName) return res.status(406).json({ message: 'Not accepted missing parameter' });
        const existingPizza = await Pizza.findOne({ name: req.body.name });
        if (existingPizza) return res.status(409).json({ message: 'Pizza already exist' });
        const newPizza = new Pizza(pizza);
        await newPizza.save();
        return res.status(201).json(newPizza);

    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Something went wrong' });
    }
}

module.exports = { getAllPizzas_controller, postNewPizzas_controller };