<script setup lang="ts">
import {type DefineComponent} from 'vue'
defineProps<{
  label: string;
  icon:  DefineComponent | ComponentPublicInstance;
}>()
</script>

<template>
  <span class="app-icon icon" :title="label">
    <component :is="icon" filled/>
  </span>
</template>

<style scoped>

.app-icon {
  transition: all 0.3s ease;
  border: transparent 1px solid;
  border-radius: var(--radius-m);
  padding: var(--space-xs);
  cursor: pointer;
}

.app-icon svg {
  width: 100%;
  height: 100%;
}

.app-icon:hover {
  border: var(--color-primary) 1px solid;

}

</style>
