import App from './App'

// #ifndef VUE3
import Vue from 'vue'
Vue.config.productionTip = false

Vue.prototype.$baseUrl = "http://localhost:80/"
App.mpType = 'app'
const app = new Vue({
    ...App
})
app.$mount()
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue'
export function createApp() {
  const app = createSSRApp(App)
  return {
    app
  }
}
// #endif