<script lang=ts>
    import Navbar from "../Navbar.svelte";
    import { onMount } from 'svelte';

    let subjectId = '';

    let create_assessmentName = '';
    let create_subjectId = '';
    let create_maxMark: number;
    let create_dateDue: string;

    function changeColor(id: string) {
        const selectElement = document.getElementById(id) as HTMLElement;
        if (selectElement) {
            selectElement.style.color = '#333';
        }
    }

    type Subject = {
        subject_id: number;
        subject_name: string;
        coordinator: string;
    };

    type Assessment = {
        assessment_id: number;
        assessment_name: string;
        subject_id: number;
        max_mark: number;
        date_due: string;
    }

    let assessments: Assessment[] = [];

    let subjects: Subject[] = [];

    async function fetchSubjects() {
        const response = await fetch('http://localhost:5000/subjects');
        subjects = await response.json();
        console.log(subjects);
    }

    async function searchAssessments() {
        let url = 'http://localhost:5000/assessments?';
        if (subjectId) url += `subject_id=${subjectId}&`;

        const response = await fetch(url.slice(0, -1));
        assessments = await response.json();
    }

    async function createAssessment() {
        const response = await fetch('http://localhost:5000/assessments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                subject_id: create_subjectId,
                max_mark: create_maxMark,
                date_due: create_dateDue,
                assessment_name: create_assessmentName,
            }),
        });

        if (response.ok) {
            alert('Assessment created successfully');
            create_assessmentName = '';
            create_subjectId = '';
            create_maxMark = 0;
            create_dateDue = '';
            searchAssessments();
        } else {
            alert('Failed to create assessment');
        }
    }

    function formatISODate(isoDateString: string): string {
        const date = new Date(isoDateString);

        const options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'long', day: 'numeric' };
        const humanReadableDate = date.toLocaleDateString('en-US', options);

        return humanReadableDate;
    }

    onMount(async () => {
        await fetchSubjects();
        await searchAssessments();
    });
</script>

<Navbar />
<div class="wrapper">
    <div class="container">
        <div class="students">
          <h2>Search Assessments</h2>
            <select id="searchSubject" class="teachers" bind:value={subjectId} on:change={() => { searchAssessments(); changeColor('searchSubject'); }}>
                <option value="" disabled hidden selected>Select subject</option>
                {#each subjects as subject (subject.subject_id)}
                    <option value={subject.subject_id}>{subject.subject_name}</option>
                {/each}
            </select>
            <div class="student-list">
                {#each assessments as assessment (assessment.assessment_id)}
                  <a href="./assessments/{assessment.assessment_id}">
                    <div class="student-card">
                        <h3>{assessment.assessment_name}</h3>
                        <p>{formatISODate(assessment.date_due)}</p>
                    </div>
                  </a>
                {/each}
            </div>
        </div>
        <div class="create-box">
          <h2>Create a New Assessment</h2>
          <input bind:value={create_assessmentName} placeholder="Assessment Name" />
          <select id="createSubject" class="teachers" bind:value={create_subjectId} on:change={() => changeColor('createSubject')}>
            <option value="" disabled hidden selected>Select subject</option>
            {#each subjects as subject (subject.subject_id)}
                <option value={subject.subject_id}>{subject.subject_name}</option>
            {/each}
          </select>
          <input type="number" bind:value={create_maxMark} placeholder="Marks" />
          <input type="date" bind:value={create_dateDue} placeholder="Due Date" />
          <button on:click={createAssessment}>Create Assessment</button>
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

  input[type="date"]:before {
    color: #666;
    content: attr(placeholder) !important;
    margin-right: 0.5em;
  }
</style>
