import { useState, useEffect } from "react";
import Pizza from "./Pizza";

const mongoURI = process.env.MONGO_URL

const getPizzas = async () => {
    console.log(mongoURI);
    const menu = await fetch('http://localhost:3000/menu/pizzas');
    if (!menu.ok) throw new Error('Failed to fetch menu');
    return await menu.json();

}

export default function Menu() {
    // const pizzas = [];
    const [pizzas, setPizzas] = useState([]);
    const numPizzas = pizzas.length;

    useEffect(() => {
        getPizzas()
            .then(data => setPizzas(data))
            .catch(error => console.error(error));
    }, [])

    return (
        <main className="menu">
            <h2>Our menu</h2>

            {numPizzas > 0 ? (
                <>
                    <p>
                        Authentic Italian cuisine. 6 creative dishes to choose from. All
                        from our stone oven, all organic, all delicious.
                    </p>

                    <ul className="pizzas">
                        {pizzas.map((pizza) => (
                            <Pizza pizzaObj={pizza} key={pizza.name} />
                        ))}
                    </ul>
                </>
            ) : (
                <p>We're still working on our menu. Please come back later :)</p>
            )}
        </main>
    );
}