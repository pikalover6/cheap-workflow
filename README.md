# Cheap Workflow

A deliberately minimal, budget-oriented Claude Code workflow experiment.

## The idea

```text
Sonnet 5 Medium — orchestrator
├── Opus 4.8 XHigh — rare decision advisor
├── Sonnet 5 Low — default implementer for substantial coding
├── Haiku 4.5 — mechanical micro-builder
└── Haiku 4.5 — read-only scout
```

The core rule:

> The orchestrator handles tiny edits directly. Substantial implementation goes to Sonnet Low. Haiku may translate an already-decided change into code, but if the task requires deciding what the code should do, use Sonnet Low.

No Codex. No ChatGPT integration. No review agents. No hooks. No extra tooling.

The experiment is isolated. `cheap-flow` loads the plugin; plain `claude` stays plain.

## Install on macOS

```bash
mkdir -p ~/.local/share ~/.local/bin
git clone https://github.com/pikalover6/cheap-workflow.git ~/.local/share/cheap-workflow
chmod +x ~/.local/share/cheap-workflow/bin/cheap-flow
ln -sf ~/.local/share/cheap-workflow/bin/cheap-flow ~/.local/bin/cheap-flow
```

Make sure `~/.local/bin` is on your PATH. For zsh:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh
```

## Install on Windows

Open PowerShell and run:

```powershell
New-Item -ItemType Directory -Force "$HOME\.local\share", "$HOME\.local\bin" | Out-Null
git clone https://github.com/pikalover6/cheap-workflow.git "$HOME\.local\share\cheap-workflow"
Copy-Item "$HOME\.local\share\cheap-workflow\bin\cheap-flow.cmd" "$HOME\.local\bin\cheap-flow.cmd" -Force
```

Add `~\.local\bin` to your user PATH if it is not already there:

```powershell
$bin = "$HOME\.local\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (($userPath -split ';') -notcontains $bin) {
  [Environment]::SetEnvironmentVariable("Path", "$userPath;$bin", "User")
}
$env:Path += ";$bin"
```

Then run:

```powershell
cheap-flow
```

## Use

From any project:

```bash
cd ~/code/my-project
cheap-flow
```

That starts Claude Code with only this plugin loaded.

Vanilla Claude Code is still:

```bash
claude
```

## Recommended workflow

For a substantial project, planning with Opus beforehand is a good idea, but Cheap Workflow deliberately has no special planning integration.

A simple pattern:

1. Use Opus to make and approve a plan.
2. Start `cheap-flow` in the project.
3. Give the Sonnet orchestrator the task and approved plan.
4. Let it route implementation cheaply.

The orchestrator will:

- make tiny and local edits directly when delegation would cost more
- inspect directly or use parallel Haiku scouts for cheap evidence
- use Sonnet 5 Low for substantial software engineering
- use Haiku only for already-specified mechanical coding
- call Opus 4.8 XHigh only for consequential unresolved decisions
- integrate and verify the result itself

A broad request such as building a website, feature, API, or application should normally use at least one implementation subagent. A one-line fix should not.

## Routing policy

### Orchestrator direct work

The Sonnet 5 Medium main agent may work directly when the task is cheaper to do than to delegate:

- one-line or few-line changes
- small single-file tweaks
- integration glue
- quick corrections after delegated work
- changes that depend heavily on the full conversation context

### Haiku scout

Use for one narrow read-only question:

- find callers
- locate tests
- map a package
- inspect config
- summarize logs
- collect evidence

### Haiku micro-builder

Use only when the logic is already decided.

Good examples:

- copy an adjacent test pattern with specified differences
- add a known config entry
- apply a specified rename
- make a tiny CSS edit
- translate fully written-out logic into code
- perform a repetitive mechanical edit

If Haiku encounters ambiguity, missing logic, a design choice, a debugging question, non-trivial state, or any need for creativity, it must stop.

### Sonnet 5 Low builder

Default for substantial real software engineering:

- building a coherent feature or component
- debugging
- choosing an approach
- implementing non-trivial behavior
- stateful logic
- refactors
- tradeoffs
- anything requiring sustained problem solving or creativity

### Opus 4.8 XHigh advisor

Rarely called. The orchestrator should gather cheap evidence first.

Advisor-worthy situations:

- two credible approaches remain and the choice has meaningful downstream cost
- repository reality contradicts the plan
- a bug still has multiple plausible root causes after investigation
- a failed implementation changes the theory
- a consequential architectural or high-semantic-risk decision remains
- a suspected blind spot cannot be resolved by cheap inspection

Before calling Opus, the orchestrator must provide:

```text
Decision:
Known facts:
Evidence:
Options:
Current recommendation:
Main uncertainty:
Why getting this wrong is expensive:
```

Normal task: zero advisor calls. Hard task: one. Very hard task: two. Before a third call, the workflow should stop and tell you the task is stuck or needs fundamental replanning.

## Parallelism

Parallel reads are encouraged. Writing is serial by default.

That is intentional: the workflow optimizes for successful work per unit of usage, not maximum wall-clock speed.

## Update

### macOS

```bash
git -C ~/.local/share/cheap-workflow pull --ff-only
chmod +x ~/.local/share/cheap-workflow/bin/cheap-flow
```

### Windows

```powershell
git -C "$HOME\.local\share\cheap-workflow" pull --ff-only
Copy-Item "$HOME\.local\share\cheap-workflow\bin\cheap-flow.cmd" "$HOME\.local\bin\cheap-flow.cmd" -Force
```

## Uninstall

### macOS

```bash
rm ~/.local/bin/cheap-flow
rm -rf ~/.local/share/cheap-workflow
```

### Windows

```powershell
Remove-Item "$HOME\.local\bin\cheap-flow.cmd" -Force -ErrorAction SilentlyContinue
Remove-Item "$HOME\.local\share\cheap-workflow" -Recurse -Force
```

## Development

```bash
git clone https://github.com/pikalover6/cheap-workflow.git
cd cheap-workflow
claude --plugin-dir .
```
