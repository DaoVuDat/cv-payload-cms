const components = [
	"Stack",
	"Box",
	"Center",
	"Cluster",
	"Sidebar",
	"Switcher",
	"Cover",
	"Grid",
	"Frame",
	"Reel",
	"Imposter",
	"Icon",
	"Container"
];

export default defineNuxtPlugin(() => {
	components.forEach((name) => {
		import(`~/components/compositions/${name}.js`)
			.then(() => {
				console.log(`${name} web component loaded`);
			})
			.catch((err) => {
				console.error(`Failed to load ${name} web component:`, err);
			});
	});
});
