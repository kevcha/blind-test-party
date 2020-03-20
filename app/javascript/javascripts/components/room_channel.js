import createChannel from "./cable";

let callback; // declaring a variable that will hold a function later
let room;

const node = document.querySelector('[data-token]');

if (node) {
  room = createChannel(
    { channel: "RoomChannel", token: node.dataset.token },
    {
      received(date) {
        if (callback) callback(date);
      }
    }
  );
}

// Sending a message: "perform" method calls a respective Ruby method
// defined in room_channel.rb. That's your bridge between JS and Ruby!
const perform = (serverFn, data) => {
  room.perform(serverFn, data);
}

// Getting a message: this callback will be invoked once we receive
// something over RoomChannel
const setCallback = (fn) => {
  callback = fn;
};

export { perform, setCallback };
