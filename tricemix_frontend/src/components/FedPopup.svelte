<script>
    import {
        fade
    } from 'svelte/transition';

    import Button from './Button.svelte';
    import MdClose from 'svelte-icons/md/MdClose.svelte'

    import {
        popupActive,
        email,
        id, sending
    } from '../store';

    export const show = () => {
        popupActive.set(true);
    }

    export const hide = () => {
        popupActive.set(false);
    }

    function confirmClick() {
        sending.set(true);
        // send to the server
        // use a function in a store so that the popup can disappear?
        hide();
    }

    $: idShorter = $id.substring(0, 7) + "..." + $id.substring(51);

</script>

{#if $popupActive}
    <div on:focus={hide} tabindex="0" class="bg" transition:fade>
        <div tabindex="0" class="popup">
            <div class="x" on:click={hide}>
                <MdClose  />
            </div>
            <div class="content">
                <div class="checkthese">
                    Are you sure you want to link<br>
                    <div class="checkthis">{$email}</div>
                    to<br>
                    <div class="checkthis" id="id">{idShorter}</div>?
                </div>
                <Button on:click={confirmClick}>
                    Confirm
                </Button>
            </div>
        </div>
    </div>
{/if}

<style>
    .bg {
        position: fixed;
        top: 50%;
        left: 50%;
        /* bring your own prefixes */
        transform: translate(-50%, -50%);
    }

    .popup {
        position: relative;
        height: 300px;
        width: 500px;
        border: 1px solid var(--light);
        background-color: var(--middle-dark);
        border-radius: 2em;
        box-sizing: border-box;
        color: white;
    }

    .checkthese {
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        margin: 0.6em;
        box-sizing: border-box;
    }

    .checkthis {
        text-align: center;
        display: inline;
        font-weight: bold;
        background-color: var(--middle-darker);
        border-radius: 100px;
        padding: 0.3em 0.5em;
        margin: 0.3em;
    }

    #id {
        display: inline-block;
    }

    .content {
        height: 80%;
        margin: 2em;
        background-color: var(--middle-darkless);
        box-sizing: border-box;
        border-radius: 1em;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    
    .x {
        position: absolute;
        right: -0.7em;
        top: -0.7em;
        height: 2.3em;
        width: 2.3em;
        background-color: var(--btn-bg);
        color: var(--middle);
        border-radius: 100%;
        cursor: pointer;
    }
</style>