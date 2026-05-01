'use client';
import { useState } from 'react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const router = useRouter();
    const supabase = createClient();

    const handleLogin = async () => {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) setError(error.message);
        else router.push('/dashboard');
    };

    const handleOAuth = async (provider: 'google' | 'github') => {
        const { error } = await supabase.auth.signInWithOAuth({
            provider,
            options: {
                redirectTo: `${window.location.origin}/auth/callback`,
            },
        });
        if (error) setError(error.message);
    };

    return (
        <div className='flex flex-col items-center justify-center min-h-screen gap-4'>
            <h1 className='text-2xl font-bold'>Sign In</h1>
            <input type='email' placeholder='Email'
                className='border p-2 rounded w-72'
                onChange={e => setEmail(e.target.value)} />
            <input type='password' placeholder='Password'
                className='border p-2 rounded w-72'
                onChange={e => setPassword(e.target.value)} />
            <button onClick={handleLogin}
                className='bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 w-72'>
                Sign In</button>

            <hr className='w-72 my-2' />

            <button onClick={() => handleOAuth('google')}
                className='flex items-center justify-center gap-2 border px-6 py-2 rounded w-72 hover:bg-gray-50 transition-colors'>
                <img src='/google.png' className='w-5 h-5' alt='Google' />
                Continue with Google
            </button>
            <button onClick={() => handleOAuth('github')}
                className='flex items-center justify-center gap-2 bg-gray-900 text-white px-6 py-2 rounded w-72 hover:bg-gray-700 transition-colors'>
                <img src='/github.png' className='w-5 h-5' alt='GitHub' />
                Continue with GitHub
            </button>

            {error && <p className='text-sm text-red-500'>{error}</p>}
            <a href='/signup' className='text-blue-500 text-sm mt-2'>
                No account? Sign up</a>
        </div>
    );
}
