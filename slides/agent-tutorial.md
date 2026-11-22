---
title:
  - Vibe Coding Workshop
subtitle:
  - "Agent Development: Models, Tools, Context & Practice"
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
  \usetikzlibrary{arrows.meta,positioning,calc,fit,shapes.symbols}
  \setbeamertemplate{headline}{}
  \definecolor{ink}{HTML}{000000}
  \definecolor{muted}{HTML}{666666}
  \definecolor{theme}{HTML}{3333B2}
  \definecolor{bad}{HTML}{B23333}
  \definecolor{good}{HTML}{2E7D32}
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

## Why agents?

\begin{center}
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  who/.style={draw=muted!70,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=1.9cm,minimum height=0.95cm,align=center,font=\sffamily\bfseries\fontsize{11}{13}\selectfont,text=ink},
  bot/.style={draw=muted!70,fill=muted!8,line width=1.2pt,rounded corners=3pt,minimum width=2.1cm,minimum height=0.95cm,align=center,font=\sffamily\bfseries\fontsize{11}{13}\selectfont,text=ink},
  agt/.style={draw=theme,fill=theme!15,line width=1.5pt,rounded corners=3pt,minimum width=2.1cm,minimum height=0.95cm,align=center,font=\sffamily\bfseries\fontsize{11}{13}\selectfont,text=ink},
  lbl/.style={font=\ttfamily\fontsize{9}{11}\selectfont,text=muted},
  capt/.style={font=\sffamily\fontsize{11}{13}\selectfont,text=ink,align=center},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.4mm,width=1.8mm]}},
  tflow/.style={draw=theme,line width=1.3pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \useasboundingbox (-0.45,-1.6) rectangle (13.15,1.5);
  % chatbot panel
  \draw[draw=muted!40,line width=0.8pt,rounded corners=5pt] (-0.4,-1.55) rectangle (5.6,1.45);
  \node[who] (u1) at (0.85,0) {You};
  \node[bot] (c1) at (4.25,0) {Chatbot};
  \draw[flow] (u1.north east) to[bend left=28] node[above,lbl] {question, errors} (c1.north west);
  \draw[flow] (c1.south west) to[bend left=28] node[below,lbl] {code to copy} (u1.south east);
  \node[capt] at (2.6,-1.25) {\textbf{You} are the loop};
  % agent panel
  \draw[draw=theme!45,line width=0.8pt,rounded corners=5pt] (6.2,-1.55) rectangle (13.1,1.45);
  \node[who] (u2) at (7.25,0) {You};
  \node[agt] (a2) at (9.85,0) {Agent};
  \draw[flow] (u2.north east) to[bend left=28] node[above,lbl] {goal} (a2.north west);
  \draw[flow] (a2.south west) to[bend left=28] node[below,lbl] {result} (u2.south east);
  \draw[tflow] (a2.north east) to[out=40,in=-40,looseness=6] node[right,lbl,text=theme,align=left,xshift=-2pt] {edit\\run\\fix} (a2.south east);
  \node[capt] at (9.65,-1.25) {\textbf{It} runs the loop; you review};
\end{tikzpicture}
}%
\end{center}

\vspace{2pt}

:::::::::::::: {.columns align=center}
::: {.column width="52%"}
\small
**What agents do well**

- Scaffold and preview a website
- Find bugs and write tests
- Batch-process data and plot it
- Explain and extend a new repo

\normalsize
:::
::: {.column width="44%"}
\includegraphics[width=\textwidth]{slides/assets/agent-tutorial/vibecoding.jpeg}
:::
::::::::::::::

## Agent = Model + Harness + Tools

\begin{figure}[htbp]
\centering
\resizebox{0.80\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=3.8cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  agentbox/.style={draw=theme,fill=theme!16,line width=1.6pt,rounded corners=3pt,minimum width=4.0cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  sym/.style={font=\sffamily\bfseries\fontsize{18}{20}\selectfont,text=theme}]
  \node[box] (m) at (0,0) {\textbf{Model}\\Decides next step};
  \node[sym] at (2.7,0) {+};
  \node[box] (h) at (5.4,0) {\textbf{Harness + Tools}\\Manages context\\\& runs tools};
  \node[sym] at (8.1,0) {=};
  \node[agentbox] (a) at (10.9,0) {\textbf{Agent}\\Finishes the task\\end-to-end};
\end{tikzpicture}
}%
\end{figure}

\footnotesize

<!--prettier-ignore-->
| Part | What it does | Examples |
| :-------- | :---------------------------------------------- | :------------------------------------ |
| **Model** | Reads context; writes text or a tool call | Claude, GPT, DeepSeek |
| **Harness** | Builds context, runs tools, loops | Claude Code, Codex, DSH |
| **Tools** | Functions offered to the model | Files, shell, Git, web search |

\normalsize

- **The model only asks** for a tool call; **the harness executes** it
- Same model, different harness $\Rightarrow$ different results; models do best in the harness they were trained for (e.g., Claude + Claude Code)

# How an Agent Works

## How models process information

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=4.4cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  centerbox/.style={draw=theme,fill=theme!15,line width=1.6pt,rounded corners=3pt,minimum width=4.6cm,minimum height=1.6cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.3pt,-{Stealth[length=2.6mm,width=2mm]}}]
  \node[box] (in) at (0,0) {\textbf{Inputs}\\Text, images, code\\\& tool results};
  \node[centerbox] (model) at (6.0,0) {\textbf{Model}\\Predicts the next\\token, one at a time};
  \node[box] (out) at (12.0,0) {\textbf{Outputs}\\Text, images, or\\structured tool calls};
  \draw[flow] (in.east) -- (model.west);
  \draw[flow] (model.east) -- (out.west);
\end{tikzpicture}
}%
\end{figure}

:::::::::::::: {.columns align=center}
::: {.column width="64%"}
\footnotesize

- **Token**: a sub-word chunk (~3/4 of an English word); the unit of pricing and limits
- **Context**: everything sent in one call: instructions, history, files, tool outputs
- **Reasoning**: hidden "thinking" tokens before the answer; effort is adjustable
- **Billing**: input, output & reasoning tokens are priced separately
:::
::: {.column width="34%"}
\begin{center}
\includegraphics[width=\textwidth]{slides/assets/agent-tutorial/ultra-card.png}

{\tiny An effort picker in a chat app\par}
\end{center}
:::
::::::::::::::

\normalsize

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

**The ReAct pattern**: repeat until done

- **Reason**: look at the goal and what happened so far; pick the next action
- **Act**: call a tool to inspect or change the environment
- **Observe**: read the tool's output and feed it into the next step

## Tools

\begin{figure}[htbp]
\centering
\resizebox{0.80\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  mnode/.style={draw=theme,fill=theme!14,line width=1.4pt,rounded corners=3pt,minimum width=3.3cm,minimum height=2.4cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  hnode/.style={draw=theme,fill=workfill,line width=1.4pt,rounded corners=3pt,minimum width=3.5cm,minimum height=2.4cm,align=center,font=\sffamily\fontsize{10}{13}\selectfont,text=ink},
  tnode/.style={draw=muted!75,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.4cm,minimum height=0.72cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[mnode] (m) at (0,0) {\textbf{Model}\\[4pt]Generate text or\\structured tool call};
  \node[hnode] (h) at (4.6,0) {\textbf{Harness}\\[4pt]Verify permissions\\Execute tool\\Return output};
  \node[tnode] (t1) at (9.3,0.9) {Read / Write Files};
  \node[tnode] (t2) at (9.3,0) {Shell / Git};
  \node[tnode] (t3) at (9.3,-0.9) {Browser / API};

  \draw[flow] (m.east) -- (h.west);
  \draw[flow] (h.east) -- ++(0.55,0) |- (t1.west);
  \draw[flow] (h.east) -- (t2.west);
  \draw[flow] (h.east) -- ++(0.55,0) |- (t3.west);
\end{tikzpicture}
}%
\end{figure}

\footnotesize

<!--prettier-ignore-->
| Kind | What it is | When to use |
| :---------- | :------------------------------------------------------ | :------------------------------ |
| **Built-in** | Files, shell, Git | Day one: all you need |
| **CLI** | Command-line programs: `gh`, `ffmpeg` | Lighter than MCP |
| **MCP** | A USB-like plug for outside apps | When no CLI exists |
| **Subagent** | A child agent with its own fresh context | Big, separable subtasks |

\normalsize

## Context window

\begin{figure}[htbp]
\centering
\resizebox{0.86\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  bar/.style={draw=theme,fill=workfill,line width=1.1pt,rounded corners=2pt,minimum width=11.6cm,minimum height=0.68cm,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  top/.style={draw=theme,fill=theme,line width=1.1pt,rounded corners=2pt,minimum width=11.6cm,minimum height=0.68cm,font=\sffamily\fontsize{10}{12}\selectfont,text=white}]
  \node[anchor=south west,font=\ttfamily\fontsize{10}{12}\selectfont,text=muted] at (-6.1,3.8) {context window (finite)};
  \node[top] (b1) at (0,3.2) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=white] at (-5.5,3.2) {System prompt};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=white] at (5.5,3.2) {Identity, tools, permissions, folder \& date};

  \node[bar,fill=theme!14] (b2) at (0,2.4) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,2.4) {Project rules};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,2.4) {\texttt{AGENTS.md}, repo conventions \& user requirements};

  \node[bar,fill=theme!9] (b3) at (0,1.6) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,1.6) {Chat history};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,1.6) {User messages \& model responses};

  \node[bar,fill=theme!6] (b4) at (0,0.8) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,0.8) {Working evidence};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,0.8) {File contents, command outputs \& error logs};

  \node[bar,fill=white,draw=muted!60] (b5) at (0,0.0) {};
  \node[anchor=west,font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink] at (-5.5,0.0) {On-demand docs};
  \node[anchor=east,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (5.5,0.0) {\texttt{SKILL.md}, documentation \& search results};

  \draw[draw=muted!75,line width=1.1pt,dashed,rounded corners=4pt] (-6.1,-0.55) rectangle (6.1,3.75);
\end{tikzpicture}
}%
\end{figure}

\footnotesize

- **Finite space**: every layer competes for the same window
- **The harness decides** what to load, in what order, and what to summarize when full
- **More is not better**: stale or irrelevant context distracts the model
- **TIP:** One task per session; start a fresh session when you switch tasks

\normalsize

## Stateless APIs & prefix caching

\begin{figure}[htbp]
\centering
\resizebox{0.86\textwidth}{!}{%
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
  \node[font=\sffamily\bfseries\fontsize{9}{11}\selectfont,text=theme] at (2.6,-0.82) {Identical prefix: cache hit};
  \node[font=\sffamily\fontsize{9}{11}\selectfont,text=muted] at (8.6,-0.82) {only this part is new};
\end{tikzpicture}
}%
\end{figure}

\footnotesize

- **Stateless API**: the model remembers nothing; the harness re-sends the whole context every turn
- **Prefix caching**: when a request starts exactly like the last one, the provider reuses that work
- **Payoff**: faster replies and cheaper cached input (often 50--95% off)
- **So**: keep the start stable, and put lasting facts in files instead of chat history

\normalsize

## AGENTS.md: the project's house rules

:::::::::::::: {.columns align=center}
::: {.column width="52%"}
\scriptsize

```markdown
# AGENTS.md

Personal blog: Astro + AstroPaper

## Before you start
- Read docs/decisions.md first

## Rules
- Run npm run build before "done"
- Ask me after each feature; commit
- No big change without a commit
- Never edit dist/ or node_modules/
```

\normalsize
:::
::: {.column width="46%"}
\footnotesize

- Named exactly `AGENTS.md`, in the repo root; added to **every request**
- **Start with 2--3 lines**: where to look, and lines not to cross
- **Skip** what the agent can read itself: start scripts, folder layout; details go in `docs/`
- **A reminder, not a memory**: buried in a long session, it gets ignored; repeated mistakes need a **test**
- DSH reads `AGENTS.md` and `CLAUDE.md`; Claude Code reads `CLAUDE.md`
:::
::::::::::::::

# Choosing Your Stack

## Selecting a model: Key dimensions

Compare candidate models against **your** workload:

\vspace{4pt}
\small

<!--prettier-ignore-->
| Dimension | What to check |
| :------------ | :---------------------------------------------------- |
| **Capability** | Tool-call accuracy, instruction following, error recovery |
| **Cost** | Input, output, cached-input & reasoning token prices |
| **Latency** | Time to first token, total task time, rate limits |
| **Deployment** | Cloud API vs. self-hosted open weights |

\normalsize
\vspace{6pt}

- **TIP:** [OpenRouter Rankings](https://openrouter.ai/rankings) show what people actually use

## Selecting a model: Candidates

\small

- **Commercial APIs**: GPT, Claude, Gemini; usually the strongest, pay per token
- **Open weights**: DeepSeek, GLM, Kimi, Qwen; cheaper, self-hostable
  - Check the license, and whether the full model or only a distilled one is released
- **Sizes**: flagship vs. flash/mini; trade depth for speed and cost

\normalsize
\vspace{10pt}

\begin{center}
\includegraphics[width=0.9\textwidth]{slides/assets/agent-tutorial/model-brand-icons.png}
\end{center}

## Selecting a model: Benchmarks by use case

Pick the leaderboard that matches your workload:

\vspace{4pt}
\footnotesize

<!--prettier-ignore-->
| Use case | Benchmark | Measures |
| :---------------------- | :------------------------------------ | :------------------------- |
| **Coding & terminal** | [Terminal-Bench 4.1](https://www.tbench.ai/?version=4.1) | Multi-step terminal tasks |
| **Scientific research** | [Terminal-Bench-Science](https://www.vals.ai/benchmarks/terminal-bench-science) | Real lab workflows |
| **CS & AI research** | [FrontierCS 2](https://github.com/FrontierCS/FrontierCS-2) | Beating papers' own code |
| **Everyday office** | [WorkBuddy Bench](https://github.com/Tencent/workbuddy-bench) (Office) | Exact xlsx/pdf/docx output |
| **Overall** | [AA Index v5](https://artificialanalysis.ai/articles/artificial-analysis-intelligence-index-v5) · [llm2014](https://llm2014.github.io/llm_benchmark/) | Composite, mostly private |

\normalsize

## Selecting a model: Reading benchmarks wisely

\begin{center}
\includegraphics[width=\textwidth]{slides/assets/agent-tutorial/aa-intelligence-index-2026-11-13.png}

{\tiny AA Intelligence Index v5.0.1, 13 Nov 2026 (checkered = no public API); rankings shift every few weeks\par}
\end{center}

\vspace{-4pt}
\footnotesize

- **Harness matters**: scores shift by harness; compare within one board
- **Prefer private test sets**: AA v5 is ~60% private; llm2014 is fully private
- **TIP:** Leaderboards build the shortlist; **your own tasks** make the final pick

\normalsize

## Reasoning effort

\begin{center}
\includegraphics[width=\textwidth]{slides/assets/agent-tutorial/aa-intelligence-vs-cost-2026-11-13.png}

{\tiny AA Intelligence Index v5.0.1 vs. cost to run the full index (USD, log scale), 13 Nov 2026\par}
\end{center}

\vspace{-4pt}
\footnotesize

- **Reasoning effort**: more thinking means more tokens, latency & cost
- **Diminishing returns**: ~20× the cost buys only ~10 more points
- **Same model**: Opus 5.5 scores 35 (low) vs. 58 (max) at ~10× the cost
- **TIP:** Default to medium/high; save max for hard, long-horizon tasks

\normalsize

## What a task really costs

\begin{center}
\resizebox{0.9\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  term/.style={draw=theme,fill=workfill,line width=1.2pt,rounded corners=3pt,minimum width=3.4cm,minimum height=1.0cm,align=center,font=\sffamily\bfseries\fontsize{12}{14}\selectfont,text=ink},
  op/.style={font=\sffamily\bfseries\fontsize{18}{18}\selectfont,text=muted},
  note/.style={anchor=north,text width=3.4cm,align=center,font=\sffamily\fontsize{9}{11}\selectfont,text=muted}]
  \node[term,fill=theme,text=white] (c) at (0,0) {Cost per task};
  \node[op] at (2.25,0) {$=$};
  \node[term] (p) at (4.5,0) {Price per token};
  \node[op] at (6.75,0) {$\times$};
  \node[term] (t) at (9,0) {Tokens per task};
  \node[note] at ([yshift=-4pt]c.south) {what you actually pay};
  \node[note] at ([yshift=-4pt]p.south) {the price list; cache hits are far cheaper};
  \node[note] at ([yshift=-4pt]t.south) {turns $\times$ context re-sent each turn};
\end{tikzpicture}
}%
\end{center}

\vspace{2pt}
\footnotesize

- **Price $\neq$ bill**: Opus 5.5 is 2× GPT-6.1 Sol per token, about 6× per task\textsuperscript{*}
- **Vague prompts multiply turns**: each retry re-sends the whole history
- **Cache hits are cheap**: Opus 5.5 input is \$0.20/M cached vs. \$4/M fresh
- **Right the first time**: a strong model can end up the cheapest
- **TIP:** Compare **\$ per task** on your own work; [mypriors](https://mypriors.com) shows it per model

\begin{flushright}
\tiny\textcolor{muted}{* Cost per task on the Artificial Analysis Intelligence Index, medium effort, Nov 2026}
\end{flushright}

\normalsize

## Pay-as-you-go vs. subscription

\footnotesize

<!--prettier-ignore-->
| | Pay-as-you-go API | Monthly plan |
| :---------- | :------------------------------ | :------------------------------ |
| **Best for** | Light use, small projects | Daily use, long sessions |
| **You pay** | Per token, no ceiling | A flat fee, with usage caps |
| **Watch for** | Long chats add up | 5-hour & weekly limits |

**Plans change often**

<!--prettier-ignore-->
| When | Plan | What happened |
| :-------- | :------------- | :------------------------------------------------ |
| 2025-06 | Cursor Pro | Switched to usage billing; refunds after backlash |
| 2026-09 | ChatGPT Pro | Codex limits to be halved; cancelled on 10-29 |
| 2026-12 | Gemini 4 API | Launch price ends; rates double |

\vspace{2pt}

- **"Worth \$10k a month"** assumes 24/7 use; coursework won't come close
- **Pay monthly, never yearly**: terms change faster than a year
- **This workshop**: DeepSeek API, pay-as-you-go

\normalsize

## Third-party providers & relays

:::::::::::::: {.columns align=top}
::: {.column width="47%"}
\footnotesize
**Same model, different host**

\scriptsize

- **Quantized**: weaker at multi-step
- **Cut context**: Qwen 1M $\to$ 262k
- **Peak hours**: slow, 1--2 requests
- **Fine print**: 5-hour & weekly caps
:::
::: {.column width="51%"}
\footnotesize
**Unknown API relays: just don't**

\vspace{2pt}
\begin{tikzpicture}[x=0.8cm,y=1cm,line cap=round,line join=round,
  box/.style={draw=theme,fill=workfill,line width=1pt,rounded corners=3pt,minimum width=1.4cm,minimum height=0.55cm,font=\sffamily\fontsize{7}{9}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1pt,-{Stealth[length=1.8mm,width=1.4mm]}}]
  \node[box] (a) at (0,0) {Your agent};
  \node[box,draw=muted!70,fill=white] (r) at (2.45,0) {Relay};
  \node[box] (m) at (4.9,0) {Model};
  \draw[flow] (a) -- (r); \draw[flow] (r) -- (m);
  \node[anchor=north,font=\sffamily\fontsize{7}{9}\selectfont,text=muted,align=center] at ([yshift=-2pt]r.south) {reads everything,\\can rewrite replies};
\end{tikzpicture}

\scriptsize

- Sees every prompt, file & **API key**
- Can rewrite your agent's commands
- **9 of 428** tested injected code
- **17 of 428** used leaked keys
:::
::::::::::::::

\vspace{4pt}
\footnotesize

- **TIP:** Official API or a host you trust; "80% off official" is a red flag

\begin{flushright}
\tiny\textcolor{muted}{Relay data: Liu et al., \emph{Your Agent Is Mine}, arXiv:2604.08407 (2026)}
\end{flushright}

\normalsize

## Choosing a harness

\footnotesize

<!--prettier-ignore-->
| Criterion | Prefer | Watch out for |
| :-------- | :------------------------------------------- | :------------------------------- |
| **Transparency** | Shows every command, edit & error | Hidden commands & edits |
| **Model fit** | The model's native harness | Mismatched tool-call formats |
| **Scope** | **File, Shell & Git** first | Token-hungry prompts |
| **Control** | Open source, auditable permissions | Dozens of plugins on day one |

\normalsize
\vspace{6pt}
\small

- **Terminal**: Claude Code · Codex CLI · Gemini CLI
- **Desktop app**: **DeepSeek Harness (DSH)**, used in this workshop: open source, native to DeepSeek models, no terminal needed
- DSH is a **developer preview**: expect breaking changes and keep Git backups
- **TIP:** Start with **one harness + one strong model**. Switching later? Let the agent migrate your setup.

\normalsize

# Working with Agents

## Setting up DSH Desktop

:::::::::::::: {.columns align=center}
::: {.column width="36%"}
\begin{figure}[htbp]
\centering
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  lab/.style={anchor=north west,align=left,font=\sffamily\fontsize{10}{12}\selectfont,text=ink}]
  \draw[draw=muted!65,fill=white,line width=1.2pt,rounded corners=4pt] (0,0) rectangle (5.6,3.9);
  \node[lab] at (0.15,3.8) {\textbf{Your computer}};
  \draw[draw=theme,fill=theme!8,line width=1.3pt,rounded corners=4pt] (0.35,0.3) rectangle (5.25,3.1);
  \node[lab] at (0.5,3.0) {\textbf{Project folder} (Git repo)\\{\fontsize{9}{11}\selectfont\texttt{my-site/}}};
  \node[draw=theme,fill=theme!25,line width=1.3pt,rounded corners=3pt,minimum width=3.8cm,minimum height=1.0cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink] at (2.8,1.1) {\textbf{DSH workspace}\\{\fontsize{8.5}{10}\selectfont agent edits stay here}};
\end{tikzpicture}
}%
\end{figure}
:::
::: {.column width="62%"}
\footnotesize

1. **Download** the app from [deepseek.com/en/harness](https://www.deepseek.com/en/harness)\
   \textcolor{muted}{\scriptsize macOS (Apple silicon) · Windows (64-bit)}
2. **Settings $\to$ Models**: paste your API key\
   \textcolor{muted}{\scriptsize in the app only, never in a project file}
3. **Choose workspace**: your project folder\
   \textcolor{muted}{\scriptsize one folder per project, tracked with Git}

\vspace{6pt}
\scriptsize

- **Intel Mac or Linux?** Run `npx @deepseek-ai/dsh web`
- **Official site only**: look-alike "DSH Desktop" sites exist

\normalsize
:::
::::::::::::::

## Permission approval & Git safety

\footnotesize

<!--prettier-ignore-->
| Usually safe to approve | Read carefully before approving |
| :----------------------------- | :----------------------------------- |
| Reading files inside the project | Installing or removing system software |
| Searching code and viewing logs | Editing files outside the project |
| Creating or editing project files | Uploading data or logging into accounts |
| Running local builds and tests | Touching API keys, passwords, or `.env` |

\normalsize
\vspace{4pt}
\footnotesize

- **Git is your undo button**: `git commit` before a big task, `git diff` to review, `git restore .` to roll back
- **Never commit secrets**: keep API keys out of the repo (use `.env` + `.gitignore`)
- **Approval prompts are not a sandbox**: unattended runs need Docker, a VM, or `bubblewrap`

\normalsize

## Giving a good task

\begin{center}
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  head/.style={anchor=south west,inner sep=1pt,font=\sffamily\bfseries\fontsize{11}{13}\selectfont},
  num/.style={circle,fill=theme,text=white,inner sep=0pt,minimum size=0.38cm,font=\sffamily\bfseries\fontsize{8}{8}\selectfont}]
  \node[draw=muted!50,line width=1.1pt,rounded corners=3pt,text width=3.0cm,minimum height=3.3cm,align=center,font=\sffamily\fontsize{11}{14}\selectfont,text=muted] (v) at (0,0) {``Make my website better.''\\[10pt]{\fontsize{9}{11}\selectfont No goal, no files,\\no way to check}};
  \node[head,text=muted] at ([yshift=3pt]v.north west) {Vague};
  \node[draw=theme,fill=workfill,line width=1.2pt,rounded corners=3pt,text width=7.9cm,minimum height=3.3cm,align=left,font=\sffamily\fontsize{12}{16}\selectfont,text=ink,anchor=west,execute at begin node={\hyphenpenalty=10000\relax}] (sp) at (2.2,0) {``Add a Projects section\textsuperscript{\textcolor{theme}{\textbf{1}}} to \texttt{src/pages/about.md} listing my three GitHub repos\textsuperscript{\textcolor{theme}{\textbf{2}}}. Match the existing style; don't touch other pages\textsuperscript{\textcolor{theme}{\textbf{3}}}. Run \texttt{npm run build}, fix any \mbox{errors}, and show me the output\textsuperscript{\textcolor{theme}{\textbf{4}}}.''};
  \node[head,text=theme] at ([yshift=3pt]sp.north west) {Specific};
  \node[anchor=north west,inner sep=1pt,font=\sffamily\fontsize{9.5}{11}\selectfont,text=ink] at ([yshift=-6pt]sp.south west) {\textcolor{theme}{\textbf{1}} Goal \quad \textcolor{theme}{\textbf{2}} Context \quad \textcolor{theme}{\textbf{3}} Constraints \quad \textcolor{theme}{\textbf{4}} How to verify \quad\textcolor{muted}{(every task needs all four)}};
\end{tikzpicture}
}%
\end{center}

\vspace{2pt}
\footnotesize

- **Not sure what you want yet?** Ask it to *grill you*: it asks questions until the plan is clear
- **Bigger change?** Ask for a **plan first** and approve it before any edits

\begin{figure}[htbp]
\centering
\resizebox{0.92\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  st/.style={draw=theme,fill=workfill,line width=1.2pt,rounded corners=3pt,minimum width=2.5cm,minimum height=0.8cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.2mm,width=1.7mm]}}]
  \node[st] (a) at (0,0) {\textbf{Plan}};
  \node[st] (b) at (3.2,0) {\textbf{Implement}};
  \node[st] (c) at (6.4,0) {\textbf{Prove it}\\[-2pt]{\fontsize{8}{9}\selectfont tests + screenshot}};
  \node[st] (d) at (9.6,0) {\textbf{Review diff}};
  \node[st,fill=theme!18] (e) at (12.8,0) {\textbf{Commit}};
  \draw[flow] (a) -- (b); \draw[flow] (b) -- (c); \draw[flow] (c) -- (d); \draw[flow] (d) -- (e);
  \draw[flow] (c.south) -- ++(0,-0.4) -| node[pos=0.25,below,font=\ttfamily\fontsize{8}{10}\selectfont,text=muted] {fails? fix \& retry} (b.south);
\end{tikzpicture}
}%
\end{figure}

\normalsize

## Prove it: evidence, not "done"

:::::::::::::: {.columns align=top}
::: {.column width="47%"}
\footnotesize
**Ask for a handoff like this**

\vspace{2pt}
\begin{tikzpicture}
\node[draw=theme!60,fill=workfill,line width=0.8pt,rounded corners=3pt,inner sep=5pt,align=left,font=\ttfamily\scriptsize,text=ink] {%
\textbf{Did:}\ \ \ \ \ added Projects list\\
\textbf{Tests:}\ \ \ 12 passed, 0 failed\\
\textbf{Shot:}\ \ \ \ shots/projects.png\\
\textbf{Skipped:} deploy (localhost only)};
\end{tikzpicture}

\footnotesize

- No test output, no screenshot: **not done**
- Visible change? Have it open the page in a real browser and take a screenshot
- **Skipped** is where bugs hide: `localhost` works only on your machine

\normalsize
:::
::: {.column width="51%"}
\footnotesize
**Same mistake twice? Block it, strongest first**

\begin{center}
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  rung/.style={draw=theme,line width=1.1pt,rounded corners=3pt,minimum height=0.92cm,align=left,text width=7.2cm,font=\sffamily\fontsize{10}{12}\selectfont,text=ink}]
  \node[rung,fill=theme!22] at (0,3.3) {\textbf{1. Make it impossible}\\one place per rule; delete old code it copies};
  \node[rung,fill=theme!14] at (0,2.2) {\textbf{2. Make it fail loudly}\\a test or lint that says what to do instead};
  \node[rung,fill=theme!7] at (0,1.1) {\textbf{3. Make it visible}\\a screenshot for a human to judge};
  \node[rung,fill=white,draw=muted!60] at (0,0) {\textbf{4. Write it down}\\a line in \texttt{AGENTS.md}; easy to skip};
\end{tikzpicture}
}%
\end{center}

\scriptsize
**Check the check**: put the bug back; it must fail.
\normalsize
:::
::::::::::::::

\begin{flushright}
\tiny\textcolor{muted}{Adapted from the \texttt{prove-it} skill in nagi-studio/skills}
\end{flushright}

## From `localhost` to a real URL

\begin{figure}[htbp]
\centering
\resizebox{0.86\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  lbox/.style={draw=muted!80,fill=white,line width=1.2pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  cbox/.style={draw=theme,fill=theme!14,line width=1.3pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  rbox/.style={draw=theme,fill=workfill,line width=1.3pt,rounded corners=3pt,minimum width=3.6cm,minimum height=1.2cm,align=center,font=\sffamily\fontsize{10}{12}\selectfont,text=ink},
  flow/.style={draw=theme,line width=1.3pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[lbox] (loc) at (0,0) {\textbf{Your laptop}\\\texttt{localhost:4321}};
  \node[cbox] (host) at (5.2,0) {\textbf{Static hosting}\\builds \texttt{dist/}};
  \node[rbox] (pub) at (10.4,0) {\textbf{Public URL}\\opens on any phone};
  \draw[flow] (loc.east) -- node[above,font=\ttfamily\scriptsize,text=muted] {git push} (host.west);
  \draw[flow] (host.east) -- (pub.west);
\end{tikzpicture}
}%
\end{figure}

\footnotesize

<!--prettier-ignore-->
| Your site | Host on | You maintain |
| :-------------------- | :-------------------------- | :--------------- |
| **Pages only** (blog) | GitHub / Cloudflare Pages | Almost nothing |
| **Shared data** | Serverless + database | Env vars, data |
| **Anything** | Your own server | Updates, backups |

\normalsize
\vspace{4pt}
\footnotesize

- **You do**: sign-up, ID check, payment; never hand the agent your password
- **Secrets** go in the platform's env vars, never in page code anyone can read
- **Test like a user**: open it on a friend's phone; data must survive a refresh

\normalsize

## Why long sessions get dumber

\begin{figure}[htbp]
\centering
\resizebox{0.86\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  blk/.style={draw=theme,line width=1pt,rounded corners=2pt,minimum width=4.6cm,font=\sffamily\fontsize{9}{11}\selectfont,align=center},
  sys/.style={blk,fill=theme,text=white,minimum height=0.5cm},
  rul/.style={blk,fill=theme!14,text=ink,minimum height=0.5cm},
  task/.style={blk,fill=workfill,text=ink,font=\sffamily\bfseries\fontsize{10}{12}\selectfont},
  junk/.style={blk,draw=muted!70,fill=muted!15,text=muted,minimum height=0.5cm},
  ttl/.style={font=\sffamily\bfseries\fontsize{10}{12}\selectfont,text=ink}]
  % fresh session
  \node[ttl] at (0,4.25) {Fresh session};
  \node[sys] at (0,3.7) {system prompt};
  \node[rul] at (0,3.15) {\texttt{AGENTS.md}};
  \node[task,minimum height=1.6cm] at (0,2.0) {your task};
  \node[font=\sffamily\fontsize{9}{11}\selectfont,text=muted] at (0,0.55) {room to think};
  \draw[draw=muted!75,line width=1pt,dashed,rounded corners=4pt] (-2.5,0.0) rectangle (2.5,4.0);
  % long session
  \node[ttl] at (6.6,4.25) {Long session};
  \node[sys] at (6.6,3.7) {system prompt};
  \node[rul] at (6.6,3.15) {\texttt{AGENTS.md}};
  \node[junk] at (6.6,2.6) {old chat \& abandoned plans};
  \node[junk] at (6.6,2.05) {stale drafts \& dead code};
  \node[junk] at (6.6,1.5) {3,000-line file dumps};
  \node[junk] at (6.6,0.95) {unused MCPs \& skills};
  \node[task,minimum height=0.42cm,font=\sffamily\bfseries\fontsize{9}{11}\selectfont] at (6.6,0.4) {your task};
  \draw[draw=muted!75,line width=1pt,dashed,rounded corners=4pt] (4.1,0.0) rectangle (9.1,4.0);
  \draw[-{Stealth[length=7pt]},draw=muted,line width=1.2pt] (2.8,2.0) -- (3.8,2.0);
\end{tikzpicture}
}%
\end{figure}

\footnotesize

- **Fits is not seen**: 1M tokens fit, but attention thins as input grows
- **Symptoms**: forgets earlier edits, skips steps, changes the wrong place
- **Not a dumber model, a messier desk**: fix the context, not the prompt

\normalsize

\begin{flushright}
\tiny\textcolor{muted}{Thariq Shihipar (ex-Claude Code team): models start slipping around 300--400k tokens}
\end{flushright}

## Context hygiene: subtract, don't add

\footnotesize

<!--prettier-ignore-->
| Move | Target | Do this |
| :------------ | :-------------------------------- | :-------------------------------------- |
| **Clean** | Dead code, stale drafts | Delete; one place per rule |
| **Delegate** | Reading 30 files or 50 pages | Sub-agent returns one page |
| **Cap files** | 3,000-line files | Commit hook: max 5k tokens (~20 KB) |
| **Slim** | `AGENTS.md`, MCPs, skills | Under 100 lines; enable per project |
| **Reset** | Long chats | `/compact` or `/clear`; read `git log` |

\normalsize
\vspace{6pt}

\footnotesize

- **Search before writing**: have the agent find the existing code first
- **Block, don't remind**: a hook or lint beats a line in `AGENTS.md`
- **Best memory**: current files + clear commits; memory plugins go stale

\normalsize

\begin{flushright}
\tiny\textcolor{muted}{File-size hook after Matt Pocock (skips lockfiles \& generated code) · full checklist: the \texttt{tidy} skill}
\end{flushright}

## Skills, MCP, hooks & plugins: know before you install

\begin{figure}[htbp]
\centering
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  ext/.style={draw=theme,line width=1.2pt,rounded corners=3pt,minimum width=2.55cm,minimum height=1.75cm,text width=2.4cm,align=center,font=\sffamily\fontsize{9}{11}\selectfont,text=ink,execute at begin node={\hyphenpenalty=10000\relax}},
  flow/.style={draw=muted!85,line width=1.2pt,-{Stealth[length=2.4mm,width=1.8mm]}}]
  \node[ext,fill=theme!24] (r) at (0,0) {{\fontsize{11}{13}\selectfont\bfseries\ttfamily AGENTS.md}\\[2pt]House rules\\[2pt]\textcolor{muted}{full text,\\every request}};
  \node[ext,fill=theme!15] (s) at (2.75,0) {{\fontsize{11}{13}\selectfont\bfseries Skill}\\[2pt]Recipe + scripts\\[2pt]\textcolor{muted}{blurb only;\\body when used}};
  \node[ext,fill=theme!9] (m) at (5.5,0) {{\fontsize{11}{13}\selectfont\bfseries MCP}\\[2pt]Plug for apps\\[2pt]\textcolor{muted}{tool list;\\can be large}};
  \node[ext,fill=theme!4] (c) at (8.25,0) {{\fontsize{11}{13}\selectfont\bfseries CLI}\\[2pt]Command to run\\[2pt]\textcolor{muted}{only its\\output}};
  \node[ext,fill=white] (h) at (11.0,0) {{\fontsize{11}{13}\selectfont\bfseries Hook}\\[2pt]Hard gate\\[2pt]\textcolor{muted}{runs outside\\the model}};
  % context-cost axis
  \draw[flow] (-1.3,-1.25) -- (12.3,-1.25);
  \node[anchor=north west,font=\sffamily\fontsize{9}{11}\selectfont,text=muted] at (-1.3,-1.35) {always in context};
  \node[anchor=north east,font=\sffamily\fontsize{9}{11}\selectfont,text=muted] at (12.3,-1.35) {never in context};
  % plugin bracket
  \draw[draw=theme,line width=1.1pt] ([yshift=4pt]s.north west) -- ++(0,0.22) -| ([yshift=4pt]h.north east);
  \node[anchor=south,font=\sffamily\fontsize{9.5}{11}\selectfont,text=ink] at (6.875,1.23) {\textbf{Plugin} = a box of these, one-click install \textcolor{muted}{(DSH: can also swap app parts)}};
\end{tikzpicture}
}%
\end{figure}

\footnotesize

- **Before installing**: is it a recipe, a tool, a gate, or a box?
- **Know the skill you want?** Call it by name: `/prove-it`
- **Same throwaway script again?** Save it as a small CLI
- **Prune every 1--2 weeks**: Claude Code `/doctor`; Codex \& DSH `checkup`

\normalsize

\begin{flushright}
\tiny\textcolor{muted}{\texttt{checkup} (nagi-studio/skills): read-only scan of the last 30 days; you confirm, and it disables reversibly}
\end{flushright}

## Limitations of agents

\footnotesize

<!--prettier-ignore-->
| Failure | What it looks like | Your move |
| :------------------ | :------------------------------------------------ | :------------------------- |
| **Hallucination** | Invents APIs, flags, files, citations | Check docs; run it |
| **Fake "done"** | Says tests pass without running them | Demand evidence |
| **Sycophancy** | *"You're absolutely right!"*, but no real fix | Ask for proof |
| **Vibe slop** | Dead code, duplicate helpers, bloat | Small diffs; review each |
| **AI-isms** | *"It's not X, it's Y"*; stiff prose | Rewrite it yourself |

\normalsize
\vspace{8pt}

**Takeaway: you own the result.**

\small

- Agents don't know your domain: tell them, then review every diff
- Never become a copy-paste relay between the assignment and the agent

\normalsize

## What AI slop looks like

\begin{center}
\setlength{\tabcolsep}{3pt}
\begin{tabular}{ccc}
\includegraphics[height=0.25\textwidth]{slides/assets/agent-tutorial/aislop1.jpeg} &
\includegraphics[height=0.25\textwidth]{slides/assets/agent-tutorial/aislop2.png} &
\includegraphics[height=0.25\textwidth]{slides/assets/agent-tutorial/gitslop.jpg} \\
{\tiny\color{muted} Images} & {\tiny\color{muted} UI} & {\tiny\color{muted} Code} \\
\end{tabular}
\end{center}

\footnotesize

**How to de-slop**

- **Say it once**: cut labels, helper text & decoration that add nothing
- **One clear action**: whitespace over nested cards; accent color for one main button
- **Code too**: smallest diff, no dead code; read before you commit
- **Teach it once**: write each design correction into `DESIGN.md`

\normalsize

## Habits worth stealing: nagi-studio/skills

\begin{center}
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[x=1cm,y=1cm,line cap=round,line join=round,
  chev/.style={draw=theme,line width=1.1pt,fill=workfill,minimum height=1.0cm,minimum width=2.55cm,signal,signal to=east,signal from=west,font=\ttfamily\bfseries\fontsize{11}{13}\selectfont,text=ink},
  chev0/.style={chev,signal from=nowhere},
  desc/.style={anchor=north,text width=2.45cm,align=center,font=\sffamily\fontsize{9}{11}\selectfont,text=ink,execute at begin node={\hyphenpenalty=10000\relax}}]
  \node[chev0] (g) at (0,0) {grill};
  \node[chev] (a) at (2.65,0) {architect};
  \node[chev] (p) at (5.3,0) {prove-it};
  \node[chev] (d) at (7.95,0) {de-slop};
  \node[chev] (t) at (10.6,0) {tidy};
  \node[chev] (k) at (13.25,0) {checkup};
  \node[desc] at ([yshift=-5pt]g.south) {Questions you until the plan is clear};
  \node[desc] at ([yshift=-5pt]a.south) {Compares \mbox{2--3} stacks you can maintain};
  \node[desc] at ([yshift=-5pt]p.south) {Tests + screenshots instead of ``done''};
  \node[desc] at ([yshift=-5pt]d.south) {Cuts UI back against a checklist};
  \node[desc] at ([yshift=-5pt]t.south) {Finds duplicate rules, dead code \& oversized files};
  \node[desc] at ([yshift=-5pt]k.south) {Flags unused skills, MCPs \& plugins};
\end{tikzpicture}
}%
\end{center}

\vspace{4pt}
\small

- Written for beginners, each with a Bilibili episode explaining **why**
- **The habit matters more than the install**: once it sticks, you'll ask any agent for the same
- **Try it**: tell your agent *"Install the skills from https://github.com/nagi-studio/skills"*

\normalsize

## Key takeaways

\small

1. **Agent = model + harness + tools**, running a reason $\to$ act $\to$ observe loop
2. **Context is the agent's only memory**: keep it small and clean; put lasting rules in `AGENTS.md`
3. **Pick models by your workload**, and **cost per task**, not one leaderboard; medium effort by default
4. **Give specific tasks, demand evidence**: tests and screenshots, not "done"
5. **Commit before, review after**: Git is your undo button, and you own the result

\normalsize

# Going Further

## References: Concepts & models

\small

<!--prettier-ignore-->
| Topic | Resource |
| :---------------------- | :------------------------------------------------- |
| **Agent Guide** | [Xflops HPC Start Guide — AI Agent](https://xflops.sjtu.edu.cn/hpc-start-guide/primer/ai-agent/) |
| **Agent Tutorial** | Zenan Wu. `agent-tutorial.pdf` (Xflops). |
| **Video Resources** | [Bilibili Video Series](https://space.bilibili.com/312249633/lists/8719249?type=season) |
| **ReAct Pattern** | [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629) |
| **Tokenization** | [OpenAI Interactive Tokenizer](https://platform.openai.com/tokenizer) |
| **Reasoning Effort** | [Controlling Reasoning Effort in LLMs](https://magazine.sebastianraschka.com/p/controlling-reasoning-effort-in-llms) |
| **Prompt Caching** | [OpenAI Prompt Caching Guide](https://platform.openai.com/docs/guides/prompt-caching) |
| **AGENTS.md** | [agents.md: format & examples](https://agents.md/) |
| **Model Rankings** | [OpenRouter Rankings](https://openrouter.ai/rankings) |
| **Real Pricing** | [Real API Pricing](https://github.com/Fei2411/real-api-pricing) · [mypriors](https://mypriors.com) |
| **Relay Security** | [Your Agent Is Mine](https://arxiv.org/abs/2604.08407) |
| **Benchmarks** | [Terminal-Bench](https://www.tbench.ai/) · [TB-Science](https://github.com/harbor-framework/terminal-bench-science) · [FrontierCS 2](https://arxiv.org/abs/2610.29932) · [WorkBuddy](https://github.com/Tencent/workbuddy-bench) · [AA Index](https://artificialanalysis.ai/) · [llm2014](https://llm2014.github.io/llm_benchmark/) |
| **MCP \& Hooks** | [MCP Documentation](https://modelcontextprotocol.io/docs/getting-started/intro) · [Claude Code Hooks Guide](https://code.claude.com/docs/en/hooks-guide) |

\normalsize

## References: Tools & infrastructure

\small

<!--prettier-ignore-->
| Topic | Resource |
| :--------------- | :------------------------------------------------------- |
| **DeepSeek Harness** | [Desktop Download](https://www.deepseek.com/en/harness) · [GitHub Repository](https://github.com/deepseek-ai/deepseek-harness) · [Docs](https://deepseek-harness.github.io/deepseek-harness/) · [Safety Notice](https://github.com/deepseek-ai/deepseek-harness/blob/master/SAFETY.md) |
| **AstroPaper** | [Template Repository](https://github.com/satnaing/astro-paper) · [Live Demo](https://astro-paper.pages.dev/) |
| **Deploy** | [Astro Deploy Guide](https://docs.astro.build/en/guides/deploy/) · [GitHub Pages](https://pages.github.com/) · [Cloudflare Pages](https://pages.cloudflare.com/) |
| **Skills** | [nagi-studio/skills](https://github.com/nagi-studio/skills) · [skills CLI](https://github.com/vercel-labs/skills) |
| **Git** | [Pro Git Book](https://git-scm.com/book/en/v2) |
| **Sandboxing** | [bubblewrap](https://github.com/containers/bubblewrap) · [Docker Container Basics](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-a-container/) |
| **API Gateways** (self-host only) | [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) · [sub2api](https://github.com/Wei-Shaw/sub2api) · [New API](https://github.com/QuantumNous/new-api) |

\normalsize

## \quad

\center

\huge

**Thank you!**
