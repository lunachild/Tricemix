<script>
    import Button from './Button.svelte'
    import {
        apiData,
        apiLoading,
        loggedIn,
        logInKey,
        accountTest
    } from '../store.js';
    import {
        fade
    } from 'svelte/transition';

    let wantsToLogIn = false;
    let tryAgain = false;
    let text;
    $: key = $logInKey;
    $: if ($loggedIn) {
        text = "Log Out";
    } else {
        text = "Log In";
    }

    function logInFormClick() {
        wantsToLogIn = true;
    }

    function logOutClick() {
        loggedIn.update((li) => (!li));
        wantsToLogIn = false;
        logInKey.set("");
        apiData.set({});
        apiLoading.set(false);
    }

    function logInClick() {
        logInKey.set(key);
        accountTest().then(x => {
            if (x) {
                loggedIn.update((li) => (!li));
                wantsToLogIn = false;
                tryAgain = false;
            } else {
                tryAgain = true;
            }
        })
    }
</script>

{#if $loggedIn} 
<!-- log out button -->
<div>
<Button btnClass="lib" on:click={logOutClick}>
    <span>{text}</span>
</Button>
</div>
{:else}
<!-- log in block -->
{#if !wantsToLogIn}

<Button btnClass="lib" on:click={logInFormClick}>
    <span>{text}</span>
</Button>

{:else}

<form action="">
    <label><input class={tryAgain ? "error" : false} type="text" bind:value={key} in:fade></label>  
        <Button btnClass="lib" on:click={logInClick}>
            <span>{text}</span>
        </Button>
    </form>
{/if}
{/if}

<style lang="scss">
    // hehe
    label {
        display: inline;
    }
    form > * {
        margin-right: 1em;
    }
    input {
        border-radius: 3px;
        outline: none;
        &:focus {
            border: 2px solid var(--btn-bg);
        }
    }

    .error {
        border: 2px solid red;
        outline: none;
        &:focus {
            border: 3px solid red;
        }
    }

</style>