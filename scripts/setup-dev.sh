#!/bin/bash
# scripts/setup-dev.sh
# Setup dev environment for React Native

echo "🚀 Starting React Native dev setup..."

# 1. Install dev dependencies
echo "📦 Installing ESLint, Prettier, Jest, Husky, lint-staged..."
npm install --save-dev eslint prettier jest @types/jest ts-jest husky lint-staged

# 2. Initialize ESLint
echo "📝 Initializing ESLint..."
npx eslint --init

# 3. Initialize Prettier config
echo "🖌️  Creating .prettierrc.js..."
cat > .prettierrc.js <<EOL
module.exports = {
  semi: true,
  trailingComma: 'all',
  singleQuote: true,
  printWidth: 100,
  tabWidth: 2,
};
EOL

# 4. Initialize Jest config
echo "🧪 Creating jest.config.js..."
cat > jest.config.js <<EOL
module.exports = {
  preset: 'react-native',
  setupFilesAfterEnv: ['@testing-library/jest-native/extend-expect'],
  transformIgnorePatterns: [
    'node_modules/(?!(jest-)?react-native|@react-native|@react-navigation)',
  ],
};
EOL

# 5. Setup Husky + lint-staged
echo "🔧 Setting up Husky and lint-staged..."
npx husky install
npx husky add .husky/pre-commit "npx lint-staged"

cat > .lintstagedrc.json <<EOL
{
  "*.{js,ts,tsx}": ["eslint --fix", "prettier --write"]
}
EOL

# 6. Final message
echo "✅ Dev setup complete! Run 'npm run lint' or 'npm test' to verify."
