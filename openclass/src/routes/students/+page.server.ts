import { getStudents } from '$lib/db';

export async function load() {
    const students = await getStudents();
    return {
        students
    };
}
