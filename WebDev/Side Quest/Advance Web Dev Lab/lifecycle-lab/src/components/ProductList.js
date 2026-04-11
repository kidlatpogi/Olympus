// src/components/ProductList.js
import React from 'react';
import { useDispatch, ADD_ITEM } from '../context/CartContext';

const PRODUCTS = [
  { id: 1, name: 'React Handbook', price: 29.99 },
  { id: 2, name: 'TypeScript Guide', price: 24.99 },
  { id: 3, name: 'Node.js Cookbook', price: 34.99 },
];

function ProductList() {
  const dispatch = useDispatch();

  return (
    <section>
      <h2>Products</h2>
      {PRODUCTS.map(p => (
        <div key={p.id} style={{ marginBottom: '1rem', padding: '1rem', border: '1px solid #ccc', borderRadius: 8 }}>
          <strong>{p.name}</strong> — ${p.price}
          <button
            style={{ marginLeft: '1rem' }}
            onClick={() => dispatch({ type: ADD_ITEM, payload: p })}
          >
            Add to Cart
          </button>
        </div>
      ))}
    </section>
  );
}

export default ProductList;
