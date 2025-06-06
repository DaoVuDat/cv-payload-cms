<script setup lang="ts">

// create some project data
const projects = [
  {
    title: 'Project One',
    description: 'This is the first project.',

  },
  {
    title: 'Project Two',
    description: 'This is the second project.',

  },
  {
    title: 'Project Three',
    description: 'This is the third project.',

  }
];

</script>

<template>
  <div class="wrapper flow">

   <div class="center text-center">
       <GlitchText text="projects.">
         <h2 class="font-bold">Projects.</h2>
       </GlitchText>
   </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <div v-for="(project, index) in projects" :key="index" class="p-4 border rounded-lg shadow hover:shadow-lg transition-shadow">
        <h3 class="text-xl font-bold">{{ project.title }}</h3>
        <p class="mt-2">{{ project.description }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>

.timeline__title {
  position: relative;
}

</style>
