<script>
    import {
        balances,
        apiLoading,
        apiRequest,
        apiDataTransactions
    } from '../store';

    import {
        onMount
    } from 'svelte';

    import TokenBalance from './TokenBalance.svelte';
    import Button from './Button.svelte';
    import TransactionDisplay from './TransactionDisplay.svelte';

    let btnText;

    $: if ($apiLoading) {
        btnText = "Loading..."
    } else {
        btnText = "Refresh";
    }

    onMount(() => {
        apiLoading.set(true);
        apiRequest();
    });
</script>
<div class="everything">
    <h2>Your Wallet</h2>
    <main>
        <Button on:click="{apiRequest}">{btnText}</Button>

        <div class={$apiLoading ? "loading" : "response" }>
            <h3>Wallet Balance</h3>

            {#if !$apiLoading}
            {#each $balances.reverse() as tb}
               <TokenBalance {...tb}/>
            {/each}
            {/if}

            <h3>Recent Transactions</h3>

            {#if !$apiLoading}
                {#each $apiDataTransactions.reverse() as tx}
                   <TransactionDisplay {...tx}/>
                {/each}
            {/if}
        </div>
    </main>
</div>
<style lang="scss">
    .response,
    .loading {
        display: flex;
        flex-direction: column;
        justify-content: safe;
        align-items: center;
        width: 100%;
        overflow: hidden;
    }

    .loading {
        color: rgb(172, 172, 172);
    }

    main {
        border-radius: 2em;
        color: white;
        padding: 1.3em;
        box-sizing: border-box;
    }

    .everything {
        box-sizing: border-box;
        width: 48%;
    }

    
    h2 {
        text-align: center;
    }

</style>