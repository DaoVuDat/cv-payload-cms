import { CollectionConfig } from 'payload'

export const Blogs: CollectionConfig = {
  slug: 'blogs',
  admin: {
    useAsTitle: 'title',
    description: 'Manage your project portfolio',
    group: 'Content',
  },
  fields: [
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'slug',
      type: 'text',
      label: 'URL Slug',
      admin: {
        position: 'sidebar',
        description: 'Auto-generated from title, or customize',
      },
      hooks: {
        beforeValidate: [
          ({ value, originalDoc, data }) => {
            if (value) return value;
            if (data?.title) {
              return data.title
                .toLowerCase()
                .replace(/[^a-z0-9]+/g, '-')
                .replace(/(^-|-$)/g, '');
            }
          },
        ],
      },
    },
    {
      name: 'shortDescription',
      type: 'textarea',
      required: true,
      maxLength: 300,
    },
    {
      name: 'content',
      type: 'richText',
      required: true,
    },
    {
      name: 'thumbnail',
      type: 'upload',
      relationTo: 'media', // Make sure you have a media collection configured
      required: true,
    },
  ],
  timestamps: true, // Adds createdAt and updatedAt automatically
}
