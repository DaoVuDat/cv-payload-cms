<script setup lang="ts">
import {ref, onMounted, onUnmounted} from 'vue'
import {ScrambleTextPlugin} from 'gsap/ScrambleTextPlugin';

const {$gsap: gsap} = useNuxtApp()

let target: HTMLSpanElement | null = null
let scrambleTween: GSAPTween | null = null
const targetText = 'Developer.'
const defaultChars = 'ABCDEFGH56789!@#$%^&*()_+-=[]{}|;:,.<>?'

function scrambleText(type: 'original' | 'target') {
  if (window.matchMedia('(prefers-reduced-motion: no-preference)').matches) {
    gsap.killTweensOf(target);

    if (type === 'target') {
      scrambleTween?.play();
    } else {
      scrambleTween?.reverse();
    }
  }
}

onMounted(() => {
  gsap.registerPlugin(ScrambleTextPlugin)
  target = document.querySelector('.hacker-text')

  scrambleTween = gsap.to(target, {
    duration: 0.5,
    ease: "none",
    scrambleText: {
      text: targetText,
      speed: 2,
      tweenLength: false,
      chars: defaultChars,
    },
    paused: true,
  });
})

onUnmounted(() => {
})
</script>

<template>
  <div class="hero">
    <div class="cover wrapper">
      <div class="[utilities] uppercase">
        <h1 class="hacker-text"
            @pointerenter="scrambleTween?.play()"
            @pointerleave="scrambleTween?.reverse()">
            Test TestT
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
    --default-text-size: var(--size-step-6);
  }
}

h1 {
  font-size: var(--default-text-size, var(--size-step-11));
  color: #00ff41;
  text-shadow: 0 0 10px #00ff41,
  0 0 20px #00ff41,
  0 0 30px #00ff41;
  letter-spacing: 0.1em;
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
