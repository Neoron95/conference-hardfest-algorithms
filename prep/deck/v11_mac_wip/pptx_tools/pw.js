// Playwright loader: the preinstalled one in the Claude Code cloud sandbox if present, else the local node_modules
// (on your own computer: npm install && npx playwright install chromium).
const fs = require('fs');
const GLOBAL = '/opt/node22/lib/node_modules/playwright';
module.exports = () => fs.existsSync(GLOBAL) ? require(GLOBAL) : require('playwright');
