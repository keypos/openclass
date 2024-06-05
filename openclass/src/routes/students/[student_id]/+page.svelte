<script lang=ts>
    import Navbar from "../../Navbar.svelte";
    import { onMount } from 'svelte'
    import { goto } from '$app/navigation'
    import { page } from '$app/stores'
    const student_id = $page.params.student_id

    type Student = {
      student_id: number;
      first_name: string;
      last_name: string;
      email: string;
      phone: string;
      grade: string;
    };

    let student: Student;

    async function studentInfo() {
        const response = await fetch(`http://localhost:5000/students/${student_id}`)
        student = await response.json()
    }

    async function updateStudent() {
        const response = await fetch(`http://localhost:5000/students/${student_id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(student)
        })
        if (response.ok) {
            alert('Student updated successfully')
        } else {
            alert('Failed to update student')
        }
    }

    async function deleteStudent() {
        const response = await fetch(`http://localhost:5000/students/${student_id}`, {
            method: 'DELETE',
        })
        if (response.ok) {
            alert('Student deleted successfully')
            goto('/students')
        } else {
            alert('Failed to delete student')
        }
    }

    onMount(studentInfo)
</script>

<Navbar />
<div class="container">
    <div class="details">
        <h2>Edit Student Details</h2>
        {#if student}
            <p>First Name</p>
            <input bind:value={student.first_name}/>
            <p>Last Name</p>
            <input bind:value={student.last_name}/>
            <p>Email Name</p>
            <input bind:value={student.email}/>
            <p>Phone Number</p>
            <input bind:value={student.phone}/>
            <p>Grade</p>
            <input bind:value={student.grade}/>
            <button on:click={updateStudent}>Update</button>
            <button class="delete" on:click={deleteStudent}>Delete</button>
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

    .delete {
        background-color: #dc3545;
    }

    .delete:hover {
        background-color: #bd2130;
    }
</style>