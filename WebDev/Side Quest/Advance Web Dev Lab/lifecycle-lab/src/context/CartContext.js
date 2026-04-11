// src/context/CartContext.js
import React, { createContext, useContext, useReducer } from 'react';

// Action types
const ADD_ITEM    = 'ADD_ITEM';
const REMOVE_ITEM = 'REMOVE_ITEM';
const CLEAR_CART  = 'CLEAR_CART';

// Reducer function
function cartReducer(state, action) {
  switch (action.type) {
    case ADD_ITEM: {
      const exists = state.find(i => i.id === action.payload.id);
      if (exists) {
        return state.map(i =>
          i.id === action.payload.id ? { ...i, qty: i.qty + 1 } : i
        );
      }
      return [...state, { ...action.payload, qty: 1 }];
    }
    case REMOVE_ITEM:
      return state.filter(i => i.id !== action.payload);
    case CLEAR_CART:
      return [];
    default:
      return state;
  }
}

// Separate contexts for state vs dispatch (performance pattern)
const CartStateContext    = createContext();
const CartDispatchContext = createContext();

export function CartProvider({ children }) {
  const [cart, dispatch] = useReducer(cartReducer, []);
  return (
    <CartStateContext.Provider value={cart}>
      <CartDispatchContext.Provider value={dispatch}>
        {children}
      </CartDispatchContext.Provider>
    </CartStateContext.Provider>
  );
}

export const useCart     = () => useContext(CartStateContext);
export const useDispatch = () => useContext(CartDispatchContext);
export { ADD_ITEM, REMOVE_ITEM, CLEAR_CART };
