<script lang=ts>
  import Navbar from "../Navbar.svelte";

  let create_subjectName = '';
  let create_coordinator = '';

  let subjectName = '';
  let coordinater = '';

  type Subject = {
      subject_id: number;
      subject_name: string;
      coordinator: string;
  };

  let subjects: Subject[] = [];

  async function createSubject() {
      let url = 'http://localhost:5000/subjects?';
  }

  async function searchSubjects() {
      let url = 'http://localhost:5000/subjects?';
      if (subjectName) url += `subject_name=${subjectName}&`;
      if (coordinater) url += `coordinator=${coordinater}&`;

      const response = await fetch(url.slice(0, -1));
      subjects = await response.json();
      console.log(subjects);
  }

  searchSubjects();
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
          <input bind:value={create_coordinator} placeholder="Subject Coordinator" />
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
    margin-bottom: 15px;
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
</style>