<script setup lang="ts">
const { data, error, status } = useFetch("/api/projects");

console.log("data", data.value?.projects);

const { $gsap: gsap } = useNuxtApp();

onMounted(() => {
  const timeLineProjectSummaries = document.querySelectorAll(
    ".timeline__project-summary"
  );

  timeLineProjectSummaries.forEach((year, yearIdx) => {
    const direction = yearIdx % 2 === 0 ? -1 : 1;

    const projectCards = year.querySelectorAll(".project-card");

    projectCards.forEach((card) => {
      gsap.set(card, { xPercent: 100 * direction });
    });

    const timeline = gsap.timeline({
      scrollTrigger: {
        trigger: year,
        pin: true,
        start: "top top",
        end: () => `+=${projectCards.length * 100}%`,
        scrub: 1,
        invalidateOnRefresh: true,
      
      },
      defaults: { ease: "none" },
    });

    projectCards.forEach((item, projectCardIdx) => {
      timeline.to(item, {
        scale: 0.8,
        borderRadius: "var(--border-radius)",
        delay: projectCardIdx === 0 ? 0 : 0.5,
      });

      // use old projectCard to move
      timeline.to(
        projectCards[projectCardIdx]!,
        {
          xPercent: 0,
        },
        "<"
      );

      timeline.to(item, {duration: 2})
    });
  });
});
</script>

<template>
  <section class="cover">
    <div class="flow">
      <div class="center text-center">
        <GlitchText text="projects." :rotate="-5">
          <h2 class="font-bold">Projects.</h2>
        </GlitchText>
      </div>

      <div class="flow" style="--flow-space: var(--space-l)">
        <div v-if="error" class="text-red-500">
          <p>Error loading projects: {{ error.message }}</p>
        </div>
        <div v-if="status === 'pending'" class="text-gray-500">
          <p>Loading projects...</p>
        </div>
        <template v-if="data && data.projects && data.projects.length > 0">
          <div
            v-for="project in data.projects"
            :key="project.year"
            class="timeline__project-summary"
          >
            <h3 class="font-bold center">{{ project.year }}</h3>
            <div class="timeline__projects-wrapper">
              <div class="timeline__projects" role="list">
                <div
                  v-for="item in project.projects"
                  role="listitem"
                  :key="item.title"
                  class="project-card flow"
                >
                  <h4 class="text-xl font-semibold">{{ item.title }}</h4>
                  <p>{{ item.description }}</p>
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
        </template>
        <!--        <div v-for="yearProject in yearsProjects" :key="yearProject.year" class="timeline__project-summary">-->
        <!--          <h3 class="font-bold center">{{ yearProject.year }}</h3>-->
        <!--          <div class="timeline__projects-wrapper">-->
        <!--            <div class="timeline__projects" role="list">-->
        <!--              <div v-for="project in yearProject.projects"-->
        <!--                   role="listitem"-->
        <!--                   :key="project.title"-->
        <!--                   class="project-card flow">-->
        <!--                <h4 class="text-xl font-semibold">{{ project.title }}</h4>-->
        <!--                <p>{{ project.description }}</p>-->
        <!--                <p><strong>Role:</strong> {{ project.role }}</p>-->
        <!--                <p><strong>Status:</strong> {{ project.status }}</p>-->
        <!--                <p><strong>Technologies:</strong> {{ project.technologies.join(', ') }}</p>-->
        <!--                <p><strong>Duration:</strong> {{ project.startDate }} - {{ project.endDate || 'Ongoing' }}</p>-->
        <!--              </div>-->
        <!--            </div>-->
        <!--          </div>-->
        <!--      </div>-->
      </div>
    </div>
  </section>
</template>

<style scoped>
.timeline__project-summary {
  min-height: 100vh;
  position: relative;
  overflow: hidden;
  display: flex;
  place-items: center;
}

.timeline__projects-wrapper {
  z-index: 2;
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  inset: 0;
}

.timeline__projects {
  position: relative;
  height: 100%;
  width: 100%;
}

.project-card {
  z-index: 3;
  position: absolute;
  inset: 0;
  height: 100%;
  width: 100%;
  background-color: var(--color-primary);
  color: var(--color-dark-glare);
}
</style>
