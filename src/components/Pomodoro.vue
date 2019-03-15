<template>
  <v-container fill-height>
    <v-layout text-xs-center>
      <h1 :style="{color}" @click="toggle" v-show="!hidden">{{time}}</h1>
    </v-layout>
  </v-container>
</template>

<script>
import range from 'lodash.range'

const PAUSE_SECONDS = 5 * 60
const WORK_SECONDS = 25 * 60
const BLINK_SECONDS = 3

function zeropad (num) {
  if (num < 10) {
    return `0${num}`
  }
  return `${num}`
}

export default {
  data: () => ({
    seconds: WORK_SECONDS,
    isPause: false,
    timerStart: undefined,
    intervalHandle: undefined,
    hidden: false
  }),
  computed: {
    color () {
      return this.isPause ? '#aaaaaa' : '#ffffff'
    },
    time () {
      const minutes = Math.floor(this.seconds / 60)
      const seconds = Math.floor(this.seconds % 60)
      return `${zeropad(minutes)}:${zeropad(seconds)}`
    }
  },
  methods: {
    toggle () {
      if (this.intervalHandle) {
        this.stop()
      } else {
        this.start()
      }
    },
    start () {
      const timerStart = new Date()
      const secondsAtStart = this.seconds
      this.intervalHandle = window.setInterval(() => {
        const diffSeconds = (new Date() - timerStart) / 1000
        const newSeconds = Math.ceil(secondsAtStart - diffSeconds)

        if (this.seconds !== newSeconds) {
          this.seconds = newSeconds
        }

        if (this.seconds <= 0) {
          this.seconds = 0
          this.switchPause()
        }
      }, 50)
    },
    stop () {
      if (this.intervalHandle) {
        window.clearInterval(this.intervalHandle)
        this.intervalHandle = undefined
      }
    },
    reset () {
      this.stop()
      this.isPause = false
      this.seconds = WORK_SECONDS
    },
    blink () {
      range(0, BLINK_SECONDS * 1000, 500).forEach(i => {
        window.setTimeout(() => { this.hidden = !this.hidden }, i)
      })
    },
    switchPause () {
      this.stop()
      this.blink()
      window.setTimeout(() => {
        this.isPause = !this.isPause
        this.seconds = this.isPause ? PAUSE_SECONDS : WORK_SECONDS
        this.start()
      }, BLINK_SECONDS * 1000)
    },
    update () {

    }
  },
  mounted () {
    this.start()
  }
}
</script>

<style>
@import url(https://fonts.googleapis.com/css?family=Contrail+One);

h1 {
  margin: auto;
  font-size: 600%;
  font-weight: 400;
  font-family: Contrail One;
  text-shadow: black 4px 8px 8px;
  cursor: pointer;
  line-height: 0;
}

.container {
  background-color: #282828;
  padding: 0;
}
</style>
