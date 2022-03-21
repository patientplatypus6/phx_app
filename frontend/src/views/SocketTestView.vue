<template>
  <div class="socket">
    <h1>This is the socket test view page</h1>
    <div>
        {{socket_message}}
    </div>
    <ul>
      <li v-for="(message, key) in messages" :key="key">{{message}}</li>
    </ul>
    <input v-model="chatMessage" />
    <button @click="sendMessage()">Submit</button>
  </div>
</template>

<script>
    import app from '../App.vue'
    import {Socket} from 'phoenix'
    export default{
        components:{
            app
        }, 
        data(){
            return{
                socket_message: "hello socket", 
                chatMessage: "",
                channel: null,
                messages: []
            }
        },
        created(){
            console.log("inside created")
            let socket = new Socket("/socket", {params: {userToken: Date.now()}})
            socket.connect()

            this.channel = socket.channel("room:lobby", {})
            console.log('value of this.channel: ', this.channel)
            this.channel.join()
                .receive("ok", resp => { console.log("Joined successfully in Vue", resp) })
                .receive("error", resp => { console.log("Unable to join", resp) })
            // this.channel.on('shout', payload => this.messages.push(payload.message))
            this.channel.on('shout', payload => this.shoutReturn(payload))
        }, 
        methods: {
            shoutReturn(payload){
                console.log('inside shoutReturn')
                console.log('value of payload message: ', payload.message)
                this.messages.push(payload.message)
            },
            sendMessage() {
                console.log("value of this.chatMessage: ", this.chatMessage)
                if (this.chatMessage!="") {
                    console.log("inside if statement")
                    this.channel.push('shout', { message: this.chatMessage })
                }
            }
        }
    }
</script>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
