const participantsNode = document.querySelector('#participants');
const body = document.querySelector('body');

const renderPlayers = (data, username) => {
  const html = data.players.map((player) => {
    return `<div data-player="${player.id}" class="${ (data.dealer && data.dealer.id == player.id) ? 'dealer' : 'player'} relative px-8 flex items-center py-4 rounded bg-blue-400 text-white mb-4">
      <span class="rounded bg-gray-100 text-blue-400 mr-4 px-4">${player.score}</span>
      <div>
        <p>${player.username} ${(data.started && player.ready) ? '👌' : '⏳'}</p>
        <p>${player.punchline}</p>
      </div>
    </div>`;
  }).join('');
  participantsNode.innerHTML = html;
}

const playerIsDealer = (data) => {
  body.classList.add('current-dealer');

  if (data.song_id && !data.everyone_ready) {
    document.querySelector('.loading').classList.remove('hidden');
  } else {
    document.querySelector('.loading').classList.add('hidden');
  }

  if (data.song_id && data.everyone_ready) {
    document.querySelector('.toggle').classList.remove('hidden');
  } else {
    document.querySelector('.toggle').classList.add('hidden');
  }
}

const playerIsNotDealer = () => {
  body.classList.remove('current-dealer');
}

const currentDealer = (dealer) => {
  document.querySelector('.who-is-dealer').classList.remove('hidden');
  document.querySelector('.who-is-dealer span').innerText = dealer.username;
}

const isDealer = () => {
  return body.classList.contains('current-dealer');
}

const updateRoomStatus = (data) => {
  if (data.started) {
    document.querySelector('#start').classList.add('hidden');
    document.querySelector('h1').innerText = "C'est partit 🎊🥳🕺✨ !!!";
    document.querySelector('.sharable-link').classList.add("hidden");
  }
}

const updateChat = (messages) => {
  const html = messages.map((message) => {
    return `<p><span class="text-blue-300">${message.player}</span> : ${message.body}</p>`
  }).join('');
  document.querySelector('.messages').innerHTML = html;
}

export { renderPlayers, playerIsDealer, playerIsNotDealer, isDealer, updateRoomStatus, currentDealer, updateChat };
