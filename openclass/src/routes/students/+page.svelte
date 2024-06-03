<script lang="ts">
  import { page } from '$app/stores';
  import type { PageData } from './$types';

  $: students = ($page.data as PageData).students;
</script>

<<<<<<< HEAD
<h1>List of students</h1>
=======
<h1>Students List</h1>
>>>>>>> ef04f91b50fbd9670a28918cd07cae00b3cc57c6
<ul>
  {#each students as student}
    <li>{student.first_name} {student.last_name}</li>
  {/each}
</ul>
