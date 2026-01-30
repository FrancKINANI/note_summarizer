# 📱 Project 1: Offline-First AI Mobile App with SLM  
**Level**: Beginner | **Proves**: Edge AI + Resource Optimization  

> **Zero API calls. Zero cloud dependency. Full user privacy. Runs entirely on-device—even on older phones.**

---

## 🎯 Goal
Build a mobile application that uses a **small language model (SLM)** to provide intelligent features (e.g., note summarization, Q&A over personal notes, or chat) **without ever connecting to the internet**. The app must intelligently manage memory, battery, and model performance across diverse devices.

This isn’t a wrapper around an API—it’s a **real system** that proves you understand **edge constraints**, **quantization**, and **user-centric resource management**.

---

## 🔑 Core Principles
- ✅ **Offline-first**: All AI runs on-device. No data leaves the phone.
- 🔒 **Privacy by design**: User data is encrypted at rest.
- ⚡ **Resource-aware**: Adapts to device capabilities (RAM, CPU, battery).
- ♻️ **Efficient**: Minimizes wake cycles, batches work, and unloads unused models.

---

## 🧠 Key Architectural Decisions

### 1. **Model Management**
- **Lazy loading**: Load the SLM only when needed (e.g., when user opens the AI feature).
- **Memory pressure handling**: Unload the model if the OS signals low memory.
- **Preloading**: During idle time (e.g., phone charging, screen off), preload the model for instant response.

### 2. **Context Window**
- **Sliding window**: Keep only the most recent `N` tokens of conversation.
- **Semantic chunking**: Split user input at meaningful boundaries (e.g., sentence ends), not arbitrary character counts.
- **Embedding similarity**: Use vector similarity to retain **relevant** past context and archive irrelevant parts.

### 3. **Quantization Strategy**
- Detect device year/RAM at runtime:
  - **Pre-2020 or <4GB RAM** → load **4-bit quantized** model (smaller, slower, lower accuracy).
  - **2020+ or ≥4GB RAM** → load **8-bit quantized** model (better quality, still efficient).
- Models stored in **GGUF format** for fast loading and minimal overhead.

### 4. **Battery Optimization**
- **Batch inference**: Group multiple AI requests (e.g., summarizing 3 notes at once).
- **Throttle during low battery**: Skip non-critical AI tasks if battery < 20%.
- **Defer processing**: Postpone background indexing until device is charging.

### 5. **Offline-First Sync**
- All user data stored **locally in encrypted SQLite/Realm**.
- Optional cloud sync (e.g., to Azure Blob) **only when**:
  - Device is online,
  - User grants explicit permission,
  - Conflict resolution favors **local changes** (user owns their data).

---

## 🛠️ Tech Stack (Suggested)
| Component           | Recommendation                     |
|---------------------|------------------------------------|
| **Mobile Framework**| Flutter (cross-platform) or native Kotlin/Swift |
| **SLM Runtime**     | `MLC LLM` (easiest) or `llama.cpp` (more control) |
| **Model Format**    | GGUF (4-bit or 8-bit Phi-3-mini)   |
| **Embeddings**      | ONNX version of `all-MiniLM-L6-v2` |
| **Similarity Search**| `Annoy` (lightweight, mobile-friendly) |
| **Local Storage**   | Encrypted SQLite or Realm          |
| **Cloud Sync (opt.)**| Azure Blob Storage + MSAL auth    |

---

## 📦 Sample User Flow
1. User opens app → no model loaded yet (saves RAM).
2. User taps “Summarize my notes” → app:
   - Checks available RAM/battery.
   - Loads appropriate quantized model (4-bit or 8-bit).
   - Encodes notes into embeddings.
   - Uses Annoy to find most relevant chunks.
   - Runs SLM inference **offline**.
   - Displays summary.
3. When user switches apps → if memory pressure detected, model is unloaded.
4. At night, while charging → app preloads model for tomorrow.

---

## 🏆 What This Proves
You’re not just calling an API—you’re **engineering intelligence under real-world constraints**. You understand:
- How to ship AI on edge devices,
- How to trade off accuracy vs. resources,
- How to design for privacy and reliability.

This is the **first step toward becoming a Bridge Engineer**—someone who connects AI theory to production reality.
