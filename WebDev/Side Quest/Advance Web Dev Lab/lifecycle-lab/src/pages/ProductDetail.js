// src/pages/ProductDetail.js
import React from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { PRODUCTS } from './Products';

function ProductDetail() {
  const { id }    = useParams();   // extracts :id from the URL
  const navigate  = useNavigate();
  const product   = PRODUCTS.find(p => p.id === Number(id));

  if (!product) {
    return (
      <div>
        <h2>Product not found</h2>
        <button onClick={() => navigate('/products')}>Back to Products</button>
      </div>
    );
  }

  return (
    <div>
      <Link to='/products'>← Back</Link>
      <h1>{product.name}</h1>
      <p>Category: {product.category}</p>
      <p>Product ID: {id}</p>
      <button onClick={() => navigate(-1)}>Go Back (History)</button>
    </div>
  );
}
export default ProductDetail;
