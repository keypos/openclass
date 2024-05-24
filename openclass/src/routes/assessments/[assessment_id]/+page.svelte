<script lang="ts">
    import Navbar from "../../Navbar.svelte";
    import { onMount } from 'svelte';
    import { page } from '$app/stores';
    import { goto } from '$app/navigation';

    const assessment_id = $page.params.assessment_id;

    type Assessment = {
      assessment_id: number;
      assessment_name: string;
      subject_id: number;
      max_mark: number;
    };

    type Student = {
        student_id: number;
        first_name: string;
        last_name: string;
    }

    type Subject = {
        subject_id: number;
        subject_name: string;
    };

    let subjects: Subject[] = [];

    let students: Student[] = [];

    let assessment: Assessment;

    async function fetchSubjects() {
        const response = await fetch('http://localhost:5000/subjects');
        subjects = await response.json();
    }

    async function assessmentInfo() {
        const response = await fetch(`http://localhost:5000/assessments/${assessment_id}`);
        assessment = await response.json();
    }

    async function fetchStudents() {
        const response = await fetch(`http://localhost:5000/students_in_subject/${assessment_id}`);
        students = await response.json();
        console.log(students)
    }

    async function updateAssessment() {
        const response = await fetch(`http://localhost:5000/assessments/${assessment_id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(assessment)
        });
        if (response.ok) {
            alert('Assessment updated successfully');
            goto('/assessments');
        } else {
            alert('Failed to update assessment');
        }
    }

    async function deleteAssessment() {
        const response = await fetch(`http://localhost:5000/assessments/${assessment_id}`, {
            method: 'DELETE',
        });
        if (response.ok) {
            alert('Assessment deleted successfully');
            goto('/assessments');
        } else {
            alert('Failed to delete assessment');
        }
    }

    onMount(async () => {
        await fetchSubjects();
        await fetchStudents();
        await assessmentInfo();
    });
</script>

<Navbar />
<div class="container">
    <div class="details">
        <h2>Edit Assessment Details</h2>
        {#if assessment}
            <p>Assessment Name</p>
            <input bind:value={assessment.assessment_name} />
            <p>Maximum Mark</p>
            <input bind:value={assessment.max_mark} />
            <p>Subject</p>
            <select class="teachers" bind:value={assessment.subject_id}>
                {#each subjects as subject (subject.subject_id)}
                  <option value={subject.subject_id}>{subject.subject_name}</option>
                {/each}
            </select>
            <button on:click={updateAssessment}>Update</button>
            <button class="delete" on:click={deleteAssessment}>Delete</button>
        {:else}
            Loading...
        {/if}
    </div>
    <div class="student-list">
                {#each students as student (student.student_id)}
                    <div class="student-card">
                        <h3>{student.first_name} {student.last_name}</h3>
                        <p>Mark: <input class="mark" type="number"></p>
                    </div>
                {/each}
                <button on:click={updateAssessment}>Submit Marks</button>
        </div>
</div>


<style>
    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .details {
        border: solid 1px #ddd;
        border-radius: 16px;
        padding: 30px;
        width: 300px;
    }

    h2 {
        color: #333;
        font-size: 22px;
        margin-top: 0;
        margin-bottom: 20px;
        text-align: center;
    }
    .mark {
        max-width: 80px;
        height: 32px;
    }

    p {
        font-size: 16px;
        color: #333;
        margin-bottom: 5px;
    }

    input {
        width: 100%;
        padding: 10px;
        margin-bottom: 4px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 16px;
    }

    button {
        width: 100%;
        padding: 12px;
        margin-top: 16px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #0056b3;
    }

    .teachers {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        margin-bottom: 16px;
        border-radius: 8px;
        font-size: 16px;
        background-color: #fff;
    }

    .delete {
        background-color: #dc3545;
    }

    .delete:hover {
        background-color: #bd2130;
    }

     .student-list {
    width: 300px;
    overflow-y: auto;
    padding-bottom: 20px;
    box-sizing: border-box;
    padding-left: 50px;
  }

  .student-card {
    background-color: white;
    border-radius: 8px;
    padding: 12px;
    padding-bottom: 0px;
    padding-top: 4px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    width: 97%;
    box-sizing: border-box;
  }

  .student-card:hover {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.1);
    background-color: #f8f8f8;
  }
    h3 {
    margin: 0 0 10px;
    color: #333;
    font-size: 18px;
  }

  a {
    text-decoration: none;
  }

</style>