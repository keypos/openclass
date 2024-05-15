import { getUsers } from './db';

export async function load() {
	const users = await getUsers();
	console.log(users);
	return {
		props: {
			users
		}
	};
}
