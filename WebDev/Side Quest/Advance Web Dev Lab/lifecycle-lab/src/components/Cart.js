// src/components/Cart.js
import React from 'react';
import { useCart, useDispatch, REMOVE_ITEM, CLEAR_CART } from '../context/CartContext';

function Cart() {
  const cart     = useCart();
  const dispatch = useDispatch();
  const total    = cart.reduce((sum, i) => sum + i.price * i.qty, 0);

  return (
    <aside style={{ padding: '1rem', background: '#f4f6f8', borderRadius: 8 }}>
      <h2>Cart ({cart.length} items)</h2>
      {cart.length === 0 && <p>Your cart is empty.</p>}
      {cart.map(item => (
        <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 8 }}>
          <span>{item.name} × {item.qty}</span>
          <button onClick={() => dispatch({ type: REMOVE_ITEM, payload: item.id })}>
            Remove
          </button>
        </div>
      ))}
      {cart.length > 0 && (
        <>
          <hr />
          <p><strong>Total: ${total.toFixed(2)}</strong></p>
          <button onClick={() => dispatch({ type: CLEAR_CART })}>Clear Cart</button>
        </>
      )}
    </aside>
  );
}

export default Cart;
