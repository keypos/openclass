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

    type Subject = {
        subject_id: number;
        subject_name: string;
        coordinator: string;
    };

    let subjects: Subject[] = [];

    let behaviourId: number;

    function changeColor() {
        const selectElement = document.querySelector('.teachers') as HTMLElement;
        if (selectElement) {
          selectElement.style.color = '#333';
        }
    }

    async function fetchSubjects() {
        const response = await fetch('http://localhost:5000/subjects');
        subjects = await response.json();
        console.log(subjects);
    }

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

    async function addBehaviourComment() {
        const response = await fetch(`http://localhost:5000/comment`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                student_id: student_id,
                subject_id: behaviourId,
                comment: 'test'
            })
        })
        if (response.ok) {
            alert('Behaviour comment added successfully')
        } else {
            alert('Failed to add behaviour comment')
        }
    }

    onMount(async () => {
        await fetchSubjects();
        await studentInfo();
    });

</script>

<Navbar />
<div class="container">
    <div class="details">
        <h2>Student Details</h2>
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
            <button on:click={updateStudent}>Update Information</button>
            <button class="delete" on:click={deleteStudent}>Delete Student</button>
        {:else}
            Loading...
        {/if}
    </div>
    <div class=details>
        <h2>Behaviour Comments</h2>
        <select id="searchSubject" class="teachers" bind:value={behaviourId} on:change={changeColor}>
            <option value="" disabled hidden selected>Select subject</option>
            {#each subjects as subject (subject.subject_id)}
                <option value={subject.subject_id}>{subject.subject_name}</option>
            {/each}
        </select>
        <textarea placeholder="Behaviour comment"></textarea>
        <button on:click={addBehaviourComment}>Add Comment</button>
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
        margin: 30px;
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

    textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 4px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 16px;
        height: 128px;
        resize:none;
    }
</style>