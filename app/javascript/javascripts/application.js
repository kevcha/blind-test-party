require("@rails/ujs").start()
require("@rails/activestorage").start()

import { createConsumer } from "@rails/actioncable"

const participantsNode = document.querySelector('#participants');

if (participantsNode) {
  const username = participantsNode.dataset.currentUser;
  const consumer = createConsumer('/cable')
  const refresh = document.querySelector('#refresh');
  const start = document.querySelector('#start');
  const body = document.querySelector('body');

  const roomChannel = consumer.subscriptions.create(
    { channel: "RoomChannel", token: participantsNode.dataset.token },
    {
      initialized() {
        console.log(username, 'initialize')
      },
      connected() {
        console.log(username, 'connected')
      },
      received(data) {
        analyse(data);
      },
      disconnected() {
        console.log(username, 'disconnected')
      },
      rejected() {
        console.log(username, 'rejected')
      }
    }
  );

  const analyse = (data) => {
    if (data.dealer == username) {
      playerIsDealer()
    } else {
      playerIsNotDealer()
    }
    updateGameStatus(data);
  }

  refresh.addEventListener('click', () => {
    roomChannel.perform('refresh')
  })

  start.addEventListener('click', () => {
    roomChannel.perform('start')
  })

  const updateGameStatus = (data) => {
    const html = data.players.map((player) => {
      return `<div data-player="${player.username}" class="${ data.dealer == player.username ? 'dealer' : 'player'} relative px-8 flex items-center py-4 rounded bg-blue-400 text-white mb-4">
        <span class="rounded bg-gray-100 text-blue-400 mr-4 px-4">${player.score}</span>
        <div>
          <p>${player.username}</p>
          <p>${player.punchline}</p>
        </div>
      </div>`;
    }).join('');
    participantsNode.innerHTML = html;
  }

  const playerIsDealer = () => {
    body.classList.add('current-dealer');
  }

  const playerIsNotDealer = () => {
    body.classList.remove('current-dealer');
  }

  participantsNode.addEventListener('click', (event) => {
    const player = event.target.closest('.player');

    if (player && body.classList.contains('current-dealer')) {
      roomChannel.perform('found', { username: player.dataset.player })
    }
  })
}
