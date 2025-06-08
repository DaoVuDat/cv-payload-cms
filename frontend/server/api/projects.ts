export default defineEventHandler(async (event) => {
    const config = useRuntimeConfig(event);

    const data = await $fetch<PayloadResponse<Project>>(config.cmsApi + '/projects', {
        query: {
            pagination: false,
        }
    });

    console.log(data);

    return {
        data
    }

})