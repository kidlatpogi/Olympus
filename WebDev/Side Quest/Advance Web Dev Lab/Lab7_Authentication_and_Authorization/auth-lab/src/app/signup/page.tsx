'use client';
import { useState } from 'react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

const supabase = createClient();

export default function SignUpPage() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [message, setMessage] = useState('');
    const router = useRouter();

    const handleSignUp = async () => {
        const { error } = await supabase.auth.signUp({ email, password });
        if (error) setMessage(error.message);
        else {
            setMessage('Check email for confirmation!');
            router.push('/dashboard');
        }
    };

    return (
        <div className='flex flex-col items-center justify-center min-h-screen gap-4'>
            <h1 className='text-2xl font-bold'>Create Account</h1>
            <input type='email' placeholder='Email'
                className='border p-2 rounded w-72'
                onChange={e => setEmail(e.target.value)} />
            <input type='password' placeholder='Password (min 8 chars)'
                className='border p-2 rounded w-72'
                onChange={e => setPassword(e.target.value)} />
            <button onClick={handleSignUp}
                className='bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700'>
                Sign Up</button>
            {message && <p className='text-sm text-red-500'>{message}</p>}
            <Link href='/login' className='text-blue-500 text-sm'>
                Already have an account? Log in</Link>
        </div>
    );
}
