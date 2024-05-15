<script>
    let email = '';
    let password = '';
  
    const login = async () => {
        await fetch('http://127.0.0.1:5000/login',{
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email:email,
                password:password
            })
        })
        .then((res) => {
            if(res.status === 200){
                window.location.href = '/';
                return res.json()
            }
            else{
                throw new Error('Unable to log in')
            }
        })
    }
</script>

<div class="login">
    <form on:submit|preventDefault={login}>
        <input type="email" placeholder="Email" bind:value={email} required>
        <input type="password" placeholder="Password" bind:value={password} required>
        <button type="submit">Log In</button>
    </form>
</div>

<style>
    * {
        font-size: 14px;
    }
    .login {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 300px;
        padding: 20px;
        border: 1px solid #cccccc;
        border-radius: 8px;
    }

    input {
        margin-bottom: 10px;
        padding: 10px;
        width: 100%;
        box-sizing: border-box;
        border: 1px solid #cccccc;
        border-radius: 8px;
    }

    button {
        font-weight: 500;
        color: #FFFFFF;
        padding: 10px;
        width: 100%;
        cursor: pointer;
        background-color: #3c8afe;
        border: 1px solid #cccccc;
        border-radius: 8px;
        box-sizing: border-box;
    }
    button:hover{
        background-color: #1d76fc;
    }
</style>