# Owner Setup

Before the first merge to `main`, set **Settings → Pages → Source** to
**GitHub Actions**; otherwise `.github/workflows/pages.yml` will fail.

Enable GitHub Discussions before posting `DISCUSSIONS_SEED.md`.

The current `LICENSE` is incomplete: its permission paragraph ends with a
literal `...`, so GitHub reports `NOASSERTION`. If MIT is the intent, replace it
with the complete SPDX MIT text below, substituting `2026 Eduardo Pin` for
`<year> <copyright holders>`:

```text
MIT License

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
USE OR OTHER DEALINGS IN THE SOFTWARE.
```

Until `LICENSE` is corrected, the landing page and launch posts do not claim a
license.
