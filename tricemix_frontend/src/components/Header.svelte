<script>
    import Logo from '../../public/assets/logoColour.svg'
    import LogIn from './LogIn.svelte';
    import Create from './Create.svelte';
</script>

<header>
    <a href="/"><Logo width="50px" style="fill:white" /></a>
    <div>
        <LogIn />
        <Create />
    </div>
</header>

<style>
    div {
        display: flex
    }
    header {
        width: 100%;
        position: sticky;
        top: 0;
        background: #F2994A;  /* fallback for old browsers */
        background: linear-gradient(to right, #F2C94C, #F2994A); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        display: flex;
        padding: 0.5em;
        margin: 0 auto;
        align-items: center;
        justify-content: space-between;
        box-sizing: border-box;
    }
</style>