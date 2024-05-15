import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
	user: 'postgres',
	host: '127.0.0.1',
	database: 'openclass',
	password: 'postgres',
	port: 5432
});

export async function getUsers() {
	const client = await pool.connect();
	try {
		const result = await client.query('SELECT * FROM Student');
		return result.rows;
	} finally {
		client.release();
	}
}
