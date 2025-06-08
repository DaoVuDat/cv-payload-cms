import {gsap} from "gsap";
import {ScrollTrigger} from "gsap/ScrollTrigger";
import {ScrollSmoother} from "gsap/ScrollSmoother";
import {TextPlugin} from "gsap/TextPlugin";
import {GSDevTools} from "gsap/GSDevTools";

export default defineNuxtPlugin((nuxtApp) => {
    gsap.registerPlugin(ScrollTrigger, ScrollSmoother, TextPlugin, GSDevTools);

    ScrollTrigger.normalizeScroll(true);

    let smoother = ScrollSmoother.create({
        smooth: 2,
        effects: true,
    })

    return {
        provide: {
            gsap: gsap,
            smoother
        }
    }
})