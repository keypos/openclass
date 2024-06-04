<script>
    let firstName = '';
    let lastName = '';
    let grade = '';

    async function searchStudents() {
        let url = 'http://localhost:5000/students?';
        if (firstName) url += `first_name=${firstName}&`;
        if (lastName) url += `last_name=${lastName}&`;
        if (grade) url += `grade=${grade}&`;

        const response = await fetch(url.slice(0, -1)); // Remove the trailing '&'
        const students = await response.json();
        console.log(students);
    }
</script>

<input bind:value={firstName} placeholder="First Name" />
<input bind:value={lastName} placeholder="Last Name" />
<input bind:value={grade} placeholder="Grade" />
<button on:click={searchStudents}>Search</button>