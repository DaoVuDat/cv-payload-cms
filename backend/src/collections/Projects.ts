import type { CollectionConfig } from 'payload'

export const Projects: CollectionConfig = {
  slug: 'projects',
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
      label: 'Project Title',
      admin: {
        description: 'The name of your project',
      },
    },
    {
      name: 'description',
      type: 'richText',
      required: true,
      label: 'Project Description',
      admin: {
        description: 'Detailed description of the project, goals, and outcomes',
      },
    },
    {
      name: 'technologies',
      type: 'array',
      label: 'Technologies Used',
      required: true,
      minRows: 1,
      admin: {
        description: 'List all technologies, frameworks, and tools used in this project',
      },
      fields: [
        {
          name: 'technology',
          type: 'text',
          required: true,
          admin: {
            placeholder: 'e.g., React, Node.js, MongoDB',
          },
        },
      ],
    },
    {
      name: 'role',
      type: 'array',
      label: 'Your Role(s)',
      required: true,
      minRows: 1,
      admin: {
        description: 'Define your responsibilities and roles in this project',
      },
      fields: [
        {
          name: 'roleTitle',
          type: 'text',
          required: true,
          admin: {
            placeholder: 'e.g., Full Stack Developer, UI/UX Designer, Project Manager',
          },
        },
      ],
    },
    {
      name: 'startDate',
      type: 'date',
      label: 'Start Date',
      required: true,
      admin: {
        description: 'When did this project begin?',
        date: {
          pickerAppearance: 'dayAndTime',
          displayFormat: 'MMM dd, yyyy',
        },
      },
    },
    {
      name: 'endDate',
      type: 'date',
      label: 'End Date',
      admin: {
        description: 'When was this project completed? Leave empty if ongoing',
        date: {
          pickerAppearance: 'dayAndTime',
          displayFormat: 'MMM dd, yyyy',
        },
        condition: (data, siblingData) => {
          return siblingData.status === 'completed';
        },
      },
    },
    {
      name: 'status',
      type: 'select',
      label: 'Project Status',
      required: true,
      options: [
        {
          label: 'Active',
          value: 'active',
        },
        {
          label: 'Completed',
          value: 'completed',
        },
        {
          label: 'Paused',
          value: 'paused',
        },
        {
          label: 'Draft',
          value: 'draft',
        },
      ],
      admin: {
        description: 'Current status of the project',
      },
    },
    {
      name: 'images',
      type: 'array',
      label: 'Project Images',
      admin: {
        description: 'Screenshots, mockups, or photos related to the project',
      },
      fields: [
        {
          name: 'image',
          type: 'upload',
          relationTo: 'media',
          required: true,
          admin: {
            description: 'Upload project image',
          },
        },
        {
          name: 'caption',
          type: 'text',
          admin: {
            placeholder: 'Optional caption for this image',
          },
        },
        {
          name: 'altText',
          type: 'text',
          required: true,
          admin: {
            placeholder: 'Alt text for accessibility',
          },
        },
      ],
    },
    // Additional useful fields
    {
      name: 'projectUrl',
      type: 'text',
      label: 'Project URL',
      admin: {
        description: 'Live project URL (optional)',
        placeholder: 'https://example.com',
      },
    },
    {
      name: 'repositoryUrl',
      type: 'text',
      label: 'Repository URL',
      admin: {
        description: 'GitHub or other repository URL (optional)',
        placeholder: 'https://github.com/username/project',
      },
    },
    {
      name: 'featured',
      type: 'checkbox',
      label: 'Featured Project',
      defaultValue: false,
      admin: {
        description: 'Mark as a featured project for portfolio highlights',
      },
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
  ],
  timestamps: true,
  hooks: {
    beforeChange: [
      ({ data, operation }) => {
        if (operation === 'create') {
          data.createdAt = new Date();
        }
        data.updatedAt = new Date();
        return data;
      },
    ],
  },
}
