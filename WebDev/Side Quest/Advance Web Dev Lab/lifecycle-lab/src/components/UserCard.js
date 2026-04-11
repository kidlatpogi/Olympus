// src/components/UserCard.js
import React from 'react';
import useFetch from '../hooks/useFetch';

function UserCard({ userId }) {
  const url = `https://jsonplaceholder.typicode.com/users/${userId}`;
  const { data: user, loading, error } = useFetch(url);

  if (loading) return <p>Loading user {userId}...</p>;
  if (error)   return <p style={{ color: 'red' }}>Error: {error}</p>;

  return (
    <div style={{ border: '1px solid #aaa', padding: '1rem', borderRadius: 8 }}>
      <h3>{user.name}</h3>
      <p>Email: {user.email}</p>
      <p>Company: {user.company.name}</p>
    </div>
  );
}

export default UserCard;
