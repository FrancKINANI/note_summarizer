# Offline-First SLM — Prototype & Mobile Roadmap

Lightweight repository to validate running a small language model (SLM) locally (offline) and to capture the architecture and roadmap for a future mobile app that runs AI entirely on-device.

- Prototype: Python script using llama-cpp-python to load a GGUF model (Phi-3-mini) from assets and run a chat completion.
- Long-term: Flutter mobile app (offline-first), resource-aware model selection (4-bit / 8-bit GGUF), encrypted local storage, optional opt-in cloud sync.

---

Table of Contents
- [Goals](#goals)
- [Project status](#project-status)
- [Project structure](#project-structure)
- [Quickstart — Python prototype (run locally)](#quickstart---python-prototype-run-locally)
  - [Prerequisites](#prerequisites)
  - [Download the model](#download-the-model)
  - [Create & activate a virtual environment](#create--activate-a-virtual-environment)
  - [Install dependencies](#install-dependencies)
  - [Run the prototype script](#run-the-prototype-script)
  - [Customizing the script](#customizing-the-script)
- [How it works (overview)](#how-it-works-overview)
- [Roadmap & next steps](#roadmap--next-steps)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Credits & model licensing](#credits--model-licensing)

---

## Goals

This repository proves you can run an SLM fully offline on a developer machine and documents the planned architecture for a mobile app that:
- Runs entirely on-device (no outbound API calls).
- Is resource-aware (selects quantized model based on RAM/year, handles battery/memory).
- Keeps user data encrypted at rest and optionally synced only with explicit permission.

(See `GOAL.md` for the full design rationale.)

---

## Project status

- Prototype (Python): ✅ Loading and inference with a GGUF Phi-3-mini model using llama-cpp-python — see `prototypes/prototype_script.py`.
- Mobile app (Flutter): In planning and initial architecture notes (dependencies and structure in `README.md`). Work items tracked in `docs/project_roadmap.md`.

---

## Project structure

```
project-1-offline-ai-app/
├── README.md
├── GOAL.md
├── docs/
│   ├── 01_prototype_setup.md
│   └── project_roadmap.md
├── prototypes/
│   ├── prototype_script.py
│   └── requirements.txt
├── assets/
│   └── models/    # place GGUF model file here
└── (flutter app files planned in repo root / lib/ etc.)
```

---

## Quickstart — Python prototype (run locally)

This is the easiest way to validate the offline inference flow.

### Prerequisites
- Python 3.8+ (3.10/3.11 recommended).
- A C compiler and build tools (llama-cpp-python typically compiles or links against llama.cpp).
  - On macOS: Xcode command line tools (`xcode-select --install`)
  - On Ubuntu/Debian: `sudo apt-get install build-essential libffi-dev` (plus other deps)
  - On Windows: Install Build Tools for Visual Studio (see llama-cpp-python docs)
- Enough disk space for the model (~hundreds of MB to several GB depending on the quantized model).

### Download the model
Download a GGUF quantized Phi-3-mini model (4-bit or 8-bit) and place it under `assets/models/`.

Recommended example (community/shared models — check license before use):
- Example HF repo: brittlewis12/Phi-3-mini-4k-instruct-GGUF  
- Save the file as (case-sensitive): `assets/models/Phi-3-mini-4k-instruct-q4.gguf`

Make sure the path matches what the prototype script expects:
- prototypes/prototype_script.py references: `../assets/models/Phi-3-mini-4k-instruct-q4.gguf`

If you keep a different filename, update `prototype_script.py` or pass a custom path (see [Customizing the script](#customizing-the-script)).

### Create & activate a virtual environment (recommended)

Unix/macOS:
```bash
python -m venv .venv
source .venv/bin/activate
```

Windows (PowerShell):
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### Install dependencies
From the repository root:
```bash
pip install --upgrade pip
pip install -r prototypes/requirements.txt
```

Note: `prototypes/requirements.txt` contains:
```
llama-cpp-python
```
Depending on your platform and the version of llama-cpp-python, pip may build native extensions and compile llama.cpp. See Troubleshooting below if install fails.

### Run the prototype script
From the repository root (so the relative model path in the script is valid):
```bash
python prototypes/prototype_script.py
```

Expected behavior:
- The script creates a Llama object pointing to the GGUF model.
- It runs a single chat completion: "Summarize: Machine learning is..."
- It prints the model's response to stdout.

Sample output (truncated):
```
Machine learning is a field of computer science focused on building systems that learn from data...
```

### Customizing the script

Open `prototypes/prototype_script.py` to tweak:
- model_path:
  ```py
  model_path="../assets/models/Phi-3-mini-4k-instruct-q4.gguf"
  ```
- n_ctx: context window, e.g. `n_ctx=2048`
- n_threads: number of CPU threads
- Prompt/messages passed to `create_chat_completion`

If you change where you run the script from, provide an absolute path or adjust the relative path accordingly.

---

## How it works (overview)

Prototype flow:
1. Load GGUF quantized model with llama-cpp-python (wrapper around `llama.cpp`).
2. Use the model to create a chat completion from a simple user prompt.
3. Print the generated content.

Mobile app (planned):
- Flutter frontend
- LLM runtime: either community `fllama` (llama.cpp binding) or MLC LLM integration
- Models stored as GGUF assets in the app; device detection selects quantization (4-bit vs 8-bit)
- Resource manager handles lazy loading/unloading and battery-aware background tasks
- Encrypted local store for user notes; optional cloud sync when user consents

See `GOAL.md` for architecture principles (offline-first, privacy, resource-aware design).

---

## Roadmap & next steps

From `docs/project_roadmap.md` (high-level):
- Phase 1 — Prototype (done): model runs locally in Python ✅
- Phase 2 — Mobile foundations: initialize Flutter project, organize architecture, configure assets
- Phase 3 — Integrate LLM in mobile: add `fllama` or manual binding, AI service for background loading
- Phase 4 — UI: home screen, chat interface, summarization flows
- Phase 5 — Advanced: memory management, encrypted DB, performance tuning
- Phase 6 — Docs & delivery: documentation, packaging, and installation instructions

If you're contributing, pick a Phase 2/3 item (e.g., create a small Flutter demo that loads the model on device, or add a CI script to validate the Python prototype).

---

## Troubleshooting

- Installation of llama-cpp-python fails:
  - Ensure you have a functioning C build toolchain and Python development headers.
  - See llama-cpp-python installation docs: https://github.com/abetlen/llama-cpp-python
  - On macOS M1/M2 machines, check for architecture flags or prebuilt wheels.
- Model not found / path error:
  - Confirm the exact filename and case; the prototype uses a relative path: `../assets/models/Phi-3-mini-4k-instruct-q4.gguf`
  - Run the script from the repo root so relative paths match, or change to an absolute path.
- Out of memory / slow inference:
  - Use a smaller quantization (4-bit) or a smaller model.
  - Reduce `n_ctx`.
  - Lower `n_threads` if running on a constrained CPU.
- Legal / licensing:
  - Verify the model's license before distributing the model files in a public repo or app bundle.

---

## Contributing

We welcome contributions. A simple workflow:
1. Open an issue to discuss larger ideas or to claim work.
2. Create a branch and a clear PR with tests or reproducible steps.
3. Document any platform-specific instructions (e.g., iOS linking with llama.cpp).

Suggested first tasks:
- Add a `CONTRIBUTING.md` and `LICENSE`.
- Add an automated check that `prototypes/prototype_script.py` runs in CI with a very small test model (if licensing allows).
- Start a Flutter skeleton app (`flutter create`) and commit initial `lib/` structure.

---

## Credits & model licensing

- Prototype uses `llama-cpp-python` (wrapper for `llama.cpp`) — see its repo and licensing.
- The sample model referenced (Phi-3-mini GGUF) is community/shared — always check the model's license on Hugging Face (or source).
- This project was authored/organized per the GOAL.md architecture document.

---

If anything is unclear or you want a specific "next-step" PR template, I can add that too. Happy to help convert the Python prototype into a small automated test or into the first Flutter demo screen.