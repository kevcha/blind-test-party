import createChannel from "./cable";

let callback; // declaring a variable that will hold a function later

const room = createChannel("RoomChannel", {
  received({ message }) {
    console.log('message from server', message);
    if (callback) callback.call(null, message);
  }
});

// Sending a message: "perform" method calls a respective Ruby method
// defined in room_channel.rb. That's your bridge between JS and Ruby!
const test = (message) => {
  console.log("send to server", message)
  console.log('perform fn', room.perform)
  room.perform("test", { message });
}

// Getting a message: this callback will be invoked once we receive
// something over RoomChannel
const setCallback = (fn) => {
  callback = fn;
};

export { test, setCallback };
