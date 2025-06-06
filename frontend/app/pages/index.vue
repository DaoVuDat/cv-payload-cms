<script setup lang="ts">

import Timeline from "~/components/timeline.vue";
</script>

<template>
  <div class="flow" :style="{'--flow-space': 'var(--space-xl)'}">
    <Hero />
    <Intro />
    <Timeline />
  </div>
</template>

<style scoped>

</style>
