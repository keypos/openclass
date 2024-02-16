import { getStudents } from '$lib/db';

export async function load() {
	const users = await getStudents();
	console.log(users);
	return {
		props: {
			users
		}
	};
}
