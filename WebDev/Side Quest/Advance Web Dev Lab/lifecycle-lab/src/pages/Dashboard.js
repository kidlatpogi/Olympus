// src/pages/Dashboard.js
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../auth/AuthContext';

function Dashboard() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  function handleLogout() {
    logout();
    navigate('/', { replace: true });
  }

  return (
    <div>
      <h1>📊 Dashboard</h1>
      <p>Welcome, <strong>{user?.username}</strong>! This page is protected.</p>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}
export default Dashboard;
