<script lang=ts>
    import Navbar from "../../Navbar.svelte";
    import { onMount } from 'svelte'
    import { page } from '$app/stores'
    import { goto } from '$app/navigation'
    const subject_id = $page.params.subject_id

    type Subject = {
      subject_id: number;
      subject_name: string;
      teacher_id: number;
    };

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

    let subject: Subject;

    async function subjectInfo() {
        const response = await fetch(`http://localhost:5000/subjects/${subject_id}`)
        subject = await response.json()
    }

    async function updateSubject() {
        const response = await fetch(`http://localhost:5000/subjects/${subject_id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(subject)
        })
        if (response.ok) {
            alert('Subject updated successfully')
        } else {
            alert('Failed to update subject')
        }
    }

    async function deleteSubject() {
        const response = await fetch(`http://localhost:5000/subjects/${subject_id}`, {
            method: 'DELETE',
        })
        if (response.ok) {
            alert('Student deleted successfully')
            goto('/subjects')
        } else {
            alert('Failed to delete student')
        }
    }

    onMount(async () => {
        await fetchTeachers();
        await subjectInfo();
    });
</script>

<Navbar />
<div class="container">
    <div class="details">
        <h2>Edit Subject Details</h2>
        {#if subject}
            <p>Subject Name</p>
            <input bind:value={subject.subject_name}/>
            <p>Subject Coordinator</p>
            <select class="teachers" bind:value={subject.teacher_id}>
                {#each teachers as teacher (teacher.teacher_id)}
                  <option value={teacher.teacher_id}>{teacher.first_name} {teacher.last_name}</option>
                {/each}
            </select>
            <button on:click={updateSubject}>Update</button>
            <button class="delete" on:click={deleteSubject}>Delete</button>
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