<script setup lang="ts">
useHead({
  title: "Portfolio - Đào Vũ Đạt",
});

useSeoMeta({
  title: "Portfolio - Đào Vũ Đạt",
  ogTitle: "Portfolio - Đào Vũ Đạt",
  description: "My portfolio website",
});
</script>

<template>
  <div class="flow" :style="{ '--flow-space': 'var(--space-xl)' }">
    <Hero />
    <Intro />
    <Timeline />
    <Contact />
  </div>
</template>

<style scoped></style>
