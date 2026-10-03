# Hail a Human

A single-page advocacy site about how robotaxis affect human drivers and local economies.

Plain HTML/CSS/JS. No framework, no build step.

## Local preview

```bash
python3 -m http.server 8000
```

Then open http://localhost:8000.

## Deploy

Hosted on Vercel as a static site. In the Vercel project settings use:

- Framework Preset: **Other**
- Build Command: *(empty)*
- Output Directory: *(empty, serves the repo root)*

Every push to `main` deploys to production. Other branches get preview URLs.
