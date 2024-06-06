<script lang=ts>
  import Navbar from "../Navbar.svelte";
  import { onMount } from 'svelte';

  let create_subjectName = '';
  let create_coordinator = '';

  let subjectName = '';
  let coordinater = '';

  function changeColor() {
    const selectElement = document.querySelector('.teachers') as HTMLElement;
    if (selectElement) {
      selectElement.style.color = '#333';
    }
  }

  type Subject = {
      subject_id: number;
      subject_name: string;
      coordinator: string;
  };

  let subjects: Subject[] = [];

  async function searchSubjects() {
    let url = 'http://localhost:5000/subjects?';
    if (subjectName) url += `subject_name=${subjectName}&`;
    if (coordinater) url += `coordinator=${coordinater}&`;

    const response = await fetch(url.slice(0, -1));
    subjects = await response.json();
  }

  type Teacher = {
    teacher_id: number;
    first_name: string;
    last_name: string;
  };

  let teachers: Teacher[] = [];

  async function fetchTeachers() {
    const response = await fetch('http://localhost:5000/teachers');
    teachers = await response.json();
  }

  async function createSubject() {
    const response = await fetch('http://localhost:5000/subjects', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        subject_name: create_subjectName,
        teacher_id: create_coordinator,
      }),
    });

    if (response.ok) {
      alert('Subject created successfully');
      create_subjectName = '';
      create_coordinator = '';
    } else {
      alert('Failed to create subject');
    }
    searchSubjects();
  }

   onMount(async () => {
    await fetchTeachers();
    await searchSubjects();
  });
</script>

<Navbar />
<div class="wrapper">
    <div class="container">
        <div class="students">
            <div class="search-box">
                <h2>Search for Subjects</h2>
                <input bind:value={subjectName} placeholder="Subject Name" on:input={searchSubjects} />
                <input bind:value={coordinater} placeholder="Coordinator" on:input={searchSubjects} />
            </div>
        
            <div class="student-list">
                {#each subjects as subject (subject.subject_id)}
                  <a href="./subjects/{subject.subject_id}">
                    <div class="student-card">
                        <h3>{subject.subject_name}</h3>
                        <p>{subject.coordinator}</p>
                    </div>
                  </a>
                {/each}
            </div>
        </div>
        <div class="create-box">
          <h2>Create a New Subject</h2>
          <input bind:value={create_subjectName} placeholder="Subject Name" />
          <select class="teachers" bind:value={create_coordinator} on:change={changeColor}>
          <option value="" disabled hidden selected>Select coordinator</option>
            {#each teachers as teacher (teacher.teacher_id)}
              <option value={teacher.teacher_id}>{teacher.first_name} {teacher.last_name}</option>
            {/each}
          </select>
          <button on:click={createSubject}>Create Subject</button>
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
    margin-bottom: 16px;
    box-sizing: border-box;
    border-radius: 8px;
    font-size: 16px;
  }

  input {
    border: 1px solid #ddd;
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

  a {
    text-decoration: none;
  }


  .student-list {
    width: 100%;
    overflow-y: auto;
    padding-bottom: 20px;
    box-sizing: border-box;
    flex-grow: 1;
  }

  .student-card {
    background-color: white;
    border-radius: 8px;
    padding: 12px;
    margin-bottom: 12px;
    border: 1px solid #ddd;
    width: 97%;
    box-sizing: border-box;
  }

  .student-card:hover {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.1);
    background-color: #f8f8f8;
  }

  h2 {
    margin: 0 0 10px;
    color: #333;
    font-size: 20px;
  }

  h3 {
    margin: 0 0 10px;
    color: #333;
    font-size: 18px;
  }

  p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .teachers {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    margin-bottom: 16px;
    border-radius: 8px;
    font-size: 16px;
    color: #777;
    background-color: #fff;
  }

  .teachers option {
    color: #333;
  }
</style>