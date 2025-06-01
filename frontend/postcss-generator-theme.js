import fs from "fs";
import path from "path";
import slugify from "slugify";

import { fileURLToPath } from 'url';
import { dirname } from 'path';

// Your existing utilities
import clampGenerator from "./app/css-utils/clamp-generator.js";

// Import design tokens
import colorTokens from "./app/design-tokens/colors.json" with { type: 'json' };
import fontTokens from "./app/design-tokens/fonts.json" with { type: 'json' };
import spacingTokens from "./app/design-tokens/spacing.json" with { type: 'json' };
import textSizeTokens from "./app/design-tokens/text-sizes.json" with { type: 'json' };
import textWeightTokens from "./app/design-tokens/text-weights.json" with { type: 'json' };
import textLeadingTokens from "./app/design-tokens/text-leading.json" with { type: 'json' };
import viewportTokens from "./app/design-tokens/viewports.json" with { type: 'json' };

const tokensToTailwind = tokens => {
	const nameSlug = text => slugify(text, {lower: true});
	let response = {};

	tokens.forEach(({name, value}) => {
		response[nameSlug(name)] = value;
	});

	return response;
};

// Process tokens
const colors = tokensToTailwind(colorTokens.items);
const fontFamily = tokensToTailwind(fontTokens.items);
const fontWeight = tokensToTailwind(textWeightTokens.items);
const fontSize = tokensToTailwind(clampGenerator(textSizeTokens.items));
const fontLeading = tokensToTailwind(textLeadingTokens.items);
const spacing = tokensToTailwind(clampGenerator(spacingTokens.items));

// Generate CSS custom properties for @theme
function generateThemeCSS() {
	let css = '@theme {\n';

	// Colors
	Object.entries(colors).forEach(([key, value]) => {
		css += `  --color-${key}: ${value};\n`;
	});

	// Spacing
	Object.entries(spacing).forEach(([key, value]) => {
		css += `  --spacing-${key}: ${value};\n`;
	});

	// Font sizes
	Object.entries(fontSize).forEach(([key, value]) => {
		css += `  --font-size-${key}: ${value};\n`;
	});

	// Font leading
	Object.entries(fontLeading).forEach(([key, value]) => {
		css += `  --line-height-${key}: ${value};\n`;
	});

	// Font families
	Object.entries(fontFamily).forEach(([key, value]) => {
		css += `  --font-family-${key}: ${value};\n`;
	});

	// Font weights
	Object.entries(fontWeight).forEach(([key, value]) => {
		css += `  --font-weight-${key}: ${value};\n`;
	});

	// Breakpoints
	css += `  --breakpoint-sm: ${viewportTokens.min}px;\n`;
	css += `  --breakpoint-md: ${viewportTokens.mid}px;\n`;
	css += `  --breakpoint-lg: ${viewportTokens.large}px;\n`;
	css += `  --breakpoint-xl: ${viewportTokens.max}px;\n`;

	css += '}\n\n';
	return css;
}

// Generate custom utilities
function generateUtilitiesCSS() {
	let css = '';

	// Custom utilities equivalent to your plugins
	const customUtilities = [
		{key: spacing, prefix: 'flow-space', property: '--flow-space'},
		{key: spacing, prefix: 'region-space', property: '--region-space'},
		{key: spacing, prefix: 'gutter', property: '--gutter'},
		{key: colors, prefix: 'indent-color', property: '--indent-color'}
	];

	customUtilities.forEach(({key, prefix, property}) => {
		Object.entries(key).forEach(([name, value]) => {
			css += `@utility ${prefix}-${name} {\n`;
			css += `  ${property}: ${value};\n`;
			css += '}\n\n';
		});
	});

	return css;
}

// Generate CSS custom properties for :root (equivalent to your first plugin)
function generateRootPropertiesCSS() {
	let css = ':root {\n';

	const groups = [
		{key: colors, prefix: 'color'},
		{key: spacing, prefix: 'space'},
		{key: fontSize, prefix: 'size'},
		{key: fontLeading, prefix: 'leading'},
		{key: fontFamily, prefix: 'font'},
		{key: fontWeight, prefix: 'font'}
	];

	groups.forEach(({key, prefix}) => {
		Object.entries(key).forEach(([name, value]) => {
			css += `  --${prefix}-${name}: ${value};\n`;
		});
	});

	css += '}\n\n';
	return css;
}

// Combine all CSS
const fullCSS = `@import "tailwindcss";

${generateThemeCSS()}
${generateRootPropertiesCSS()}
${generateUtilitiesCSS()}`;

// Reconstruct __filename and __dirname for ES Modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

try {
	// Ensure assets/css directory exists (for Nuxt structure)
	const assetsDir = path.join(__dirname, 'app', 'assets', 'css');
	if (!fs.existsSync(assetsDir)) {
		console.log(`ℹ️ Creating directory: ${assetsDir}`);
		fs.mkdirSync(assetsDir, { recursive: true });
		console.log(`✅ Directory created: ${assetsDir}`);
	}

	// Write to file
	const outputPath = path.join(assetsDir, 'tailwindcss.css');
	fs.writeFileSync(outputPath, fullCSS);

	console.log('✅ Tailwind v4 configuration generated successfully!');
	console.log(`📄 Generated at: ${outputPath}`); // Log the absolute path
} catch (error) {
	console.error('❌ An error occurred during file generation:');
	console.error(error);
	console.error('Please check file permissions or the target directory path.');
}

