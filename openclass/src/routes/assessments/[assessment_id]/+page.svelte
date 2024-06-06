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
    };

    type Subject = {
        subject_id: number;
        subject_name: string;
    };

    let subjects: Subject[] = [];

    async function fetchSubjects() {
        const response = await fetch('http://localhost:5000/subjects');
        subjects = await response.json();
    }

    let assessment: Assessment;

    async function assessmentInfo() {
        const response = await fetch(`http://localhost:5000/assessments/${assessment_id}`);
        assessment = await response.json();
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
</style>