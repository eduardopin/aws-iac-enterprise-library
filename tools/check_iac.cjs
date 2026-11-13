// IaC page checks (adapted from the hub's check_hub.cjs): screenshots, overflow, reduced motion, contrast (DOM + hero pixel worst frame), head, links, weight/LCP.
const { chromium } = require(process.env.PLAYWRIGHT_CORE || (process.env.HOME + '/.nvm/versions/node/v22.23.1/lib/node_modules/@playwright/mcp/node_modules/playwright-core'));
const fs = require('fs');
const BASE = process.env.BASE || 'http://127.0.0.1:8794/aws-iac-enterprise-library/';
const SITE = process.argv[2];
const OUT = process.argv[3];
const QUICK = process.argv[4] === 'quick';
const exe = process.env.HOME + '/.cache/ms-playwright/chromium_headless_shell-1234/chrome-headless-shell-linux64/chrome-headless-shell';
const R = {};

const contrastFns = `
const lin = v => { v /= 255; return v <= 0.03928 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; };
const L = c => 0.2126 * lin(c[0]) + 0.7152 * lin(c[1]) + 0.0722 * lin(c[2]);
const cr = (a, b) => { const x = L(a), y = L(b); return (Math.max(x, y) + 0.05) / (Math.min(x, y) + 0.05); };
const parse = s => { const m = s.match(/[\\d.]+/g).map(Number); return [m[0], m[1], m[2], m.length > 3 ? m[3] : 1]; };
const over = (top, bot) => [0, 1, 2].map(i => top[i] * top[3] + bot[i] * (1 - top[3])).concat(1);
`;

(async () => {
  const browser = await chromium.launch({ executablePath: exe });

  // ---------- screenshots, overflow, DOM contrast ----------
  R.views = [];
  for (const [w, h] of [[1280, 800], [400, 860], [320, 640]]) {
    for (const scheme of ['light', 'dark']) {
      const ctx = await browser.newContext({ viewport: { width: w, height: h }, colorScheme: scheme });
      const page = await ctx.newPage();
      await page.goto(BASE, { waitUntil: 'networkidle' });
      await page.evaluate(() => document.fonts.ready);
      await page.evaluate(() => document.getAnimations().forEach(a => { a.pause(); a.currentTime = 6000; }));
      const info = await page.evaluate(contrastFns + `(() => {
        const bgOf = el => { const stack = []; for (let e = el; e; e = e.parentElement) { const c = parse(getComputedStyle(e).backgroundColor); if (c[3] > 0) { stack.push(c); if (c[3] >= 1) break; } } let bg = [255,255,255,1]; for (let i = stack.length - 1; i >= 0; i--) bg = over(stack[i], bg); return bg; };
        const fails = []; let min = 99, minAt = '';
        for (const el of document.querySelectorAll('body *')) {
          if (el.closest('[aria-hidden="true"], .po-hero__copy, script, style, svg')) continue;
          const own = [...el.childNodes].some(n => n.nodeType === 3 && n.textContent.trim());
          if (!own) continue;
          const r = el.getBoundingClientRect(); const s = getComputedStyle(el);
          if (!r.width || !r.height || s.visibility === 'hidden' || el.closest('.iac-skip')) continue;
          const fg = parse(s.color); const bg = bgOf(el); const c = cr(over(fg, bg), bg);
          const size = parseFloat(s.fontSize), bold = parseInt(s.fontWeight) >= 700;
          const need = size >= 24 || (size >= 18.66 && bold) ? 3 : 4.5;
          if (c < min) { min = c; minAt = el.tagName + '.' + el.className + ' "' + el.textContent.trim().slice(0, 30) + '"'; }
          if (c < need) fails.push({ t: el.textContent.trim().slice(0, 40), c: +c.toFixed(2), need });
        }
        return { sw: document.documentElement.scrollWidth, cw: document.documentElement.clientWidth, min: +min.toFixed(2), minAt, fails,
          font: getComputedStyle(document.querySelector('h1')).fontFamily.split(',')[0], loaded: [...new Set([...document.fonts].filter(f => f.status === 'loaded').map(f => f.family))].join('+'),
          minTarget: Math.min(...[...document.querySelectorAll('a.po-btn, .po-header__gh, .po-nav a, .iac-stars, .po-copy, .filter-row input, .filter-clear, .module-list a, .text-link, .standard-card > a, .po-footer nav a, .po-cross__item a')].filter(e => e.offsetParent).map(e => Math.round(e.getBoundingClientRect().height))) };
      })()`);
      const name = `iac-${w}x${h}-${scheme}`;
      await page.screenshot({ path: `${OUT}/${name}.png` });
      if (scheme === 'light') await page.screenshot({ path: `${OUT}/${name}-full.png`, fullPage: true });
      R.views.push({ name, ...info });
      await ctx.close();
    }
  }

  // ---------- reduced motion ----------
  R.reduced = [];
  for (const scheme of ['light', 'dark']) {
    const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 }, colorScheme: scheme, reducedMotion: 'reduce' });
    const page = await ctx.newPage();
    await page.goto(BASE, { waitUntil: 'networkidle' });
    await page.evaluate(() => document.fonts.ready);
    const info = await page.evaluate(() => ({
      running: document.getAnimations().filter(a => a.playState === 'running').length,
      trailsShown: [...document.querySelectorAll('.po-art .trail')].filter(e => getComputedStyle(e).display !== 'none').length,
      sweepShown: [...document.querySelectorAll('.po-btn--star')].filter(e => getComputedStyle(e, '::before').display !== 'none').length,
      opacity0: [...document.querySelectorAll('body *')].filter(e => e.getClientRects().length && getComputedStyle(e).opacity === '0').map(e => e.className),
      offscreen: [...document.querySelectorAll('body *')].filter(e => { if (!e.getClientRects().length || e.closest('[aria-hidden="true"]')) return false; const r = e.getBoundingClientRect(); return getComputedStyle(e).transform !== 'none' && (r.bottom < -window.scrollY || r.right < 0 || r.left > document.documentElement.scrollWidth); }).map(e => e.className),
    }));
    await page.screenshot({ path: `${OUT}/iac-1280x800-${scheme}-reduced.png` });
    R.reduced.push({ scheme, ...info });
    await ctx.close();
  }

  // ---------- hero worst frame: pixels behind eyebrow, h1, lede, ghost button over one full 27s trail period ----------
  R.hero = [];
  for (const [w, h] of [[1280, 800], [400, 860]]) {
    for (const scheme of ['light', 'dark']) {
      const ctx = await browser.newContext({ viewport: { width: w, height: h }, colorScheme: scheme });
      const page = await ctx.newPage();
      await page.goto(BASE, { waitUntil: 'networkidle' });
      await page.evaluate(() => document.fonts.ready);
      const boxes = await page.evaluate(() => ['.po-hero__eyebrow', '.po-hero h1', '.po-hero__lede', '.iac-facts li', '.iac-graph figcaption'].map(s => { const e = document.querySelector(s); const r = e.getBoundingClientRect(); return { s, x: r.x, y: r.y, w: r.width, h: r.height, color: getComputedStyle(e).color }; }));
      await page.addStyleTag({ content: '.po-hero__copy *,.iac-graph figcaption{color:transparent!important;border-color:transparent!important;transition:none!important}.po-hero__copy .po-btn,.po-hero__copy .iac-stars{visibility:hidden}' });
      let worst = { cr: 99 };
      const step = QUICK ? 3000 : 1000;
      for (let t = 0; t <= 27000; t += step) {
        await page.evaluate(t => document.getAnimations().forEach(a => { a.pause(); a.currentTime = t; }), t);
        for (const b of boxes.filter(b => b.w > 0 && b.h > 0 && b.y >= 0 && b.y + b.h <= h)) { // only text inside the first viewport
          const buf = await page.screenshot({ clip: { x: b.x, y: b.y, width: b.w, height: b.h } });
          const r = await page.evaluate(async ({ data, color }) => {
            const lin = v => { v /= 255; return v <= 0.03928 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; };
            const L = c => 0.2126 * lin(c[0]) + 0.7152 * lin(c[1]) + 0.0722 * lin(c[2]);
            const fg = color.match(/[\d.]+/g).map(Number); const Lf = L(fg);
            const img = new Image(); img.src = 'data:image/png;base64,' + data; await img.decode();
            const c = document.createElement('canvas'); c.width = img.width; c.height = img.height; const x = c.getContext('2d'); x.drawImage(img, 0, 0);
            const d = x.getImageData(0, 0, c.width, c.height).data; let w = 99;
            for (let i = 0; i < d.length; i += 4) { const Lb = L([d[i], d[i+1], d[i+2]]); const v = (Math.max(Lf, Lb) + 0.05) / (Math.min(Lf, Lb) + 0.05); if (v < w) w = v; } return w; }, { data: buf.toString('base64'), color: b.color });
          if (r < worst.cr) worst = { cr: +r.toFixed(2), sel: b.s, t };
        }
      }
      R.hero.push({ view: `${w}x${h}-${scheme}`, ...worst });
      await ctx.close();
    }
  }

  // ---------- head, JSON-LD, headings, images, anchors, keyboard ----------
  {
    const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 } });
    const page = await ctx.newPage();
    await page.goto(BASE, { waitUntil: 'networkidle' });
    R.head = await page.evaluate(() => {
      const meta = n => document.querySelector(`meta[name="${n}"], meta[property="${n}"]`)?.content;
      const hs = [...document.querySelectorAll('h1,h2,h3,h4,h5,h6')].map(h => +h.tagName[1]);
      let skip = []; for (let i = 1; i < hs.length; i++) if (hs[i] > hs[i - 1] + 1) skip.push(hs[i - 1] + '->' + hs[i]);
      const ld = [...document.querySelectorAll('script[type="application/ld+json"]')].map(s => { try { JSON.parse(s.textContent); return 'ok'; } catch (e) { return 'FAIL ' + e.message; } });
      return { title: document.title, titleLen: document.title.length, descLen: meta('description').length, canonical: document.querySelector('link[rel=canonical]').href,
        ogImage: meta('og:image'), ogW: meta('og:image:width'), ogH: meta('og:image:height'), h1: document.querySelectorAll('h1').length, skip, ld,
        imgsMissing: [...document.images].filter(i => !i.hasAttribute('alt') || !i.getAttribute('width') || !i.getAttribute('height')).map(i => i.src),
        lazyImgs: [...document.images].filter(i => i.loading === 'lazy').length,
        badAnchors: [...document.querySelectorAll('a[href^="#"]')].map(a => a.getAttribute('href')).filter(h => h !== '#' && !document.getElementById(h.slice(1))) };
    });
    await page.keyboard.press('Tab');
    await page.waitForTimeout(400);
    R.keyboard = await page.evaluate(() => { const a = document.activeElement; const r = a.getBoundingClientRect(); const s = getComputedStyle(a); return { first: a.className + ' ' + a.textContent, visible: r.top >= 0 && r.bottom > 0, outline: s.outlineStyle + ' ' + s.outlineWidth + ' ' + s.outlineColor }; });
    const tabs = []; for (let i = 0; i < 6; i++) { await page.keyboard.press('Tab'); tabs.push(await page.evaluate(() => { const s = getComputedStyle(document.activeElement); return document.activeElement.textContent.trim().slice(0, 24) + ' | ' + s.outlineStyle + ' ' + s.outlineWidth; })); }
    R.keyboard.next = tabs;
    // 404 rendered at depth, as GitHub Pages serves it
    const html404 = fs.readFileSync(SITE + '/404.html', 'utf8');
    await page.route('**/aws-iac-enterprise-library/a/b/c', r => r.fulfill({ status: 404, contentType: 'text/html', body: html404 }));
    const failed = []; page.on('response', r => { if (r.status() >= 400 && !r.url().endsWith('/a/b/c')) failed.push(r.status() + ' ' + r.url()); });
    await page.goto(BASE + 'a/b/c', { waitUntil: 'networkidle' });
    R.notFound = await page.evaluate(() => ({ h1: document.querySelector('h1')?.textContent, cssLoaded: getComputedStyle(document.body).backgroundColor, robots: document.querySelector('meta[name=robots]')?.content, cross: document.querySelectorAll('.po-cross__item').length, broken: [...document.images].filter(i => !i.naturalWidth).map(i => i.src) }));
    R.notFound.failed = failed;
    await page.screenshot({ path: `${OUT}/iac-404-at-depth.png` });
    await ctx.close();
  }

  // ---------- weight and LCP, cold load ----------
  {
    const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 } });
    const page = await ctx.newPage();
    const sizes = []; const statuses = [];
    page.on('response', async r => { try { const b = await r.body(); sizes.push({ url: r.url(), n: b.length }); } catch (e) {} statuses.push(r.status() + ' ' + r.url()); });
    await page.addInitScript(() => { window.__lcp = []; new PerformanceObserver(l => l.getEntries().forEach(e => window.__lcp.push({ t: e.startTime, el: e.element ? e.element.tagName + '#' + e.element.id + '.' + e.element.className : '', lazy: e.element?.loading === 'lazy' }))).observe({ type: 'largest-contentful-paint', buffered: true }); });
    await page.goto(BASE, { waitUntil: 'networkidle' });
    await page.waitForTimeout(500);
    const lcp = await page.evaluate(() => window.__lcp.at(-1));
    const isFont = u => /fonts\.(googleapis|gstatic)\.com/.test(u);
    R.weight = { totalExFonts: sizes.filter(s => !isFont(s.url)).reduce((a, s) => a + s.n, 0), fonts: sizes.filter(s => isFont(s.url)).reduce((a, s) => a + s.n, 0),
      largestImage: Math.max(...sizes.filter(s => /\.(png|svg|webp|jpg)|shields/.test(s.url)).map(s => s.n)), lcp, bad: statuses.filter(s => !/^(200|204|304)/.test(s)),
      byUrl: sizes.filter(s => !isFont(s.url)).map(s => s.n + ' ' + s.url.replace(BASE, '')) };
    await ctx.close();
  }

  await browser.close();
  console.log(JSON.stringify(R, null, 1));
})();
