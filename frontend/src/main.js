import { createApp } from 'vue'
import App from './App.vue'
import Socket from './views/SocketTestView.vue'
import router from './router'

const app = createApp(App)
app.use(router)
app.mount('#app')