import {gsap} from "gsap";
import {ScrollTrigger} from "gsap/ScrollTrigger";
import {ScrollSmoother} from "gsap/ScrollSmoother";

export default defineNuxtPlugin((nuxtApp) => {
    gsap.registerPlugin(ScrollTrigger, ScrollSmoother)

    return {
        provide: {
            gsap: gsap
        }
    }
})