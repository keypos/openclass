import { getStudent } from '$lib/db';

export async function load() {
    const student = await getStudent("liam", "smith");
    return {
        student
    };
}
