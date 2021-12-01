<script>
    import {
        CreateTestAccount
    } from '../store.js';

    import Button from './Button.svelte'
</script>

<div>
<Button btnClass="lib" on:click={CreateTestAccount}>
    <span>Create Account</span>
</Button>
</div>

<style lang="scss">
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