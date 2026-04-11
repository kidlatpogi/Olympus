// src/components/Navbar.js
import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import { useTheme } from '../context/ThemeContext';
import { useAuth } from '../auth/AuthContext';

function Navbar() {
  const { theme, toggleTheme } = useTheme();
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const styles = {
    background: theme === 'light' ? '#1A3C6E' : '#0D1117',
    color: '#fff',
    padding: '1rem 2rem',
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
  };

  const linkStyle = ({ isActive }) => ({
    color: isActive ? '#fff' : '#aac8e8',
    textDecoration: 'none',
    fontWeight: isActive ? 700 : 500,
  });

  const actionButtonStyle = {
    marginLeft: 'auto',
    cursor: 'pointer',
  };

  return (
    <nav style={styles}>
      <h1 style={{ margin: 0 }}>My Shop</h1>
      <NavLink to='/' style={linkStyle} end>
        Home
      </NavLink>
      <NavLink to='/products' style={linkStyle}>
        Products
      </NavLink>
      <button onClick={toggleTheme} style={{ cursor: 'pointer' }}>
        Switch to {theme === 'light' ? '🌙 Dark' : '☀️ Light'} Mode
      </button>
      {user ? (
        <div style={{ marginLeft: 'auto', display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <span style={{ color: '#aac8e8' }}>Hi, {user.username}</span>
          <button
            onClick={() => {
              logout();
              navigate('/');
            }}
            style={actionButtonStyle}
          >
            Logout
          </button>
        </div>
      ) : (
        <NavLink to='/login' style={{ ...linkStyle({ isActive: false }), marginLeft: 'auto' }}>
          Login
        </NavLink>
      )}
    </nav>
  );
}

export default Navbar;
