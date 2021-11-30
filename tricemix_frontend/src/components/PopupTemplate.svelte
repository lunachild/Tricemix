<script>
    import {
        fade
    } from 'svelte/transition';

    import MdClose from 'svelte-icons/md/MdClose.svelte'

    import {
        txPopupActive
    } from '../store';

    export const show = () => {
        txPopupActive.set(true);
    }

    export const hide = () => {
        txPopupActive.set(false);
    }
</script>

{#if $txPopupActive}
    <div on:focus={hide} tabindex="0" class="bg" transition:fade>
        <div tabindex="0" class="popup">
            <div class="x" on:click={hide}>
                <MdClose  />
            </div>
            <div class="content">
                <slot></slot>
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

    .content {
        height: 80%;
        margin: 2em;
        background-color: var(--middle-darkless);
        box-sizing: border-box;
        border-radius: 1em;
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