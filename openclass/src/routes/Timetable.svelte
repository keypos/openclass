<script>
    let currentDate = new Date().toISOString().slice(0, 10);
</script>

<div class="timetable">
    <input class="date" type="date" bind:value={currentDate}>
    <table>
        <tr>
        <th>Period</th>
        <th>Class</th>
        <th>Room</th>
        </tr>
        <tr>
        <td>1</td>
        <td>Maths Advanced</td>
        <td>A3</td>
        </tr>
        <tr>
        <td>2</td>
        <td>Biology</td>
        <td>S3</td>
        </tr>
        <tr class="active">
            <td>3</td>
            <td>Physics</td>
            <td>A4</td>
        </tr>
        <tr>
            <td>4</td>
            <td>English</td>
            <td>B8</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Chemistry</td>
            <td>S1</td>
        </tr>
        <tr>
            <td>6</td>
            <td>SDD</td>
            <td>A6</td>
        </tr>
    </table>
</div>

<style>
    .timetable{
        margin: 16px;
    }
    .date{
        font-family: 'Work Sans', sans-serif;
    }
    th, td {
        text-align: center;
        padding: 16px;
        border-bottom: 1px #aaa solid;
    }
    .active{
        background-color: #EEEEEE;
    }
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 0;
    }
</style>