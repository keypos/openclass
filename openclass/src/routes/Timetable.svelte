<script lang="ts">
  import { onMount } from 'svelte';
  import { format } from 'date-fns';

  type ClassData = {
    room: string;
    subject_name: string;
    period_number: number;
  };

  let classes: ClassData[] = [];
  let teacherId: number = 1;
  let date: Date = new Date();
  let formattedDate: string = format(date, 'yyyy-MM-dd');

  async function fetchClasses() {
    const response = await fetch(`http://localhost:5000/classes?teacher_id=${teacherId}&date=${formattedDate}`);
    classes = await response.json();
  }

  function handleDateChange(event: Event) {
    const input = event.target as HTMLInputElement;
    formattedDate = input.value;
    fetchClasses();
  }

  onMount(() => {
    fetchClasses();
  });
</script>

<main>
  <h2>Classes</h2>

  <input type="date" id="date" bind:value={formattedDate} on:change={handleDateChange} />

  <table>
    <thead>
      <tr>
        <th>Period</th>
        <th>Room</th>
        <th>Subject</th>
      </tr>
    </thead>
    <tbody>
      {#each classes as period_class, index}
        <tr>
          <td>{index + 1}</td>
          <td>{period_class.room}</td>
          <td>{period_class.subject_name}</td>
        </tr>
        {#if (index + 1) === 2}
          <tr>
            <td colspan="3" style="text-align: center; font-weight: bold;">Recess</td>
          </tr>
        {/if}
        {#if (index + 1) === 4}
          <tr>
            <td colspan="3" style="text-align: center; font-weight: bold;">Lunch</td>
          </tr>
        {/if}
      {/each}
    </tbody>
  </table>
</main>

<style>
  main {
    padding: 1em;
    max-width: 800px;
    margin: 0 auto;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1em;
    overflow: hidden;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    padding-right: 0;
    text-align: left;
  }
  th {
    background-color: #f4f4f4;
  }
  input {
    padding: 4px;
    border: 1px solid #ccc;
    border-radius: 8px;
  }
</style>
