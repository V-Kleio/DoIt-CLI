<div align="center">
  <img width="100%" src="https://capsule-render.vercel.app/api?type=blur&height=280&color=0:d8dee9,100:2e3440&text=DoIt%20CLI%20%E2%9C%A8&fontColor=81a1c1&fontSize=50&animation=twinkling&" />
</div>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-green" />
  <img src="https://img.shields.io/badge/Recent_Build-Released-brightgreen" />
  <img src="https://img.shields.io/badge/Version-1.0.0-brightgreen" />
  <img src="https://img.shields.io/badge/License-MIT-yellowgreen" />
  <img src="https://img.shields.io/badge/Built_With-Bash-blue" />
  <img src="https://img.shields.io/badge/Platform-tmux%20%7C%20Unix-orange" />
</p>

<h1 align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=500&color=81a1c1&center=true&vCenter=true&width=600&lines=Welcome+to+DoIt+CLI!;Create.+Organize.+Launch." alt="Typing SVG" />
</h1>

---

## 📦 Table of Contents

- [✨ Overview](#-overview)
- [⚙️ Features](#️-features)
- [📸 Preview](#-preview)
- [📥 Installation](#-installation)
- [🚀 Usage](#-usage)
- [📂 Project Structure](#-project-structure)
- [🛣️ Roadmap](#️-roadmap)
- [🧠 Contributing](#-contributing)
- [👤 Author](#-author)

---

## ✨ Overview
**DoIt**: Your terminal, your flow — organized and programmable.

**DoIt** is a simple yet powerful CLI tool to manage terminal-based development workspaces using `tmux`, templates, and boilerplates.

No more tedious terminal command. Just define it once — then **DoIt**.

---

## ⚙️ Features

- **🧩 Template-based Layouts**: Define your workspace once, use it everywhere
- **🪄 One Command Setup**: Launch complex multi-window, multi-pane environments instantly
- **💾 Session Persistence**: Built-in integration with tmux-resurrect
- **📁 Project Boilerplates**: Initialize new projects with your boilerplate
- **🔍 Interactive Selection**: Easily choose sessions when multiple are available
- **🔄 Command Re-execution**: Automatically run commands when resuming sessions
- **🧰 Flexible Configurations**: Customize window layouts, pane sizes and commands

---

## 📸 Preview



---

## 📥 Installation

### 🔧 Prerequisites

- Unix-like OS (Linux, macOS, WSL)
- `tmux` installed
- `jq` required for parsing JSON

> [!NOTE]
> For tmux-resurrect integration, make sure tmux-resurrect is installed at `~/.tmux/plugins/tmux-resurrect/`.

### 📦 Quick Install (One-Liner)

```bash
curl -fsSL https://raw.githubusercontent.com/V-Kleio/DoIt-CLI/main/install.sh | bash
```

### Alternative Installation Methods

#### Manual Install (Local User)

```bash
git clone https://github.com/V-Kleio/DoIt-CLI.git
cd tmux-doit
./install.sh
```

#### Global Install (All Users)

```bash
curl -fsSL https://raw.githubusercontent.com/V-Kleio/DoIt-CLI/main/install.sh | bash -s -- --global
```

#### Custom Location

```bash
curl -fsSL https://raw.githubusercontent.com/V-Kleio/DoIt-CLI/main/install.sh | bash -s -- --prefix=~/bin
```

After installation, make sure the installation directory is in your PATH.

---

## 🚀 Usage

```bash
doit new my-session               # Create new session named 
                                  # my-session using default template

doit new my-session web-dev       # Create new session from 'web-dev' template

doit start my-session             # Resume session

doit switch my-session            # Switch to an existing session

doit list                         # List all tmux sessions

doit save                         # Save sessions (via tmux-resurrect)

doit restore                      # Restore sessions

doit forget my-session            # Kill & forget a session

doit clear                        # Forget all sessions
```

---

## 📂 Project Structure

```bash
doit/ 
├── bin/ 
│   └── doit # Main executable script 
├── templates/ 
│   └── default.json # Default workspace template 
├── install.sh # Installation script 
├── LICENSE # MIT License 
└── README.md # This file
```

---

## 🛣️ Roadmap

- [x] Core session management functionality
![](https://geps.dev/progress/100)
- [x] Template-based workspace creation
![](https://geps.dev/progress/100)
- [x] tmux-resurrect integration
![](https://geps.dev/progress/100)
- [ ] Tab completion for session names and commands
![](https://geps.dev/progress/60)
- [ ] Visual layout preview
![](https://geps.dev/progress/40)
- [ ] Template management commands
![](https://geps.dev/progress/20)
- [ ] Plugin system for extensions
![](https://geps.dev/progress/10)

---

## 🤝 Contributing
All contributions are welcome!
- 🐛 Found a bug?
- ✨ Have a feature idea?
- 🔧 Fixed something yourself?
- 📚 Want to improve the documentation?

Feel free to open an issue or submit a pull request.

Let’s build something awesome together 🚀

---

## 👤 Author

<p align="center"> <a href="https://github.com/V-Kleio"> <img src="https://avatars.githubusercontent.com/u/101655336?v=4" width="100px;" style="border-radius: 50%;" alt="V-Kleio"/> <br /> <sub><b>Rafael Marchel Darma Wijaya</b></sub> </a> </p>
<div align="center" style="color:#6A994E;"> 🌿 Crafted with care | 2025 🌿</div>

<p align="center">
  <a href="https://ko-fi.com/kleiov" target="_blank">
    <img src="https://cdn.ko-fi.com/cdn/kofi3.png?v=3" alt="Ko-fi" style="height: 40px;padding: 20px" />
  </a>
</p>

<!-- ## Contributor

<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/V-Kleio"><img style="border-radius: 20%" src="https://avatars.githubusercontent.com/u/101655336?v=4" width="100px;" alt="V-Kleio"/><br /><sub><b>Rafael Marchel Darma Wijaya</b></sub></a><br /></td>
    </tr>
  </tbody>
</table> -->

> [!IMPORTANT]\
> Something importang.

> [!WARNING]\
> Some warning.

> [!NOTE]\
> Some notes.