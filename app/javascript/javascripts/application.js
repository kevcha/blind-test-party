require("@rails/ujs").start()
require("@rails/activestorage").start()

import { perform, setCallback } from "./components/room_channel";
import { createConsumer } from "@rails/actioncable"
import { renderPlayers, playerIsDealer, playerIsNotDealer, isDealer, updateRoomStatus, currentDealer, updateChat } from "./components/dom_updator";
import { initVideoPlayer, player } from "./components/video_player";

const participantsNode = document.querySelector('#participants');

if (participantsNode) {
  const userId = participantsNode.dataset.currentUser;
  const start = document.querySelector('#start');
  const submitSong = document.querySelector('#submitSong');
  const songInput = document.querySelector('#songInput');
  const togglePlay = document.querySelector('#togglePlay');
  const next = document.querySelector('#next');
  const chatForm = document.querySelector('#chatForm');
  const messageInput = document.querySelector('#messageInput');

  initVideoPlayer();

  setCallback((data) => {
    renderPlayers(data);
    updateRoomStatus(data);
    updateChat(data.messages);

    if (data.started) {
      currentDealer(data.dealer);
      (data.dealer.id == userId) ? playerIsDealer(data) : playerIsNotDealer();

      if (data.song_id && player.songId != data.song_id) {
        player.source = {
          type: 'video',
          sources: [
            {
              src: data.song_id,
              provider: 'youtube',
            }
          ]
        };
        player.songId = data.song_id;
      }

      if (data.playing) {
        player.play();
      } else {
        player.pause();
      }
    }
    renderPlayers(data, userId);
  })

  start.addEventListener('click', () => {
    perform('start');
  })

  next.addEventListener('click', () => {
    perform('next');
  })

  chatForm.addEventListener('submit', (event) => {
    event.preventDefault();
    perform('message', { body: messageInput.value });
    messageInput.value = '';
  })

  togglePlay.addEventListener('click', () => {
    if (isDealer()) {
      perform('toggle');
    }
  })

  submitSong.addEventListener('click', () => {
    const id = getIdFromYoutubeUrl(songInput.value);
    perform('setSong', { id: id });
  })

  participantsNode.addEventListener('click', (event) => {
    const player = event.target.closest('.player');

    if (player && isDealer()) {
      perform('found', { userId: player.dataset.player })
    }
  })
}

const getIdFromYoutubeUrl = (url) => {
  let videoId = url.split('v=')[1];
  const ampersandPosition = videoId.indexOf('&');
  if (ampersandPosition != -1) {
    videoId = videoId.substring(0, ampersandPosition);
  }
  return videoId;
}
