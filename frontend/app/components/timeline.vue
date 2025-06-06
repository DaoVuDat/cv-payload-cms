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

</script>

<template>
  <section class="wrapper flow">

    <div class="center text-center">
      <GlitchText text="projects." :rotate="-5">
        <h2 class="font-bold">Projects.</h2>
      </GlitchText>
    </div>

    <div></div>

  </section>
</template>

<style scoped>

.timeline__title {
  position: relative;
}

</style>
