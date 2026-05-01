import { redirect } from 'next/navigation';
import { createClient } from '@/utils/supabase/server';

export default async function DashboardPage() {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) redirect('/login');

    async function handleSignOut() {
        'use server';
        const supabase = await createClient();
        await supabase.auth.signOut();
        redirect('/login');
    }

    return (
        <div className='p-8'>
            <h1 className='text-2xl font-bold'>Welcome to your Dashboard!</h1>
            <p className='mt-2 text-gray-600'>Logged in as: {user.email}</p>
            <p className='text-xs text-gray-400 mt-1'>User ID: {user.id}</p>

            <form action={handleSignOut}>
                <button
                    type="submit"
                    className="mt-4 bg-red-500 hover:bg-red-600 text-white font-medium px-8 py-2.5 rounded-full transition-all active:scale-95 shadow-lg shadow-red-500/20"
                >
                    Log Out
                </button>
            </form>
        </div>
    );
}
