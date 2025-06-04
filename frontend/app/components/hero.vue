<script setup lang="ts">

defineProps<{
  padding?: string;
}>();


</script>

<template>
  <div class="hero" :style="{'--padding': padding}">
    <div class="[layout] cover">
      <div class="
      [layout] cluster"
           style="--flow-space: 2rem;">
        <h1 class="font-bold">Dao Vu Dat</h1>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hero {
  container-type: inline-size;
  container-name: hero;
}

@container hero (width < var(--breakpoint-mid)) {
  .hero > * {
    --cover-centered-margin: 0;
  }


}

h1 {
  font-size: var(--size-step-10);
  max-width: 7ch;
}
</style>