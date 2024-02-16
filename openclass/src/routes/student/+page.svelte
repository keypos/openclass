<script lang="ts">
  import { page } from '$app/stores';
  import type { PageData } from './$types';

  let firstName = '';
  let lastName = '';

  $: students = ($page.data as PageData).student;
</script>

<h1>Students Lists</h1>
<div>
  <input type="text" bind:value={firstName} placeholder="First Name" />
  <input type="text" bind:value={lastName} placeholder="Last Name" />
</div>
<ul>
  {#each students as student}
    <li>{student.first_name} {student.last_name}</li>
  {/each}
</ul>
