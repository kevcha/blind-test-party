require("@rails/ujs").start()
require("@rails/activestorage").start()

import { perform, setCallback } from "./components/room_channel";
import { createConsumer } from "@rails/actioncable"
import { renderPlayers, playerIsDealer, playerIsNotDealer, isDealer } from "./components/dom_updator";

const participantsNode = document.querySelector('#participants');

if (participantsNode) {
  const username = participantsNode.dataset.currentUser;
  const refresh = document.querySelector('#refresh');
  const start = document.querySelector('#start');

  setCallback((data) => {
    if (data.dealer == username) {
      playerIsDealer()
    } else {
      playerIsNotDealer()
    }
    renderPlayers(data, username);
  })

  refresh.addEventListener('click', () => {
    perform('refresh')
  })

  start.addEventListener('click', () => {
    perform('start')
  })

  participantsNode.addEventListener('click', (event) => {
    const player = event.target.closest('.player');

    if (player && isDealer()) {
      perform('found', { username: player.dataset.player })
    }
  })
}
