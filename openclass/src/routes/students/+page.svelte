<script lang="ts">
  import { page } from '$app/stores';
  import type { PageData } from './$types';

  $: students = ($page.data as PageData).students;
</script>

<h1>Students List</h1>
<ul>
  {#each students as student}
    <li>{student.first_name} {student.last_name}</li>
  {/each}
</ul>
