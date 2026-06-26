import { CollectionConfig } from 'payload'
import { triggerWebhook } from '@/lib/revalidateWebhook'

export const Blogs: CollectionConfig = {
  slug: 'blogs',
  admin: {
    useAsTitle: 'title',
    description: 'Manage your project portfolio',
    group: 'Content',
  },
  access: {
    read: () => true,
    create: ({ req: { user } }) => !!user,
    update: ({ req: { user } }) => !!user,
    delete: ({ req: { user } }) => !!user,
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
            if (value) return value
            if (data?.title) {
              return data.title
                .toLowerCase()
                .replace(/[^a-z0-9]+/g, '-')
                .replace(/(^-|-$)/g, '')
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

    {
      name: 'category',
      type: 'select',
      required: true,
      options: [
        { label: 'Web Development', value: 'web-development' },
        { label: 'React', value: 'react' },
        { label: 'Next.js', value: 'nextjs' },
        { label: 'Backend', value: 'backend' },
        { label: 'DevOps', value: 'devops' },
      ],
    },

    // MULTIPLE CATEGORIES
    {
      name: 'tags',
      type: 'array',
      fields: [
        {
          name: 'tag',
          type: 'text',
          required: true,
        },
      ],
    },

    {
      name: 'author',
      type: 'text',
      defaultValue: 'Admin',
    },

    {
      name: 'readingTime',
      type: 'number',
      admin: {
        description: 'Reading time in minutes',
      },
    },

    {
      name: 'publishedAt',
      type: 'date',
      required: true,
      admin: {
        date: {
          pickerAppearance: 'dayAndTime',
        },
      },
    },
  ],
  timestamps: true, // Adds createdAt and updatedAt automatically
  hooks: {
    beforeChange: [
      ({ data, operation }) => {
        if (operation === 'create') {
          data.createdAt = new Date()
        }
        data.updatedAt = new Date()
        return data
      },
    ],
    afterChange: [
      async () => {
        await triggerWebhook()
      },
    ],
    afterDelete: [
      async () => {
        await triggerWebhook()
      },
    ],
  },
}
