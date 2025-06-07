<script setup lang="ts">
interface Project {
  title: string;
  description: string;
  technologies: string[];
  role: string;
  status: string;
  startDate: string;
  endDate: string;
}

interface YearProject {
  year: number;
  projects: Project[];
}

// create some project data
const yearsProjects: YearProject[] = [
  {
    year: 2025,
    projects: [
      {
        title: "Project Y",
        description: "Description of Project Y",
        technologies: ["Next.js", "GraphQL", "Apollo"],
        role: "Full Stack Developer",
        status: "Planned",
        startDate: "2025-01-01",
        endDate: "",
      },
      {
        title: "Project C",
        description: "Description of Project C",
        technologies: ["Next.js", "GraphQL", "Apollo"],
        role: "Full Stack Developer",
        status: "Planned",
        startDate: "2025-01-01",
        endDate: "",
      },
      {
        title: "Project Z",
        description: "Description of Project Z",
        technologies: ["Next.js", "GraphQL", "Apollo"],
        role: "Full Stack Developer",
        status: "Planned",
        startDate: "2025-01-01",
        endDate: "",
      }
    ]
  },
  {
    year: 2024,
    projects: [
      {
        title: "Project X",
        description: "Description of Project X",
        technologies: ["React", "TypeScript", "Node.js"],
        role: "Full Stack Developer",
        status: "In Progress",
        startDate: "2024-01-01",
        endDate: "",
      }
    ]
  },
  {
    year: 2023,
    projects: [
      {
        title: "Project A",
        description: "Description of Project A",
        technologies: ["Vue", "TypeScript", "Node.js"],
        role: "Frontend Developer",
        status: "Completed",
        startDate: "2023-01-01",
        endDate: "2023-06-30",
      },
      {
        title: "Project B",
        description: "Description of Project B",
        technologies: ["React", "JavaScript", "Express"],
        role: "Full Stack Developer",
        status: "In Progress",
        startDate: "2023-07-01",
        endDate: "",
      }
    ]
  },
  {
    year: 2022,
    projects: [
      {
        title: "Project C",
        description: "Description of Project C",
        technologies: ["Angular", "Python", "Django"],
        role: "Backend Developer",
        status: "Completed",
        startDate: "2022-01-01",
        endDate: "2022-12-31",
      }
    ]
  }
];

const {$gsap: gsap} = useNuxtApp()

onMounted(() => {
  const timeLineProjectSummaries = document.querySelectorAll(".timeline__project-summary");

  timeLineProjectSummaries.forEach((year, yearIdx) => {
    const direction = yearIdx % 2 === 0 ? -1 : 1;

    const projectCards = year.querySelectorAll(".project-card")
    console.log(projectCards)
    projectCards.forEach((card) => {
      gsap.set(card, {xPercent: 100 * direction})
    })

    const timeline = gsap.timeline({
      scrollTrigger: {
        trigger: year,
        pin: true,
        start: "top top",
        end: () => `+=${projectCards.length * 100}%`,
        scrub: 1,
        invalidateOnRefresh: true,
      },
      defaults: {ease: "none"},
    });

    projectCards.forEach((item, projectCardIdx) => {
      timeline.to(item, {
        scale: 0.9,
        borderRadius: "var(--border-radius)",
      });

      // use old projectCard to move
      timeline.to(
          projectCards[projectCardIdx]!,
          {
            xPercent: 0,
          },
          "<"
      )
    });
  });

})

</script>

<template>
  <section class="cover">
    <div class="flow">
      <div class="center text-center">
        <GlitchText text="projects." :rotate="-5">
          <h2 class="font-bold">Projects.</h2>
        </GlitchText>
      </div>

      <div v-for="yearProject in yearsProjects" :key="yearProject.year" class="timeline__project-summary">
        <h3 class="font-bold center">{{ yearProject.year }}</h3>
        <div class="timeline__projects-wrapper">
          <div class="timeline__projects" role="list">
            <div v-for="project in yearProject.projects"
                 role="listitem"
                 :key="project.title"
                 class="project-card flow">
              <h4 class="text-xl font-semibold">{{ project.title }}</h4>
              <p>{{ project.description }}</p>
              <p><strong>Role:</strong> {{ project.role }}</p>
              <p><strong>Status:</strong> {{ project.status }}</p>
              <p><strong>Technologies:</strong> {{ project.technologies.join(', ') }}</p>
              <p><strong>Duration:</strong> {{ project.startDate }} - {{ project.endDate || 'Ongoing' }}</p>
            </div>
          </div>
        </div>

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
