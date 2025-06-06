<script setup lang="ts">
import {type DefineComponent} from 'vue';
import Golang from "~/assets/icons/golang.svg";
import Csharp from "~/assets/icons/csharp.svg";
import Python from "~/assets/icons/python.svg";
import Matlab from "~/assets/icons/matlab.svg";
import Docker from "~/assets/icons/docker.svg";
import Nuxt from "~/assets/icons/nuxt.svg";
import Js from "~/assets/icons/js.svg";
import Ts from "~/assets/icons/ts.svg";
import Svelte from "~/assets/icons/svelte.svg";
import React from "~/assets/icons/react.svg";

interface ITech {
  name: string;
  logo:  DefineComponent | ComponentPublicInstance;
}

const tech: ITech[] = [

  {
    name: 'csharp',
    logo: Csharp
  },
  {
    name: 'python',
    logo: Python
  },
  {
    name: 'golang',
    logo: Golang
  },
  {
    name: 'js',
    logo: Js
  },
  {
    name: 'ts',
    logo: Ts
  },
  {
    name: 'nuxt',
    logo: Nuxt
  },
  {
    name: 'matlab',
    logo: Matlab
  },
  {
    name: 'docker',
    logo: Docker
  },
  {
    name: 'svelte',
    logo: Svelte
  },
  {
    name: 'react',
    logo: React
  },
]

</script>

<template>
  <section class="[layout] cover wrapper">
    <div class="[block] intro [layout] sidebar">
      <div class="intro__content center">
        <p class="">
          With experience as a freelance optimization expert, specifically in construction, I have mastered applying
          metaheuristics to real-world challenges. This has honed my skills in analytical thinking, system design, and
          performance optimization. I am excited to bring this unique perspective and my development capabilities to a
          backend or frontend role.
        </p>
      </div>
      <div>
        <div class="intro__tech flow center text-center">
          <GlitchText text="projects." :rotate="-5">
            <h2 class="font-bold">Technologies.</h2>
          </GlitchText>
          <div class="
        tech-list
        [layout] grid">
            <AppIcon v-for="(icon, idx) in tech" :key="idx"
                     :label="icon.name" :icon="icon.logo">

            </AppIcon>
          </div>
        </div>
      </div>
    </div>

  </section>
</template>

<style scoped>

.intro {
  --sidebar-target-width: 50%;
  --gutter: var(--space-l-xl);
}

.intro__tech {
  --flow-space: var(--space-l);
  container-name: intro__tech;
  container-type: inline-size;
}


.intro__content {
  font-size: var(--size-step-2);
  line-height: var(--leading-loose);
  max-width: 30ch;
}

.tech-list {
  place-items: center;
  font-size: var(--size-step-9);
  --grid-min-item-size: var(--space-2xl);
}

@media (width < 1350px) {
  .tech-list {
    --grid-min-item-size: var(--space-4xl);
  }
}

@media (width < 760px) {
  .tech-list {
    font-size: var(--size-step-10);
    --grid-min-item-size: var(--space-3xl);
  }
}

@media (width < 500px) {
  .tech-list {
    font-size: var(--size-step-11);
    --grid-min-item-size: var(--space-xl);
  }
}


</style>
