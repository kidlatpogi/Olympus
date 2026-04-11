// src/pages/Login.js
import React, { useState } from 'react';
import { useNavigate, useLocation, Navigate } from 'react-router-dom';
import { useAuth } from '../auth/AuthContext';

function Login() {
  const { user, login } = useAuth();
  const navigate        = useNavigate();
  const location        = useLocation();
  const [username, setUsername] = useState('');

  const from = location.state?.from?.pathname || '/dashboard';

  // Already logged in — redirect away
  if (user) return <Navigate to={from} replace />;

  function handleSubmit(e) {
    e.preventDefault();
    if (!username.trim()) return;
    login(username.trim());
    navigate(from, { replace: true });   // go to originally requested page
  }

  return (
    <div style={{ maxWidth: 320, margin: '4rem auto' }}>
      <h1>🔐 Login</h1>
      <form onSubmit={handleSubmit}>
        <input
          type='text'
          placeholder='Enter any username'
          value={username}
          onChange={e => setUsername(e.target.value)}
          style={{ display: 'block', width: '100%', marginBottom: 12, padding: 8 }}
        />
        <button type='submit' style={{ width: '100%', padding: 8 }}>Login</button>
      </form>
    </div>
  );
}
export default Login;
