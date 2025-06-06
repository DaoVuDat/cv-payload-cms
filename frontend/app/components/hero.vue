<script setup lang="ts">
import {ref, onMounted, onUnmounted} from 'vue'
import {ScrambleTextPlugin} from 'gsap/ScrambleTextPlugin';

const {$gsap: gsap} = useNuxtApp()

let target: HTMLSpanElement | null = null
let scrambleTween: GSAPTween | null = null
const targetText = 'developer.'
const defaultChars = 'abcdefghijkmn56789!@#$%^&*?'


onMounted(() => {
  gsap.registerPlugin(ScrambleTextPlugin)
  target = document.querySelector('.hacker-text')

  scrambleTween = gsap.to(target, {
    duration: 0.8,
    ease: "none",
    scrambleText: {
      text: targetText,
      speed: 2.5,
      tweenLength: false,
      chars: defaultChars,
    },
    yoyo: true,
    repeat: -1,
    repeatDelay: 3,
  });
})

onUnmounted(() => {
})
</script>

<template>
  <div class="hero">
    <div class="cover wrapper">
      <div class="[utilities] lowercase text-center cursor-pointer">
        <h1 class="hacker-text font-ocr font-medium">
            dat dao vu
        </h1>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hero {
  container-type: inline-size;
  container-name: hero;
  overflow: hidden;
}

@container hero (width < 700px) {
  .hero > * {
    --cover-centered-margin: 5rem;
    --cover-min-block-size: auto;
  }

  h1 {
    --default-text-size: var(--size-step-10);
  }
}

@container hero (width < 400px) {
  .hero > * {
    --cover-centered-margin: 3rem;
  }

  h1 {
    --default-text-size: var(--size-step-8);
  }
}

h1 {
  font-size: var(--default-text-size, var(--size-step-11));
  color: #00ff41;
  text-shadow: 0 0 10px #00ff41,
  0 0 20px #00ff41,
  0 0 30px #00ff41;
  letter-spacing: 0.01em;
  cursor: pointer;
  position: relative;
  text-wrap: nowrap;
}

h1:hover {
  text-shadow: 0 0 20px #00ff41,
  0 0 40px #00ff41,
  0 0 60px #00ff41,
  0 0 80px #00ff41;
}
</style>
