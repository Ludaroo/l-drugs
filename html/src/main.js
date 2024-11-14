import './assets/base.css'
import { createApp } from 'vue'
import App from './App.vue'
import router from "./router"

import { createI18n } from 'vue-i18n'
import en from '../../locales/menu/en.json';
import de from '../../locales/menu/de.json';
const locale = localStorage.getItem('locale') || 'en';



const i18n = createI18n({
    locale: locale,
    messages: {
      en: en, de: de,
    }
  });
  
  export { i18n };
// import { OhVueIcon, addIcons } from "oh-vue-icons";
// import { GiUnicorn } from "oh-vue-icons/icons";
// addIcons(GiUnicorn)
const app = createApp(App);
//app.component("v-icon", OhVueIcon);
app.use(i18n)
app.use(router)
app.mount('#app')





