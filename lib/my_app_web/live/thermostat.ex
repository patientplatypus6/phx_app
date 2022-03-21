defmodule MyAppWeb.ThermostatLive do
  use MyAppWeb, :live_view

  # <div v-html='buttondec'/>
  # <div v-html='buttoninc'/>

  # <button phx-click="dec" class="minus">-</button>
  # <button phx-click="inc" class="plus">+</button>

  # <button v-on:click="increment">Count is: {{ count }}</button>
  # <button v-on:click="incrementTemp">Increment Temp</button>

  # <div v-html='temperature'/>

  # <%= @temperature %>
  # <button phx-click="dec" class="minus">-</button>

  # <input @input="(e)=>textInput(e)"/>

  # this.temperature = '<%= @temperature %>'
  # this.buttondec = '<button phx-click="dec" class="minus">-</button>'
  # this.buttoninc = '<button phx-click="inc" class="plus">+</button>'

  # increment() {
  #   this.count++
  #   sessionStorage.setItem("count", this.count)
  # },
  # incrementTemp(){
  #   console.log("inside incrementTemp")
  #   event = "test!"
  # },
  # textInput(e){
  #   console.log('inside textInput and value of e: ', e)
  # }

  # console.log("page created!")
  # window.addEventListener(`updatevar`, (e) => {
  #   console.log("value of e in updatevar eventlistener: ", e)
  # })
  # console.log("value of data: ", this.$data)
  # this.count = sessionStorage.getItem('count')

  def render(assigns) do
    ~H"""

      <script type="importmap">
        {
          "imports": {
            "vue": "https://unpkg.com/vue@3/dist/vue.esm-browser.js"
          }
        }
      </script>
      <div id="app">

        {{ message }}

      </div>

      <script type="module">

        import { createApp } from 'vue'

        createApp({
          data() {
            return {
              message: 'hello vue',
              temperature: '',
              buttondec: '',
              buttoninc: '',
              count: 0
            }
          },
          beforeCreate(){
            console.log('inside beforeCreate')
          },
          beforeMount(){
            console.log('inside beforeMount')
            console.log('this.message: ', this.message)
            console.log('after this.message display')
          },
          beforeUpdate(){
            console.log('inside beforeUpdate')
          },
          updated(){
            console.log('inside updated')
          },
          created(){
            this.message = "hello vue 2"
          },
          methods: {

          },
        }).mount('#app')
      </script>
    """
  end

  def mount(_params,  _session, socket) do
    {:ok, assign(socket, temperature: 80)}
  end

  def handle_event("inc", _, socket) do
    newtemp = cond do
      socket.assigns.temperature >= 100 -> 100
      true -> socket.assigns.temperature + 1
    end
    {:noreply, assign(socket, :temperature, newtemp)}
  end

  def handle_event("dec", _, socket) do
    newtemp = cond do
      socket.assigns.temperature <= 0 -> 0
      true -> socket.assigns.temperature - 1
    end
    {:noreply, assign(socket, :temperature, newtemp)}
  end

end
