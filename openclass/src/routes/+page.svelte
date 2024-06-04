<script>
    import Navbar from "./Navbar.svelte";
    import Timetable from "./Timetable.svelte";
    import User from "./User.svelte";
</script>

<Navbar />
<div class="row">
    <div class="column"><User /><Timetable /></div>
    <div class="column"></div>
    <div class="column"></div>
  </div>

<slot />

<style>
    .column {
        float: left;
        width: 33.33%;
    }

    .row {
        padding-top: 50px;
    }
    .row:after {
        content: "";
        display: table;
        clear: both;
    }
</style>