<script setup lang="ts">
import type {SerializedEditorState} from "@payloadcms/richtext-lexical/lexical";
import {convertLexicalToHTML} from "@payloadcms/richtext-lexical/html";

const {data, error, status} = useFetch("/api/projects");

const {$gsap: gsap, $scrollTrigger: scrollTrigger} = useNuxtApp();

onMounted(() => {
  const years = gsap.utils.toArray(".timeline__year:not(:first-child)") as Element[];
  const contents = gsap.utils.toArray(".timeline__project-summary:not(:first-child)") as Element[];

  gsap.set(years, {yPercent: 101});

  // Pin the left content
  scrollTrigger.create({
    trigger: ".timeline__scroll-content",
    start: 'top 50%',
    end: 'bottom 80%',
    pin: '.timeline__left-content',
  })

  contents.forEach((content, idx) => {
    const heading = content.querySelectorAll(".project-card__heading")[0];

    const animation = gsap.timeline()
        .to(years[idx]!, {yPercent: 0})

    // Change the year for the first item heading of the project card
    scrollTrigger.create({
      trigger: heading,
      start: 'top 50%',
      end: 'top 50%',
      animation: animation,
      scrub: true,
    })
  })
});
</script>

<template>
  <section class="wrapper cover">
    <div class="flow">
      <div class="center text-center">
        <GlitchText text="projects." :rotate="-5">
          <h2 class="font-bold">Projects.</h2>
        </GlitchText>
      </div>

      <div class="timeline__scroll-content">
        <div v-if="error" class="text-red-500">
          <p>Error loading projects: {{ error.message }}</p>
        </div>
        <div v-if="status === 'pending'" class="text-gray-500">
          <p>Loading projects...</p>
        </div>

        <!-- Left -->
        <div class="timeline__left-content">
          <div class="timeline__years" v-if="data && data.projects && data.projects.length > 0">
            <div
                v-for="project in data.projects"
                :key="project.year"
                class="timeline__year"
            >
              <div>
                <GlitchText text="projects." :rotate="-5">
                  <h3>{{ project.year }}</h3>
                </GlitchText>
              </div>

            </div>
          </div>

        </div>

        <!-- Right -->
        <div class="timeline__right-content">
          <div class="timeline__projects-summary flow" :style="{'--flow-space': 'var(--space-l)'}"
               v-if="data && data.projects && data.projects.length > 0">
            <div
                v-for="project in data.projects"
                :key="project.year"
                class="timeline__project-summary"
            >

              <div class="timeline__projects" role="list">
                <div
                    v-for="item in project.projects"
                    role="listitem"
                    :key="item.title"
                    class="project-card flow"
                    :style="{'--flow-space': 'var(--space-m)'}"
                >
                  <h3 class="project-card__heading">{{ item.title }}</h3>
                  <div
                      class="project-card__description"
                      v-html="convertLexicalToHTML({
                  data: (item.description as unknown as SerializedEditorState)
                  })"
                  ></div>
                  <p><strong>Role:</strong> {{ item.role }}</p>
                  <p><strong>Status:</strong> {{ item.status }}</p>
                  <p>
                    <strong>Technologies:</strong>
                    {{ item.technologies.join(", ") }}
                  </p>
                  <p>
                    <strong>Duration:</strong> {{ item.startDate }} -
                    {{ item.endDate || "Ongoing" }}
                  </p>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

.timeline__scroll-content {
  display: flex;
}

.timeline__left-content {
  height: 100vh;
  width: 20%;
}

.timeline__years {
  position: relative;
  height: 100%;
  width: 100%;
  overflow: hidden;
}

.timeline__year {
  position: absolute;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;

  font-weight: bold;
  background-color: var(--color-dark);
}

.timeline__right-content {
  width: 80%;
}

.timeline__projects-summary {
  margin-inline: auto 0;
  width: 90%;
}

.timeline__project-summary {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  border: 1px solid var(--color-light);
}

.project-card {
  border: 1px solid red;
}

</style>
