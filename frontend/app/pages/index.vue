<script setup lang="ts">

import Timeline from "~/components/timeline.vue";
</script>

<template>
  <div class="flow" :style="{'--flow-space': 'var(--space-xl)'}">
    <Hero />
    <Intro />
    <Timeline />
    <div class="flex flex-col justify-center items-center min-h-screen">Contact</div>
  </div>
</template>

<style scoped>

</style>
