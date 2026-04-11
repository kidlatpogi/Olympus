// src/auth/ProtectedRoute.js
import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from './AuthContext';

function ProtectedRoute({ children }) {
  const { user }   = useAuth();
  const location   = useLocation();

  if (!user) {
    // Redirect to /login, but remember where the user was trying to go
    return <Navigate to='/login' state={{ from: location }} replace />;
  }

  return children;
}

export default ProtectedRoute;
