import Plyr from 'plyr';
import { perform } from './room_channel';

let player;

const initVideoPlayer = () => {
  const playerNode = document.querySelector('#plyr');

  if (playerNode) {
    player = new Plyr('#plyr', {
      enabled: true
    });
    player.songId = undefined;

    player.on('ready', event => {
      console.log('player ready')
      perform('ready')
    })

    player.on('error', erro => {
      console.log('error', erro)
    })
  }
}

export { initVideoPlayer, player };
