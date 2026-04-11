// src/components/Layout.js
import React from 'react';
import { Outlet } from 'react-router-dom';
import Navbar from './Navbar';

function Layout() {
  return (
    <>
      <Navbar />
      <main style={{ padding: '2rem' }}>
        <Outlet />   {/* renders the matched child route */}
      </main>
    </>
  );
}
export default Layout;
