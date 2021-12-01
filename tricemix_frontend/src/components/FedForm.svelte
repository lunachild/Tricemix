<script>
    import {
        popupActive,
        email,
        id
    } from '../store';
    import Button from './Button.svelte';

    let emaili = "";
    $: emailu = emaili.toLowerCase();
    let idi = "";
    $: idu = idi.toUpperCase();

    let emailValid = true;
    let idValid = true;

    function signForm() {
        const eregex = new RegExp('^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
        if (eregex.test(emailu)) {
            emailValid = true;
            const iregex = new RegExp("([A-Z0-9])+", "g");
            if (id.length = 56 &&
            iregex.test(idu)) {
                idValid = true;
                email.set(emailu);
                id.set(idu);
                popupActive.set(true);
            } else { //invalid id
                idValid = false;
            }
        } else { //invalid email
            emailValid = false;
        }
    }
</script>

<div class="everything">
    <h2>Tricemix Federation Service Interface</h2>
    <p>Want to link your email address to receive payments seamlessly?</p>
    <main>
        <form action="">
            <div class="inputs">
                <div class="{emailValid ? "field" : "fieldError"}">
                    <input type="text" name="email" class="input" placeholder=" " bind:value="{emaili}" />
                    <label for="email" class="label">Email Address</label>
                </div>
                <div class="{idValid ? "field" : "fieldError"}">
                    <input type="text" name="id" class="input" placeholder=" " bind:value="{idi}" />
                    <label for="id" class="label">Digitalbits Account ID</label>
                </div>
            </div>
            <Button on:click={signForm}>Link Account</Button>
        </form>
    </main>
</div>

<style>
    main {
        border-radius: 2em;
        color: white;
        padding: 1.3em;
        padding-top: 0.3em;
        box-sizing: border-box;
        height: 260px;
    }

    form {
        width: 90%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
        /* margin-bottom: 1.4em; */
    }


    h2, p {
        text-align: center;
    }

    .field {
        width: 100%;
        margin: 0 auto;
        position: relative;
        border-bottom: 2px dashed white;
        margin: 2.2rem auto 1rem;
        transition: 500ms;
    }

    .fieldError {
        width: 100%;
        margin: 0 auto;
        position: relative;
        border-bottom: 2px dashed red;
        margin: 2.2rem auto 1rem;
        transition: 500ms;
    }

    .label {
        color: white;
        font-size: 1.2rem;
    }

    .input {
        outline: none;
        border: none;
        overflow: hidden;
        margin: 0;
        width: 100%;
        padding: 0.25rem 0;
        background: none;
        color: white;
        font-size: 1.2em;
        font-weight: bold;
        transition: border 500ms;
    }

    /* Border animation */
    .field::after {
        content: "";
        position: relative;
        display: block;
        height: 4px;
        width: 100%;
        background: var(--light);
        transform: scaleX(0);
        transform-origin: 0%;
        opacity: 0;
        transition: all 500ms ease;
        top: 2px;
    }

    .field:focus-within {
        border-color: transparent;
    }

    .field:focus-within::after {
        transform: scaleX(1);
        opacity: 1;
    }

    /* Label animation */
    .label {
        z-index: -1;
        position: absolute;
        transform: translateY(-2rem);
        transform-origin: 0%;
        transition: transform 400ms;
    }

    .field:focus-within .label,
    .input:not(:placeholder-shown)+.label {
        transform: scale(0.8) translateY(-5rem);
        opacity: 1;
    }

    .everything {
        box-sizing: border-box;
        width: 100%;
    }

</style>