# Alchemy Dynamics — Screensaver

A purple star-travel screensaver for **Alchemy Dynamics**. The logo floats at the
center of an endless violet starfield while you cruise slowly past the stars.
Optional **webcam head tracking** lets you steer: turn your head and the field
leans the way you look — subtle, but noticeable.

![Alchemy Dynamics](assets/logo.png)

## Features

- **Traveling starfield** — true 3D perspective so near stars sweep past faster
  than far ones (real parallax, not faked layers).
- **Purple palette** — violet / indigo / magenta cores with soft glows and gentle
  motion streaks.
- **Centered logo** — slow float + a slight 3D lean that follows your gaze.
- **Head steering** — MediaPipe FaceLandmarker reads your head yaw/pitch and
  nudges the vanishing point in that direction.
- **Graceful fallback** — no camera (or permission denied)? Steer with the mouse.
  Idle? It drifts on its own.

## Run it

It's a static page — no build step.

```bash
# from the project folder
python3 -m http.server 8000
# then open http://localhost:8000
```

> A local server (or HTTPS) is required for the webcam: browsers only grant
> camera access on `http://localhost` or `https://`. Opening `index.html`
> directly via `file://` works for the starfield + mouse, but not head tracking.

### Controls

| Input | What it does |
|-------|--------------|
| **Enter with head tracking** | Asks for the camera, then steers by head turn |
| **Continue without camera** | Mouse-only steering |
| Move mouse | Steer the field (overrides nothing if tracking is on) |
| Idle | Falls back to a slow autonomous drift |

## How the steering works

Each star has a 3D position; the camera flies forward and stars are recycled to
the far plane as they pass. Your look direction (head or mouse) shifts the
vanishing point and adds a small lateral velocity that scales with each star's
proximity — so steering reads as genuine parallax depth, kept deliberately gentle.

## Tech

Plain HTML + Canvas 2D, zero dependencies bundled. Head tracking loads
[`@mediapipe/tasks-vision`](https://developers.google.com/mediapipe) from a CDN
at runtime, so the page stays tiny and works offline for everything except the
optional tracker.

---

© Alchemy Dynamics
