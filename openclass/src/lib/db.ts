import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
	user: 'postgres',
	host: '127.0.0.1',
	database: 'openclass',
	password: 'postgres',
	port: 5432
});

export async function getStudents() {
	const client = await pool.connect();
	try {
		const result = await client.query('SELECT * FROM student;');
		return result.rows;
	} finally {
		client.release();
	}
}

function sentenceCase(str: String) {
  if (!str) return str;
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
}

export async function getStudent(firstName: string, lastName: string) {
	const client = await pool.connect();
	try {
		const result = await client.query(`select * from student where first_name='${sentenceCase(firstName)}' and last_name='${sentenceCase(lastName)}';`);
		return result.rows;
	} finally {
		client.release();
	}
}
