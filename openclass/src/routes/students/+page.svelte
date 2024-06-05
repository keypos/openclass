<script lang="ts">
	import Navbar from "../Navbar.svelte";

    let create_firstName = '';
    let create_lastName = '';
    let create_grade = '';
    let create_email = '';
    let create_phone = '';

    let firstName = '';
    let lastName = '';
    let grade = '';

    type Student = {
        student_id: number;
        first_name: string;
        last_name: string;
        grade: string;
    };

    let students: Student[] = [];

    async function createStudent() {
        let url = 'http://localhost:5000/students?';
      
    }

    async function searchStudents() {
        let url = 'http://localhost:5000/students?';
        if (firstName) url += `first_name=${firstName}&`;
        if (lastName) url += `last_name=${lastName}&`;
        if (grade) url += `grade=${grade}&`;

        const response = await fetch(url.slice(0, -1));
        students = students = await response.json();
    }
</script>

<Navbar />
<div class="wrapper">
    <div class="container">
        <div class="students">
            <div class="search-box">
                <h2>Search for students</h2>
                <input bind:value={firstName} placeholder="First Name" />
                <input bind:value={lastName} placeholder="Last Name" />
                <input bind:value={grade} type="number" min=1 max=12 placeholder="Grade" />
                <button on:click={searchStudents}>Search</button>
            </div>
        
            <div class="student-list">
                {#each students as student (student.student_id)}
                    <div class="student-card">
                        <h2>{student.first_name} {student.last_name}</h2>
                        <p>Grade: {student.grade}</p>
                    </div>
                {/each}
            </div>
        </div>
        <div class="create-box">
          <h2>Create a new student</h2>
          <input bind:value={create_firstName} placeholder="First Name" />
          <input bind:value={create_lastName} placeholder="Last Name" />
          <input bind:value={create_grade} type="number" min=1 max=12 placeholder="Grade" />
          <input bind:value={create_email} type="email" placeholder="Email" />
          <input bind:value={create_phone} type="tel" placeholder="Phone number" />
          <button on:click={createStudent}>Create Student</button>
        </div>
    </div>
</div>

<style>
.wrapper {
  margin-top: 100px;
  padding: 0;
  height: 80vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.container {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  width: 100%;
  max-width: 780px;
  padding: 20px;
  box-sizing: border-box;
  height: 100%;
}

.students {
  display: flex;
  flex-direction: column;
  width: 50%;
  max-width: 350px;
  padding-right: 20px;
  box-sizing: border-box;
  height: 100%;
}

.search-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  z-index: 1;
  flex-shrink: 0;
}

.create-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 50%;
  max-width: 350px;
  z-index: 1;
}

input, button {
  width: 100%;
  padding: 10px;
  margin-bottom: 15px;
  box-sizing: border-box;
  border-radius: 8px;
  font-size: 16px;
}

input {
  border: 1px solid #ccc;
  transition: border-color 0.3s;
}

input:focus {
  outline: none;
  border-color: #a1a1a1;
}

button {
  background-color: #007bff;
  color: white;
  border: none;
  font-size: 18px;
  cursor: pointer;
  transition: background-color 0.3s;
  margin-bottom: 25px;
}

button:hover {
  background-color: #0056b3;
}

.student-list {
  width: 100%;
  overflow-y: auto;
  padding-top: 20px;
  box-sizing: border-box;
  flex-grow: 1;
}

.student-card {
  background-color: white;
  border-radius: 8px;
  padding: 20px;
  margin-top: 20px;
  border: 1px solid #e0e0e0;
  width: 100%;
  box-sizing: border-box;
}

h2 {
  margin: 0 0 10px;
  color: #333;
  font-size: 20px;
}

p {
  margin: 0;
  color: #666;
  font-size: 16px;
}
</style>