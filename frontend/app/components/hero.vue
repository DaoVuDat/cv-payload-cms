<script setup lang="ts">
import {ref, onMounted, onUnmounted} from 'vue'
import {ScrambleTextPlugin} from 'gsap/ScrambleTextPlugin';

const {$gsap: gsap} = useNuxtApp()

let target: HTMLSpanElement | null = null
const originalText = 'Test Test T'
const targetText = 'Developer.'
const defaultChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'

function scrambleText(type: 'original' | 'target') {
  if (!gsap.isTweening(target) && window.matchMedia('(prefers-reduced-motion: no-preference)').matches) {
    let text = "";
    if (type === 'target') {
      text = targetText;
    } else {
      text = originalText;
    }

    gsap.to(target, {
      duration: .8,
      ease: 'sine.in',
      scrambleText: {
        text: text,
        speed: 2,
        chars: defaultChars,
      }
    });
    return null
  }
}


onMounted(() => {
  gsap.registerPlugin(ScrambleTextPlugin)
  target = document.querySelector('.hacker-text')
})

onUnmounted(() => {
})
</script>

<template>
  <div class="hero">
    <div class="cover wrapper">
      <div class="[utilities] uppercase">
        <h1 class="container-fill-text"
            @pointerenter="scrambleText('target')"
            @pointerleave="scrambleText('original')">
          <span class="container-fill-text__container">
            <span class="hacker-text container-fill-text__display">Test Test T</span>
          </span>
          <span class="container-fill-text__reference" aria-hidden="true">Dat Dao Vu</span>
        </h1>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hero {
  container-type: inline-size;
  container-name: hero;
}

@container hero (width < 700px) {
  .hero > * {
    --cover-centered-margin: 5rem;
    --cover-min-block-size: auto;
  }

  .container-fill-text__display {
    --default-text-size: var(--size-step-10);
  }
}

@container hero (width < 400px) {
  .hero > * {
    --cover-centered-margin: 3rem;
  }

  .container-fill-text__display {
    --default-text-size: var(--size-step-5);
  }
}


h1 {
  color: #00ff41;
  text-shadow: 0 0 10px #00ff41,
  0 0 20px #00ff41,
  0 0 30px #00ff41;
  letter-spacing: 0.1em;
  cursor: pointer;
  position: relative;
}

.hacker-text {
  text-wrap: nowrap;
}

.hacker-text:hover {
  text-shadow: 0 0 20px #00ff41,
  0 0 40px #00ff41,
  0 0 60px #00ff41,
  0 0 80px #00ff41;
}
</style>
