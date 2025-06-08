declare global {
    /**
     * Manage your project portfolio
     *
     * This interface was referenced by `Config`'s JSON-Schema
     * via the `definition` "blogs".
     */
    interface Blog {
        id: number;
        title: string;
        /**
         * Auto-generated from title, or customize
         */
        slug?: string | null;
        shortDescription: string;
        content: {
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
        thumbnail: number | Media;
        updatedAt: string;
        createdAt: string;
    }
}

export {};