<script>
    import img from '$lib/assets/logo.png';
</script>
<div class="navbar">
    <div class="navbar-logo">
        <img src="{img}" alt="Logo" />
        <ul class="navbar-links">
            <p class="logo">OpenClass</p>
            <li><a href="/" class="navbar-link">Home</a></li>
            <li><a href="/students" class="navbar-link">Students</a></li>
            <li><a href="/assessments" class="navbar-link">Assessments</a></li>
            <li><a href="/profile" class="navbar-link">Profile</a></li>
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
    }
    .navbar-link:hover {
        color: #3787ff;
    }

    .logo{
        color: #3787ff;
        font-size: 18px;
        font-weight: 600;
        margin: 0;
    }
</style>