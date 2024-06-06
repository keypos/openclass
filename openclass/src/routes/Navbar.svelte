<script>
    import img from '$lib/assets/logo.png';
</script>
<div class="navbar">
    <div class="navbar-logo">
        <img src="{img}" alt="Logo" />
        <ul class="navbar-links">
            <p class="logo">OpenClass</p>
            <li><a href="/" class="navbar-link"><span class="material-symbols-rounded">home</span>Home</a></li>
            <li><a href="/students" class="navbar-link"><span class="material-symbols-rounded">person</span>Students</a></li>
            <li><a href="/subjects" class="navbar-link"><span class="material-symbols-rounded">book</span>Subjects</a></li>
            <li><a href="/assessments" class="navbar-link"><span class="material-symbols-rounded">assessment</span>Assessments</a></li>
            <li><a href="/profile" class="navbar-link"><span class="material-symbols-rounded">account_circle</span>Profile</a></li>
        </ul>
    </div>
</div>

<style>
    .navbar {
        font-weight: 400;
        background-color: #0c0e0f;
        color: #FFFFFF;
        padding: 14px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        width: 100%;
    }

    .navbar-logo {
        display: flex;
        align-items: center;
    }

    span.material-symbols-rounded {
        font-size: 18px;
        padding-right: 6px;
    }

    .navbar-logo img {
        margin-right: 8px;
        width: 30px;
    }

    .navbar-links {
        list-style-type: none;
        padding: 0;
        margin: 0;
        display: flex;
        align-items: center; 
    }

    .navbar-link {
        font-size: 18px;
        font-weight: 500;
        padding-left: 32px;
        text-decoration: none;
        color: white;
        display: flex;
        align-items: center;
    }

    .navbar-link span {
        margin-right: 4px;
    }

    .navbar-link:hover {
        color: #3787ff;
    }

    .logo {
        color: #3787ff;
        font-size: 18px;
        font-weight: 600;
        margin: 0;
        padding-right: 6px;
    }
</style>
