<script setup lang="ts">
const {$gsap: gsap} = useNuxtApp();

defineProps<{
  text: string;
}>()

onMounted(() => {
  const tl = gsap.timeline({repeat: -1, repeatDelay: 2});

  tl.to('.glitch', {duration: 0.1, skewX: 70, ease: "power4.inOut"})
      .to('.glitch', {duration: 0.04, skewX: 0, ease: "power4.inOut"})
      .to('.glitch', {duration: 0.04, opacity: 0})
      .to('.glitch', {duration: 0.04, opacity: 1})
      .to('.glitch', {duration: 0.04, x: -20})
      .to('.glitch', {duration: 0.04, x: 0})
      .addLabel("split", 0)
      .to('.top', {duration: 0.05, x: -15, ease: "power4.inOut"}, 'split')
      .to('.bottom', {duration: 0.05, x: 15, ease: "power4.inOut"}, 'split')
      .to('.glitch', {duration: 0.08, textShadow: "-3px 0 red"}, 'split')

      .to('#txt', {duration: 0, scale: 1.1}, 'split')
      .to('#txt', {duration: 0, scale: 1}, "+=0.02")

      .to('.glitch', {duration: 0.08, textShadow: "none"}, "+=0.09")
      .to('.glitch', {duration: 0.03, textShadow: '-3px 0 green'}, 'split')
      .to('.glitch', {duration: 0.03, textShadow: "none"}, "+=0.01")

      .to('.top', {duration: 0.02, x: 0, ease: "power4.inOut"}, "split+=0.05")
      .to('.bottom', {duration: 0.02, x: 0, ease: "power4.inOut"}, "split+=0.05")

      .to('.glitch', {duration: 0.02, scaleY: 1.1, ease: "power4.inOut"})
      .to('.glitch', {duration: 0.04, scaleY: 1, ease: "power4.inOut"})

})

</script>

<template>
  <div id="txt">
    <!-- Invisible content to maintain space -->
    <div class="content-spacer" aria-hidden="true">
      <slot />
    </div>
    <!-- Screen reader content -->
    <h2 class="visually-hidden">{{ text }}</h2>
    <div class="glitch top" aria-hidden="true"><slot/> </div>
    <div class="glitch bottom" aria-hidden="true"><slot /></div>
  </div>
</template>

<style scoped>

.bottom {
  clip-path: inset(58% 0 0 0);
}

.top {
  clip-path: inset(0 0 41%);
}

.glitch {
  position: absolute;
  top: 0;
}

.content-spacer {
  visibility: hidden; /* Hidden but takes up space */
  z-index: 1;
}

#txt {
  margin: auto;
  position: relative;
  display: inline-block;
  z-index: 2;
}
</style>