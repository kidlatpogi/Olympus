// src/components/Timer.js
import React, { useState, useEffect } from 'react';

function Timer() {
  const [seconds, setSeconds] = useState(0);
  const [isRunning, setIsRunning] = useState(false);

  // Effect: runs when isRunning changes
  useEffect(() => {
    if (!isRunning) return;   // do nothing when paused

    console.log('[Timer] Interval started');
    const id = setInterval(() => {
      setSeconds(prev => prev + 1);
    }, 1000);

    // Cleanup: clear interval on unmount OR when isRunning → false
    return () => {
      console.log('[Timer] Interval cleared');
      clearInterval(id);
    };
  }, [isRunning]);   // <-- dependency array

  return (
    <div style={{ padding: '1rem', border: '1px solid #ccc', borderRadius: 8 }}>
      <h2>Timer: {seconds}s</h2>
      <button onClick={() => setIsRunning(r => !r)}>
        {isRunning ? 'Pause' : 'Start'}
      </button>
      <button onClick={() => { setIsRunning(false); setSeconds(0); }}>
        Reset
      </button>
    </div>
  );
}

export default Timer;
