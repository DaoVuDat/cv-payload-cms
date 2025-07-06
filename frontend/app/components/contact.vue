<script setup lang="ts">

</script>

<template>
  <section class="flex flex-col justify-center items-center min-h-screen">
    <div class="flow" :style="{'--flow-space': 'var(--space-m)'}">
      <h2 class="uppercase font-bold">Get In Touch</h2>
      <p>I'm always interested in new opportunities and collaborations. Feel free to reach out if you'd like to discuss
        a project or just say hello.</p>
      <div>
        <ul class="flow" :style="{'--flow-space': 'var(--space-xs)'}" role="list">
          <li class="flex items-center space-x-3">
            <Icon name="material-symbols:mail-outline-rounded"/> <span>dat.daovu@gmail.com</span>
          </li>
          <li class="flex items-center space-x-3">
            <Icon name="material-symbols:phone-enabled-outline"/> <span>093.143.5335</span>
          </li>
          <li class="flex items-center space-x-3">
            <Icon name="grommet-icons:github" />
            <!-- Open new tab -->
            <a href="https://github.com/DaoVuDat" target="_blank">github.com/DaoVuDat</a>
          </li>
        </ul>
      </div>

    </div>
  </section>
</template>

<style scoped>
p {
  max-width: 40ch;
}

@media (width < 550px) {
  p {
    max-width: 100%;
  }

  section {
    padding-inline: var(--space-l);
  }
}
</style>
