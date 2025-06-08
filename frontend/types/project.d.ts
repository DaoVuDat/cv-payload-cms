
declare global {
    /**
     * Manage your project portfolio
     *
     * This interface was referenced by `Config`'s JSON-Schema
     * via the `definition` "projects".
     */
    interface Project {
        id: number;
        /**
         * The name of your project
         */
        title: string;
        /**
         * Detailed description of the project, goals, and outcomes
         */
        description: {
            root: {
                type: string;
                children: {
                    type: string;
                    version: number;
                    [k: string]: unknown;
                }[];
                direction: ('ltr' | 'rtl') | null;
                format: 'left' | 'start' | 'center' | 'right' | 'end' | 'justify' | '';
                indent: number;
                version: number;
            };
            [k: string]: unknown;
        };
        /**
         * List all technologies, frameworks, and tools used in this project
         */
        technologies: {
            technology: string;
            id?: string | null;
        }[];
        /**
         * Define your responsibilities and roles in this project
         */
        role: {
            roleTitle: string;
            id?: string | null;
        }[];
        /**
         * When did this project begin?
         */
        startDate: string;
        /**
         * When was this project completed? Leave empty if ongoing
         */
        endDate?: string | null;
        /**
         * Current status of the project
         */
        status: 'active' | 'completed' | 'paused' | 'draft';
        /**
         * Screenshots, mockups, or photos related to the project
         */
        images?:
            | {
            /**
             * Upload project image
             */
            image: number | Media;
            caption?: string | null;
            altText: string;
            id?: string | null;
        }[]
            | null;
        /**
         * Live project URL (optional)
         */
        projectUrl?: string | null;
        /**
         * GitHub or other repository URL (optional)
         */
        repositoryUrl?: string | null;
        /**
         * Mark as a featured project for portfolio highlights
         */
        featured?: boolean | null;
        /**
         * Auto-generated from title, or customize
         */
        slug?: string | null;
        updatedAt: string;
        createdAt: string;
    }
}

export {}


