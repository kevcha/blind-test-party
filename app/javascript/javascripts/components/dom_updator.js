const participantsNode = document.querySelector('#participants');
const body = document.querySelector('body');

const renderPlayers = (data, username) => {
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

const isDealer = () => {
  return body.classList.contains('current-dealer');
}

export { renderPlayers, playerIsDealer, playerIsNotDealer, isDealer };
