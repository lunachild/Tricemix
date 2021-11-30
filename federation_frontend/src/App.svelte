<script>
	import Header from './components/Header.svelte';
	import Popup from './components/Popup.svelte';
	import Form from './components/Form.svelte';

	import {
		sending, sent
	} from "./store";
</script>

<Header />

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
		<Form />
	</article>
</div>
{/if}

<Popup />

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
		max-width: 750px;
		flex-direction: row;
		box-sizing: border-box;
	}
</style>