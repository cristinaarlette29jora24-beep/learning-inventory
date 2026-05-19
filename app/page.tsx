'use client';

import { useEffect, useState } from 'react';

type Product = {
  id: string;
  name: string;
  price: string;
  stock: number;
  category: string;
};

export default function Home() {
  const [products, setProducts] = useState<Product[]>([]);

  useEffect(() => {
    fetch('/api/products')
      .then(res => res.json())
      .then(data => setProducts(data));
  }, []);

  return (
    <main style={{ padding: '2rem', fontFamily: 'Arial' }}>
      <h1>Inventario de Productos</h1>
      <table border={1} cellPadding={10} style={{ borderCollapse: 'collapse', width: '100%' }}>
        <thead style={{ backgroundColor: '#1F3864', color: 'white' }}>
          <tr>
            <th>Producto</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Categoría</th>
          </tr>
        </thead>
        <tbody>
          {products.map(p => (
            <tr key={p.id}>
              <td>{p.name}</td>
              <td>{p.price} €</td>
              <td>{p.stock}</td>
              <td>{p.category}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}