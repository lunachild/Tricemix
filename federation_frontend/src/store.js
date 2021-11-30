import {
    writable
} from 'svelte/store';

export const popupActive = writable(false);

export const email = writable("");

export const id = writable("");

export const sending = writable(false);

export const sent = writable(false);