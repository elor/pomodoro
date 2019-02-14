<template>
  <v-app>
    <Pomodoro/>
  </v-app>
</template>

<script>
import Pomodoro from './components/Pomodoro'

export default {
  name: 'App',
  components: {
    Pomodoro
  },
  data () {
    return {
      //
    }
  }
}
</script>
