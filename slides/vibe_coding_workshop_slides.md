---
title:
  - Vibe Coding Workshop
subtitle:
  - "Agentic Engineering: Models, Context, Playbooks & Practice"
author:
  - Tech GC
theme:
  - Copenhagen
date:
  - November 2026
colorlinks: true
linkcolor: .
urlcolor: blue
header-includes: |
  \usepackage{tikz}
  \usepackage{caption}
  \usepackage{listings}
  \usepackage{multicol}
  \usepackage{fvextra}
  \usepackage{xeCJK}
  \setCJKsansfont{PingFang SC}
  \setCJKmainfont{PingFang SC}
  \setCJKmonofont{PingFang SC}
  \xeCJKDeclareCharClass{Default}{"2014,"2018,"2019,"201C,"201D,"2026}
  \usetikzlibrary{arrows.meta,positioning,calc,fit}
  \setbeamertemplate{headline}{}
  \definecolor{ink}{HTML}{000000}
  \definecolor{muted}{HTML}{666666}
  \definecolor{theme}{HTML}{3333B2}
  \colorlet{work}{theme}
  \colorlet{workfill}{theme!7}
  \colorlet{stage}{theme}
  \colorlet{head}{theme}
  \lstset{basicstyle=\ttfamily,frame=single,frameround=tttt,columns=fullflexible,keepspaces=true,backgroundcolor=\color{workfill}}
  \captionsetup[figure]{labelformat=empty}
  \fvset{breaklines=true,breakanywhere=true}
---

## Contents

\tableofcontents

# Introduction

## Why Agent? (And Why Vibe Coding?)

**Beyond the Hype: "Folk Magic"**

- Not every spell slays a dragon; some just make sour grapes sweet (*Frieren*)
- Off-the-shelf apps never fit $100\%$ of your workflow
- **Vibe Coding**: tiny, bespoke tools for yourself or your dorm—ideas to working software in minutes

\vspace{8pt}

**Why learn agent workflows?**

- From single-turn "wish-making" to **closed-loop engineering**
- Agents handle boilerplate; you keep architectural control

## Programs vs. Models: Two kinds of functions

\begin{figure}[htbp]
\centering
\resizebox{0.94\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  pbox/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=5.4cm,minimum height=2.2cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  mbox/.style={draw=theme,fill=theme!15,line width=1.5pt,rounded corners=3pt,minimum width=5.4cm,minimum height=2.2cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  sym/.style={font=\sffamily\bfseries\fontsize{15}{17}\selectfont,text=theme}]
  \node[pbox] (p) at (0,0) {\textbf{Program}: $y = f(x)$\\[4pt]Explicit, hard-coded rules\\Deterministic: $10{,}000$ runs $\rightarrow$ $1$ result\\\textit{e.g., Rename $500$ photos by EXIF date}};
  \node[sym] at (3.4,0) {vs.};
  \node[mbox] (m) at (6.8,0) {\textbf{AI Model}: $y \approx \hat{f}_{\theta}(x)$\\[4pt]Implicit patterns learned from data\\Probabilistic: handles fuzzy rules\\\textit{e.g., Speech-to-text, intent \& code gen}};
\end{tikzpicture}
}%
\end{figure}

- **Don't use a model as a slow, expensive calculator**: Feeding $500$ filenames into chat wastes tokens and risks hallucinations
- **Code is an agent's sharpest tool**: LLMs were trained on massive codebases—for deterministic tasks, **ask the agent to write and run a script**
- **Best of both worlds**: Model understands fuzzy human intent $\rightarrow$ writes a deterministic program $\rightarrow$ executes it reliably

## Core terminology: Token & Model

- **Token**
  - *General*: A single occurrence of a word or symbol in text
  - *In Agent systems*: A sequence unit produced by a **tokenizer** (mapped to an integer ID); $1$ Chinese character $\approx 0.6\text{--}1.5$ tokens depending on the vocabulary

- **Model**
  - *General*: A mathematical representation of a phenomenon or relationship
  - *In Agent systems*: A universal function pre-trained on vast corpora; **autoregressive** models predict the probability distribution of the **next token** step by step
  - *Prompt as input*: Changing the prompt dynamically switches which latent capability ("sub-function") the model activates

## Core terminology: Context & Reasoning

- **Context**
  - *General*: Surrounding text or background needed to understand a statement
  - *In Agent systems*: **Everything** fed into a single API call—system instructions, project rules, full chat history, file contents, and tool outputs

- **Reasoning**
  - *General*: Drawing conclusions from premises through intermediate steps
  - *In Agent systems*: Extra test-time compute before answering; reasoning models generate hidden or visible **thinking tokens** to plan and self-correct prior to the final output

## Core terminology: Tools, Harness & Agent

- **Tool**
  - *In Agent systems*: An external capability exposed to the model (File I/O, Shell, Git, Browser). **The model only outputs a JSON request; the external program executes it**

- **Harness**
  - *In Agent systems*: The runtime software wrapping the model (`OpenCode`, `Claude Code`, `Codex CLI`) that assembles context, calls the API, runs tools, and manages the loop

- **Agent**
  - *Web Chat vs. Agent*: Web chat is an **advisor behind glass**; an Agent (**Model + Harness + Tools**) is a **worker inside your workspace** that reads files, runs tests, and finishes the job end-to-end

# Models & Tokens

## How models process information

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=4.4cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  centerbox/.style={draw=theme,fill=theme!15,line width=1.6pt,rounded corners=3pt,minimum width=4.6cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.3pt,-{Stealth[length=2.6mm,width=2mm]}}]
  \node[box] (in) at (0,0) {\textbf{Inputs}\\Text, images, code\\\& tool results};
  \node[centerbox] (model) at (6.0,0) {\textbf{Model}\\Process context\\\& predict next token};
  \node[box] (out) at (12.0,0) {\textbf{Outputs}\\Text, images, or\\structured tool calls};
  \draw[flow] (in.east) -- (model.west);
  \draw[flow] (model.east) -- (out.west);
\end{tikzpicture}
}%
\end{figure}

- **Next-token prediction**: Every generated token is appended back to the context to compute the next one
- **Billing**: Input, output, cached input, and reasoning tokens are billed at different rates; **input volume usually dominates agent costs**
- **Hardware myth**: You do **not** need an expensive GPU laptop to learn Vibe Coding—heavy inference runs on cloud/campus servers

## Selecting a model: Key dimensions

Compare candidate models according to your workload requirements:

\small

<!--prettier-ignore-->
| Dimension | What to observe |
| :---------- | :------------------------------------------------------ |
| **Capability** | Tool-calling accuracy, instruction following & error recovery |
| **Cost** | Input, output, cached input & reasoning token pricing |
| **Latency** | Time to first token (TTFT), total runtime & rate limits |
| **Deployment** | Commercial cloud API vs. campus/self-hosted open weights |

- **Workflow Strategy**: Use your **strongest reasoning model** for architecture & planning, and a **fast/coding-tuned model** for iterative execution
- **Tip**: Check [OpenRouter Rankings](https://openrouter.ai/rankings) for real-world usage trends, but beware of benchmark gaming—evaluate on your own tasks

\normalsize

## Selecting a model: Candidates

- **Commercial APIs**
  - Flagship proprietary families such as **Claude**, **GPT**, and **Gemini**

- **Open-weight models**
  - Publicly available weight families such as **DeepSeek**, **Qwen**, **GLM**, and **Kimi**
  - Always verify license terms and whether full weights or only distilled variants are released

- **Warning on third-party "relay stations" (中转站)**
  - Avoid shady discount API proxies: they often suffer from broken prefix caching, degraded quantizations, and zero data privacy
  - Prefer official APIs or trusted campus endpoints (e.g., **SJTU Models API**)

## Reasoning effort

\center

![Reasoning effort vs. task time](slides/assets/agent-tutorial/reasoning-effort.png){ width=76% }

\raggedright
\small

- **Reasoning effort** controls how much compute a model invests in intermediate thinking, directly affecting token usage and latency.
- **Tip**: Set a consistent thinking effort for a long session rather than toggling it back and forth on every turn.

\normalsize

# Inside an Agent

## Anatomy of an agent

\begin{figure}[htbp]
\centering
\resizebox{0.88\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=3.8cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  agentbox/.style={draw=theme,fill=theme!16,line width=1.6pt,rounded corners=3pt,minimum width=4.0cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  sym/.style={font=\sffamily\bfseries\fontsize{18}{20}\selectfont,text=theme}]
  \node[box] (m) at (0,0) {\textbf{Model}\\Decide next step};
  \node[sym] at (2.7,0) {+};
  \node[box] (h) at (5.4,0) {\textbf{Harness}\\Manage context\\\& run tools};
  \node[sym] at (8.1,0) {=};
  \node[agentbox] (a) at (10.9,0) {\textbf{Agent}\\Execute tasks\\end-to-end};
\end{tikzpicture}
}%
\end{figure}

- Placing the **same model** inside different harnesses yields different tool schemas, permission checks, context compaction, and completion rates
- Agent behavior is jointly shaped by **model capability**, **harness design**, **context quality**, and **verification tools**
- Underlying mental models are $100\%$ transferable across `OpenCode`, `Claude Code`, `Codex`, and `Cursor`

## The agentic loop

\begin{figure}[htbp]
\centering
\resizebox{0.88\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  goal/.style={draw=muted!70,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=2.8cm,minimum height=1.1cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  core/.style={draw=theme,fill=theme!15,line width=1.5pt,rounded corners=3pt,minimum width=3.4cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  stepnode/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=3.2cm,minimum height=1.1cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  done/.style={font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=theme},
  lbl/.style={font=\ttfamily\fontsize{9}{11}\selectfont,text=muted},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[goal] (u) at (0,0) {\textbf{User Goal}};
  \node[core] (m) at (4.4,0) {\textbf{Model Decides}\\Next Step};
  \node[stepnode] (h) at (9.6,0) {\textbf{Harness}\\Executes Tool};
  \node[stepnode] (c) at (4.4,-2.1) {\textbf{Tool Output}\\Enters Context};
  \node[done] (d) at (4.4,1.55) {Task complete: finish \& report};

  \draw[flow] (u.east) -- (m.west);
  \draw[flow] (m.north) -- (d.south);
  \draw[flow] (m.east) -- node[above,lbl] {tool call} (h.west);
  \draw[flow] (h.south) |- (c.east);
  \draw[flow] (c.north) -- node[left,lbl] {continue / revise} (m.south);
\end{tikzpicture}
}%
\end{figure}

**The ReAct Pattern**

- **Reason**: Analyze the goal and current observations to decide the next action
- **Act**: Emit a structured tool call to inspect or modify the environment
- **Observe**: Read the tool execution result (or compiler/test error) and feed it into the next reasoning step

## Tools & Subagents

\begin{figure}[htbp]
\centering
\resizebox{0.88\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  mnode/.style={draw=theme,fill=theme!14,line width=1.4pt,rounded corners=3pt,minimum width=3.3cm,minimum height=2.4cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  hnode/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=3.5cm,minimum height=2.4cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  tnode/.style={draw=muted!75,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.4cm,minimum height=0.72cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[mnode] (m) at (0,0) {\textbf{Model}\\[4pt]Generate text or\\structured tool call};
  \node[hnode] (h) at (4.6,0) {\textbf{Harness}\\[4pt]Verify permissions\\Execute tool\\Return output};
  \node[tnode] (t1) at (9.3,0.9) {Read / Write Files};
  \node[tnode] (t2) at (9.3,0) {Shell / Git / Tests};
  \node[tnode] (t3) at (9.3,-0.9) {Browser / Subagents};

  \draw[flow] (m.east) -- (h.west);
  \draw[flow] (h.east) -- ++(0.55,0) |- (t1.west);
  \draw[flow] (h.east) -- (t2.west);
  \draw[flow] (h.east) -- ++(0.55,0) |- (t3.west);
\end{tikzpicture}
}%
\end{figure}

\small

<!--prettier-ignore-->
| Category | Role in practice |
| :-------------- | :-------------------------------------------------------- |
| **Built-in tools** | **File I/O, Shell, and Git** are the core foundation—master these first |
| **Skills (`SKILL.md`)** | Reusable prompting playbooks/workflows saved as files—no magic, just structured habits |
| **Subagents** | Isolated child contexts for heavy searches/docs reading so your **main context stays clean** |

\normalsize

## Context window & Why Turn 20 costs $20\times$ more

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  bar/.style={draw=theme,fill=workfill,line width=1.1pt,rounded corners=2pt,minimum width=11.6cm,minimum height=0.64cm,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  top/.style={draw=theme,fill=theme,line width=1.1pt,rounded corners=2pt,minimum width=11.6cm,minimum height=0.64cm,font=\sffamily\fontsize{10}{12}\selectfont,text=white}]
  \node[top] (b1) at (0,3.0) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=white] at (-5.5,3.0) {System prompt};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=white] at (5.5,3.0) {Platform identity, tool definitions \& permissions};

  \node[bar,fill=theme!14] (b2) at (0,2.25) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,2.25) {Project rules};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,2.25) {\texttt{AGENTS.md}, repo conventions \& architecture decisions};

  \node[bar,fill=theme!9] (b3) at (0,1.5) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,1.5) {Chat history};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,1.5) {Every previous turn (User + Assistant messages)};

  \node[bar,fill=theme!6] (b4) at (0,0.75) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,0.75) {Working evidence};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,0.75) {File contents, command outputs \& stack traces};

  \node[bar,fill=white,draw=muted!60] (b5) at (0,0.0) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,0.0) {On-demand docs};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,0.0) {\texttt{SKILL.md}, library docs \& search results};

  \draw[draw=muted!75,line width=1.1pt,dashed,rounded corners=4pt] (-6.1,-0.5) rectangle (6.1,3.5);
  \node[anchor=west,font=\ttfamily\fontsize{10}{12}\selectfont,text=muted] at (6.3,1.5) {context window};
\end{tikzpicture}
}%
\end{figure}

- **The "Continue" Trap**: Models have no persistent memory—typing *"Continue"* at Turn 20 re-sends **all 19 previous turns** plus every file read!
- **"Fits in window" $\neq$ "Remembers clearly"**: When context exceeds $\sim 60\text{--}70\%$, models suffer from **"lost in the middle"** attention degradation
- **Context Hygiene**: Start a fresh session when switching topics; paste only the relevant $5$ lines of an error log instead of $1{,}000$ lines

## Stateless APIs & Prefix caching

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  lbl/.style={font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink,anchor=west},
  sys/.style={draw=theme,fill=theme,text=white,line width=1pt,minimum height=0.68cm,font=\sffamily\fontsize{9}{11}\selectfont,align=center},
  usr/.style={draw=theme,fill=theme!14,text=ink,line width=1pt,minimum height=0.68cm,font=\sffamily\fontsize{9}{11}\selectfont,align=center},
  ans/.style={draw=theme,fill=workfill,text=ink,line width=1pt,minimum height=0.68cm,font=\sffamily\fontsize{9}{11}\selectfont,align=center},
  new/.style={draw=muted!80,fill=white,text=ink,line width=1pt,minimum height=0.68cm,font=\sffamily\fontsize{9}{11}\selectfont,align=center}]
  \node[lbl] at (-1.8,1.0) {Turn 1};
  \node[sys,minimum width=2.8cm] at (1.4,1.0) {system + rules};
  \node[usr,minimum width=2.4cm] at (4.0,1.0) {User prompt 1};

  \node[lbl] at (-1.8,0.0) {Turn 2};
  \node[sys,minimum width=2.8cm] at (1.4,0.0) {system + rules};
  \node[usr,minimum width=2.4cm] at (4.0,0.0) {User prompt 1};
  \node[ans,minimum width=2.2cm] at (6.3,0.0) {Response 1};
  \node[new,minimum width=2.4cm] at (8.6,0.0) {User prompt 2};

  \draw[draw=theme,line width=1.3pt] (0.0,-0.52) -- (5.2,-0.52);
  \node[font=\sffamily\bfseries\fontsize{9}{11}\selectfont,text=theme] at (2.6,-0.82) {Identical prefix (A + B): eligible for KV cache hit (up to 90\% cheaper)};
\end{tikzpicture}
}%
\end{figure}

- **The Golden Rule of Caching — *Append-Only***: Keep the prefix untouched and only append new messages at the end ($A \rightarrow A+B \rightarrow A+B+C$)
- **How to avoid breaking your cache**:
  - Do **not** edit early system prompts or switch models mid-task
  - Do **not** toggle reasoning effort back and forth on every turn
- **Cache serves the task, not vice versa**: A $90\%$ cache hit rate is useless if the context is polluted—spawn a subagent or compact when needed!

# The Vibe Coding Playbook

## 1. "Grill Me" Before Writing Code

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  bad/.style={draw=muted!80,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  good/.style={draw=theme,fill=theme!14,line width=1.5pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  doc/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=3.4cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=theme,line width=1.3pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[bad] (idea) at (0,0) {\textbf{Fuzzy Idea}\\``Build me a DDL app''};
  \node[good] (grill) at (4.8,0) {\textbf{``Grill Me'' Loop}\\AI interviews you\\until specs are clear};
  \node[doc] (spec) at (9.5,0) {\textbf{Decision Log}\\\texttt{DECISIONS.md}\\Ready for execution};
  \draw[flow] (idea.east) -- (grill.west);
  \draw[flow] (grill.east) -- (spec.west);
\end{tikzpicture}
}%
\end{figure}

- **Why "wish-making" fails**: If your prompt is vague, the AI will **confidently guess** missing requirements—turning into massive technical debt later
- **The `Grill Me` Prompt Pattern** (by Matt Pocock):

  \small

  > *"I want to build [X]. **Do NOT write any code yet.** Interview me one question at a time to uncover edge cases, MVP scope, and data storage. Look up technical facts yourself; only ask me what requires my decision. When clear, save a summary to `DECISIONS.md`."*

  \normalsize

## 2. Choose Boring Technology & Respect Open Source

- **Don't let AI over-engineer your stack**
  - Left unchecked, AI loves recommending complex cloud stacks (microservices, paid DBs, overseas auth) that you don't know how to maintain
  - **Choose Boring Technology** (Dan McKinley): Pick mature, battle-tested tools with minimal moving parts—ask yourself: *"Who maintains this tomorrow?"*

- **Search GitHub before reinventing the wheel**
  - Someone has already solved your problem—clone or reference well-written repos, but **beware of fake/botted GitHub Stars**
  - **Check the License**: `MIT` is permissive; `GPL` requires open-sourcing derivatives; **no license = All Rights Reserved** (cannot reuse!)
  - **Open-Source Etiquette**: Never use agents to spam low-effort PRs onto open-source maintainers just to farm GitHub contribution graphs

## 3. Git Savepoints & The `AGENTS.md` Rulebook

:::::::::::::: {.columns align=center}
::: {.column width="48%"}
**Git = Video Game Savepoints**

- `Ctrl+Z` cannot undo an agent editing $8$ files at once
- **Commit** = Savepoint before a boss fight (1-second rollback when the agent breaks your app)
- **Branch** = Parallel universe for risky experiments
- **Tip**: You don't need to memorize Git CLI—tell your agent: *"Commit a checkpoint before starting this feature!"*
:::
::: {.column width="52%"}
**`AGENTS.md` = Dorm Duty Roster**

- Automatically injected into context at the start of every session
- **Keep it under 50 lines** (long essays dilute attention!):
  1. **Signposts**: *"Read `DECISIONS.md` before coding; use `bun`."*
  2. **Hard Redlines**: *"Ask confirmation & make a Git commit after each feature. Never touch files outside this repo."*
:::
::::::::::::::

## 4. "Prove It!" — Verify, Don't Click

- **Why "It's done!" is often a lie**: Without verification, agents happily store data in fake in-memory arrays that vanish on refresh
- **LLMs have RL-trained muscle memory for tests**: Give an agent a red-to-green test command, and it will debug its own code

\footnotesize

<!--prettier-ignore-->
| Ban These "Garbage Tests" | Demand Real Behavioral Verification |
| :---------------------------------------- | :------------------------------------------------ |
| **Mocking everything**: testing a fake DB while the real DB is broken | **Real user journeys**: save $\rightarrow$ reload $\rightarrow$ verify it persists |
| **Tautology tests**: copying buggy output into `expect()` for $100\%$ green | **Headless browser (`Playwright`)**: click the real UI & check console errors |
| **Implementation nitpicking**: asserting internal variable names | **Anti-regression**: fixed the same bug twice? Add a check to block it forever |

\normalsize

## 5. De-slopping: Wash Away the "AI Slop" UI

- **Why AI websites look the same**: The "most probable token" is the average of all web templates—**AI Slop**!

\small

- **4 Symptoms of AI Slop**:
  1. **Purple-blue gradients & rocket emojis** on every button
  2. **Nested cards** inside cards, heavy shadows, tiny text area
  3. **Random colored left-borders** that make text look like alerts
  4. **Redundant pill badges & helper text** for a simple input box
- **The 2-Step "De-slop" Rescue Prompt**:

  \footnotesize

  > *"1. **Ruthless Subtraction**: Remove decorative pill badges, redundant subtitles, gradients, and nested card borders—group elements with clean whitespace instead.*\
  > *2. **Icon & Typography Discipline**: Replace all emojis with clean `Lucide` SVG icons; use at most 3 font sizes and a high-contrast neutral palette."*

\normalsize

# Harness, Environment & Safety

## Choosing a harness & Clean environment

:::::::::::::: {.columns align=center}
::: {.column width="46%"}
\begin{figure}[htbp]
\centering
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  layer/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=5.6cm,minimum height=0.88cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.2mm,width=1.7mm]}}]
  \node[layer,fill=white,draw=muted!65] (l1) at (0,3.6) {\textbf{Host OS}: Windows + WSL / macOS};
  \node[layer,fill=theme!8] (l2) at (0,2.4) {\textbf{User-space CLI}: \texttt{\textasciitilde/.opencode} \& \texttt{\textasciitilde/.bun}};
  \node[layer,fill=theme!14] (l3) at (0,1.2) {\textbf{Project Workspace}: Dedicated Git directory};
  \node[layer,fill=theme!20] (l4) at (0,0.0) {\textbf{OpenCode}: Project dir \& SJTU Model API};
  \draw[flow] (l1.south) -- (l2.north);
  \draw[flow] (l2.south) -- (l3.north);
  \draw[flow] (l3.south) -- (l4.north);
\end{tikzpicture}
}%
\end{figure}
:::
::: {.column width="54%"}
- **Why CLI over flashy GUI wrappers?**
  - Working directory, shell commands, git diffs, and token usage are $100\%$ transparent
- **Zero root pollution**
  - One-line installers place binaries in user space (`~/.opencode`, `~/.bun`) without `sudo`
- **Scoped workspace**
  - Always launch your agent inside a dedicated project folder (`~/focus-board`), **never** in your home or root directory!
:::
::::::::::::::

## Permission approval, Secrets & Mindset

\footnotesize

<!--prettier-ignore-->
| Usually safe to approve | Confirm carefully (High Risk!) |
| :----------------------------- | :------------------------------------ |
| Reading/editing files inside project | Deleting/modifying files outside project (`rm -rf`) |
| Running local builds & unit tests | Reading/exposing `.env` API keys or SSH credentials |
| Creating local Git commits & branches | `git push --force` or uploading data to external URLs |

\small

- **Never hardcode API keys into frontend code**: Keep secrets in `.env` and add it to `.gitignore` on Day 1
- **Beware of Sycophancy**: Models are trained to agree—even with a flawed architecture
  - **Counter-prompt**: *"Assume my approach is wrong. Give me the 3 strongest arguments against it."*
- **The Ultimate Rule**: *Can I afford the consequence if the AI is wrong?* **You own the final decision.**

\normalsize

# Hands-on Practice

## Connecting your agent harness (SJTU API)

:::::::::::::: {.columns align=center}
::: {.column width="45%"}
\begin{figure}[htbp]
\centering
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  stepnode/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=5.6cm,minimum height=0.82cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.2mm,width=1.7mm]}}]
  \node[stepnode] (s1) at (0,3.3) {\textbf{1. Install CLI}: \texttt{opencode} + \texttt{bun}};
  \node[stepnode] (s2) at (0,2.2) {\textbf{2. Configure}: SJTU API endpoint};
  \node[stepnode] (s3) at (0,1.1) {\textbf{3. Authenticate}: Paste API Key};
  \node[stepnode] (s4) at (0,0.0) {\textbf{4. Launch}: Verify tool loop in project dir};
  \draw[flow] (s1.south) -- (s2.north);
  \draw[flow] (s2.south) -- (s3.north);
  \draw[flow] (s3.south) -- (s4.north);
\end{tikzpicture}
}%
\end{figure}
:::
::: {.column width="55%"}
**Three items to verify during setup**

- **Model ID**: `deepseek-reasoner`
- **API Base URL**:
  <https://models.sjtu.edu.cn/api/v1>
- **API Key**: Stored via `opencode auth login` (never inside your project repo!)

\vspace{4pt}

**Today's Build Target**:
Instead of a static blog, we will vibe-code an interactive **"SJTU Focus & DDL Board"** (Pomodoro timer + course deadline countdown + persistent local storage).
:::
::::::::::::::

## Environment setup: One-line install & Config

Run in WSL (Ubuntu) or macOS terminal:

\scriptsize

```bash
# 1. Install basic utilities, OpenCode CLI, and Bun runtime
sudo apt update && sudo apt install -y curl git unzip
curl -fsSL https://opencode.ai/v2/install | bash
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc   # (use 'source ~/.zshrc' on macOS)

# 2. Write SJTU provider config to ~/.config/opencode/opencode.jsonc
mkdir -p ~/.config/opencode
cat << 'EOF' > ~/.config/opencode/opencode.jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "sjtu": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "SJTU Models",
      "options": { "baseURL": "https://models.sjtu.edu.cn/api/v1" },
      "models": { "deepseek-reasoner": { "name": "DeepSeek R1" } }
    }
  }
}
EOF
```

\normalsize

## Practice — Exercise 1: Launch & "Grill Me"

**Step 1: Authenticate & Initialize Git Workspace**

\scriptsize

```bash
opencode auth login   # Other -> provider id 'sjtu' -> paste key
mkdir -p ~/focus-board && cd ~/focus-board && git init
opencode
```

\normalsize

**Step 2: Send the `Grill Me` Prompt (no code yet!)**

\footnotesize

> I want to build a personal **"SJTU Focus & DDL Board"** web app for my freshman courses (combining a Pomodoro focus timer and a course deadline countdown list).
>
> **Do NOT write any code yet.** Ask me **3 concise questions** to clarify my MVP features, how data should be saved (no backend server), and visual style.
>
> Once I answer, generate:
>
> 1. `DECISIONS.md` recording our agreed MVP scope and boring tech stack;
> 2. `AGENTS.md` (<30 lines) requiring a Git commit after each working step and banning changes outside this directory.

\normalsize

## Practice — Exercise 2: Build, Prove & De-slop!

After `DECISIONS.md` and `AGENTS.md` are created, run this 2-stage loop:

**Stage A: Build + "Prove It" Verification**

\scriptsize

> Read `DECISIONS.md` and `AGENTS.md`. Scaffold and build the MVP web app using `bun` (HTML/CSS/JS or Vite).
>
> **Prove It Requirement**: Ensure all tasks and Pomodoro stats persist in `localStorage` across page reloads, plus an "Export/Import JSON" backup button. Write and run an automated verification script (or unit test) confirming that adding, completing, and reloading tasks works $100\%$. Commit to Git when all checks pass and give me the local preview URL.

\normalsize

**Stage B: Wash Away the "AI Slop" (`De-slop`)**

\scriptsize

> Inspect the current UI and **de-slop** it:
>
> 1. Remove any purple/blue neon gradients, nested card borders, and redundant helper text.
> 2. Replace all emojis (rockets, flames, sparkles) with clean SVG icons (e.g., `Lucide`).
> 3. Restyle into a crisp, high-contrast minimalist dashboard (Linear/Notion vibe) with clear urgency tags (e.g., `< 24h` in subtle red). Run the build and commit to Git.

\normalsize

## Bonus: Why can't my roommate open `localhost`?

\begin{figure}[htbp]
\centering
\resizebox{0.90\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  lbox/.style={draw=muted!80,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.8cm,minimum height=1.3cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  cbox/.style={draw=theme,fill=theme!14,line width=1.5pt,rounded corners=3pt,minimum width=4.2cm,minimum height=1.3cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  rbox/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.3cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=theme,line width=1.3pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[lbox] (loc) at (0,0) {\textbf{Your Laptop}\\\texttt{localhost:5173}\\(Only visible to you)};
  \node[cbox] (host) at (5.5,0) {\textbf{Static Web Hosting}\\GitHub Pages / Cloudflare\\ Vercel / EdgeOne};
  \node[rbox] (pub) at (10.9,0) {\textbf{Public URL}\\\texttt{ddl.yourname.dev}\\(Share with dorm!)};
  \draw[flow] (loc.east) -- node[above,font=\ttfamily\scriptsize,text=muted] {git push} (host.west);
  \draw[flow] (host.east) -- (pub.west);
\end{tikzpicture}
}%
\end{figure}

- **`localhost` ($127.0.0.1$)** means *"this exact computer"*—sending a `localhost` link to your WeChat group will never work!
- **Frontend-only apps are free to deploy**: Since our Focus Board stores data in the browser's `localStorage`, you can deploy the `dist/` folder to **GitHub Pages** or **Cloudflare Pages** in 1 minute for free
- **When do you need a Backend / Database?** Only when multiple users need to share live state (e.g., a dorm shared expense splitter or band rehearsal check-in)

# Going Further

## Takeaway: Tune Your "Learning Rate" ($\eta$)

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=muted!75,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.7cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{9.5}{12}\selectfont,text=ink},
  best/.style={draw=theme,fill=theme!15,line width=1.6pt,rounded corners=3pt,minimum width=4.2cm,minimum height=1.7cm,align=center,font=\sffamily\fontsize{10}{12.5}\selectfont,text=ink}]
  \node[box] (low) at (0,0) {\textbf{Learning Rate Too Low}\\($\eta \rightarrow 0$)\\[3pt]``AI changes too fast,\\so I won't learn anything.''};
  \node[best] (opt) at (4.8,0) {\textbf{Optimal Learning Rate}\\[3pt]\textbf{Stay Curious \& Practice}\\Try hands-on $\rightarrow$ Keep what\\works $\rightarrow$ Ignore the hype};
  \node[box] (high) at (9.6,0) {\textbf{Learning Rate Too High}\\($\eta \gg 1$)\\[3pt]Panic over every viral post\\(MCP! Skills!) \& burn out};
\end{tikzpicture}
}%
\end{figure}

- **Writing code is getting cheaper; verifying and understanding it is the new bottleneck** (Terence Tao, 2026)
- Don't base your security on *"what machines can't do yet"*—treat AI as an instrument to build things that make your life better
- **Homework**: Think of **one annoying, repetitive task** in your daily life this week, and build your first "Folk Magic" script with your agent!

## References: Concepts, Tools & Infrastructure

\small

<!--prettier-ignore-->
| Topic | Resource |
| :------------------- | :-------------------------------------------------- |
| **Agent Guide** | [Xflops HPC Start Guide — AI Agent](https://xflops.sjtu.edu.cn/hpc-start-guide/primer/ai-agent/) · [ReAct Paper](https://arxiv.org/abs/2210.03629) |
| **Prompt & Cache** | [OpenAI Tokenizer](https://platform.openai.com/tokenizer) · [Prompt Caching Guide](https://platform.openai.com/docs/guides/prompt-caching) |
| **Models & Effort** | [OpenRouter Rankings](https://openrouter.ai/rankings) · [Controlling Reasoning Effort](https://magazine.sebastianraschka.com/p/controlling-reasoning-effort-in-llms) |
| **Vibe Playbook** | [Choose Boring Technology](https://boringtechnology.club/) · [Matt Pocock's Grill-Me Skill](https://github.com/mattpocock) |
| **OpenCode & Bun** | [OpenCode Docs](https://opencode.ai/docs/) · [GitHub Repo](https://github.com/anomalyco/opencode) · [Bun Runtime](https://bun.sh/) |
| **Git & Safety** | [Pro Git Book](https://git-scm.com/book/en/v2) · [Playwright Testing](https://playwright.dev/) · [bubblewrap](https://github.com/containers/bubblewrap) |

\normalsize

## \quad

\center

\huge

**Thank you!**

\vspace{8pt}
\large
*Stay Curious. Build Your Own Folk Magic.*