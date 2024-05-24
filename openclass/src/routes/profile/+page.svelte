<script lang="ts">
    import Navbar from "../Navbar.svelte";
    let password = "";
    let newpassword = "";

    async function changePassword() {
        try {
            const response = await fetch('http://localhost:5000/change-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    old_password: password,
                    new_password: newpassword
                })
            });

            if (!response.ok) {
                const error = await response.json();
                alert(`Error: ${error.message}`);
                return;
            }

            const result = await response.json();
            alert(result.message);
        } catch (error) {
            alert('Password successfully changed');
        }
    }
</script>

<Navbar />

<div class="login">
    <form on:submit|preventDefault={changePassword}>
        <input type="password" placeholder="Old Password" bind:value={password} required>
        <input type="password" placeholder="New Password" bind:value={newpassword} required>
        <button type="submit">Change Password</button>
    </form>
</div>

<style>
    * {
        font-size: 16px;
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
        border: 1px solid #ddd;
        border-radius: 16px;
    }

    input {
        margin-bottom: 16px;
        padding: 10px;
        width: 100%;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 8px;
    }

    button {
        width: 100%;
        padding: 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 17px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #0056b3;
    }

</style>