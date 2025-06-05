import {gsap} from "gsap";
import {ScrollTrigger} from "gsap/ScrollTrigger";
import {ScrollSmoother} from "gsap/ScrollSmoother";
import {TextPlugin} from "gsap/TextPlugin";

export default defineNuxtPlugin((nuxtApp) => {
    gsap.registerPlugin(ScrollTrigger, ScrollSmoother, TextPlugin);

    return {
        provide: {
            gsap: gsap
        }
    }
})