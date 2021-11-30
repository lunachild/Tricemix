<script>
	import Wallet from './components/Wallet.svelte';
	import WalletPreview from './components/WalletPreview.svelte'
	import Header from './components/Header.svelte';
	import BeamForm from './components/BeamForm.svelte';
	import Popup from './components/Popup.svelte';

	import {
		loggedIn
	} from './store'

	import FedPopup from './components/FedPopup.svelte';
	import FedForm from './components/FedForm.svelte';

	import {
		sending, sent
	} from "./store";
</script>

<Header />

{#if $loggedIn}
	<div>
		<article class="ui">
			<Wallet />
			<BeamForm />
		</article>
	</div>
	<Popup />

	{#if $sending}
	<div>
		<article class="ui">
			<div>
				Loading...
			</div>
		</article>
	</div>
	{:else if $sent}
	<div>
		<article class="ui">
			<div>
				Your were successfully added to Tricemix Service.
			</div>
		</article>
	</div>
	{:else}
	<div>
		<article class="ui">
			<FedForm />
		</article>
	</div>
	{/if}

	<FedPopup />
{:else}
	<div>
		<WalletPreview />
	</div>
{/if}

<style>
	div {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
		width: 100%;
		margin: 1em 0;
	}

	.ui {
		justify-content: space-between;
	}
	article {
		display: flex;
		width: 100%;
		max-width: 1000px;
		flex-direction: row;
		box-sizing: border-box;
	}
</style>