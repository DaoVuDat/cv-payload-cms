type ResponseProjects = Record<number, Project[]>;

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig(event);

  const data = await $fetch<PayloadResponse<Project>>(
    config.cmsApi + "/projects",
    {
      query: {
        pagination: false,
        sort: "-startDate",
      },
    }
  );

  if (!data || !data.docs) {
    throw createError({
      statusCode: 404,
      statusMessage: "Projects not found",
    });
  }

  // Sort the results by year (in decending) and grouped by year
  const projectsGroupedByYear = data.docs
    // .sort((a, b) => {
    //   return (
    //     -1 *
    //     (new Date(b.startDate).getFullYear() -
    //       new Date(a.startDate).getFullYear())
    //   );
    // })
    .reduce((acc: ResponseProjects, project) => {
      const year = new Date(project.startDate).getFullYear();
      if (!acc[year]) {
        acc[year] = [];
      }

      acc[year].push(project);
      return acc;
    }, {});

  const sortedKeys = Object.keys(projectsGroupedByYear).sort((a, b) => {
    return parseInt(b) - parseInt(a);
  });

  const result = sortedKeys.reduce(
    (acc: Array<{ year: number; projects: Project[] }>, key: string) => {
      const intKey = parseInt(key);
      const projects = projectsGroupedByYear[intKey] ?? [];

      acc.push({
        year: intKey,
        projects,
      });

      return acc;
    },
    []
  );

  return {
    projects: result,
  };
});
