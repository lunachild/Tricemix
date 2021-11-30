<script>
    import LogIn from './LogIn.svelte';
</script>

<main>
    <div>
        <h2>
            Tricemix Demo for DigitalBits Blockchain Hackathon @ 2021
        </h2>
        The current demo only supports account creation, logging in and sending DigitalBits to your friends.
        <LogIn />
    </div>
</main>

<style>
    div {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
</style>