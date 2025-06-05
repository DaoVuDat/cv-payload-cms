<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const { $gsap: gsap } = useNuxtApp()

const originalText = 'Dat Dao Vu.'
const targetText = 'Developer.'
const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'

const isAnimating = ref(false)
const currentState = ref<'original' | 'target'>('original')

// Declare variables for timeline and intervals
let autoTimeline: any = null

// Scramble effect function with static D
function scrambleText(element: HTMLElement, finalText: string, duration = 1000): Promise<void> {
  return new Promise((resolve) => {
    const startTime = Date.now()
    const startText = element.textContent?.replace(/\s*<span.*?<\/span>/, '').trim() || ''
    const maxLength = Math.max(startText.length, finalText.length)

    const scrambleInterval = setInterval(() => {
      const elapsed = Date.now() - startTime
      const progress = Math.min(elapsed / duration, 1)

      let scrambledText = ''

      for (let i = 0; i < maxLength; i++) {
        // Keep 'D' static at the beginning
        if (i === 0 && (finalText.startsWith('D') || startText.startsWith('D'))) {
          scrambledText += 'D'
        } else if (i < finalText.length && Math.random() < progress) {
          scrambledText += finalText[i]
        } else if (i < finalText.length) {
          scrambledText += chars[Math.floor(Math.random() * chars.length)]
        }
      }

      element.innerHTML = scrambledText

      if (progress >= 1) {
        clearInterval(scrambleInterval)
        element.innerHTML = finalText
        resolve()
      }
    }, 50)
  })
}

// Transform animation
async function transformText(toTarget = true) {
  if (isAnimating.value) return
  isAnimating.value = true

  // Add screen shake
  gsap.to('.container', {
    x: () => Math.random() * 4 - 2,
    y: () => Math.random() * 4 - 2,
    duration: 0.05,
    repeat: 10,
    yoyo: true,
    ease: "power2.inOut",
    onComplete: () => {
      gsap.set('.container', { x: 0, y: 0 })
    }
  })

  const hackerText = document.getElementById('hackerText')
  if (hackerText) {
    const newText = toTarget ? targetText : originalText
    await scrambleText(hackerText, newText, 1500)
  }

  currentState.value = toTarget ? 'target' : 'original'
  isAnimating.value = false
}

// Auto-cycle function
function startAutoCycle() {
  autoTimeline = gsap.timeline({ repeat: -1 })
  autoTimeline
      .add(() => transformText(true))
      .to({}, { duration: 2.5 })
      .add(() => transformText(false))
      .to({}, { duration: 2.5 })
}

onMounted(() => {
  // Initialize
  setTimeout(startAutoCycle, 2000)

})

onUnmounted(() => {
  if (autoTimeline) autoTimeline.kill()
})
</script>

<template>
  <div class="container hero">
    <div class="[layout] cover wrapper [utilities] uppercase">
      <div class=" [layout] cluster">
        <h1 class="[utilities] font-bold">
          <span
              class="hacker-text"
              id="hackerText"
          >
            Dat Dao Vu
          </span>
          <span class="cursor"></span>
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
    --cover-min-block-size: 50vh;
  }

  h1 {
    font-size: var(--size-step-10);
  }
}

.container {
  position: relative;

}

h1 {
  font-size: var(--size-step-9);
  line-height: var(--leading-flat);
  max-width: 10ch;
  hyphens: auto;
  color: #00ff41;
  text-shadow:
      0 0 10px #00ff41,
      0 0 20px #00ff41,
      0 0 30px #00ff41;
  letter-spacing: 0.1em;
  cursor: pointer;
  position: relative;
  display: inline-block;
  transition: all 0.3s ease;
  word-wrap: break-word;
  overflow-wrap: break-word;
}

.hacker-text:hover {
  text-shadow:
      0 0 20px #00ff41,
      0 0 40px #00ff41,
      0 0 60px #00ff41,
      0 0 80px #00ff41;
}

.cursor {
  display: inline-block;
  background: #00ff41;
  width: 3px;
  height: 0.75em;
  margin-left: 3px;
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 50% { opacity: 1; }
  51%, 100% { opacity: 0; }
}

.matrix-bg {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: -1;
}

.matrix-char {
  position: absolute;
  color: #003300;
  font-family: 'JetBrains Mono', monospace;
  font-size: 14px;
  animation: fall linear infinite;
}

@keyframes fall {
  0% { transform: translateY(-100vh); opacity: 1; }
  100% { transform: translateY(100vh); opacity: 0; }
}
</style>