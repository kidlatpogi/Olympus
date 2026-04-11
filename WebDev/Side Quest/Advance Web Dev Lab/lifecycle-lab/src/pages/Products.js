// src/pages/Products.js
import React from 'react';
import { Link } from 'react-router-dom';

const PRODUCTS = [
  { id: 1, name: 'React Handbook',     category: 'Books' },
  { id: 2, name: 'TypeScript Guide',   category: 'Books' },
  { id: 3, name: 'Node.js Cookbook',   category: 'Books' },
  { id: 4, name: 'VS Code Extension',  category: 'Tools' },
  { id: 5, name: 'Git Mastery Course', category: 'Courses' },
];

function Products() {
  return (
    <div>
      <h1>📦 Products</h1>
      <ul>
        {PRODUCTS.map(p => (
          <li key={p.id} style={{ marginBottom: '0.5rem' }}>
            <Link to={`/products/${p.id}`}>
              {p.name}
            </Link>
            <span style={{ marginLeft: 8, color: '#888' }}>({p.category})</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

export { PRODUCTS };
export default Products;
