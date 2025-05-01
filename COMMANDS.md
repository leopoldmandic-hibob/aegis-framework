# Aegis Framework: Complete Reference

## ⚠️ CRITICAL RULES ⚠️

1. **ALWAYS use `.context/` with leading dot** (NEVER `context/` without dot)
2. **ALWAYS use `mv` for task transitions** (NEVER `cp`)
3. **ALWAYS update front matter after moves**
4. **ALWAYS assume directories exist** (NO `mkdir -p` needed)
5. **NEVER create duplicate task files**
6. **ALWAYS use current year for all timestamps**
7. **ALWAYS use EXACT current time from metadata for timestamps**

## Core Commands

### `/aegis plan`
Create/update project planning document and tasks
- Creates/updates `.context/plan/planning_document.md`
- Generates tasks in `.context/tasks/planned/`
- Maintains task dependencies

### `/aegis start`
Begin development session
- Loads project context
- Sets initial focus
- Validates task states

### `/aegis save`
Preserve session progress
- Creates session log in `.context/sessions/`
- Records decisions in `.context/decisions/`
- Updates task progress

### `/aegis status`
Show current project state
- Shows active tasks
- Lists recent changes
- Displays current focus

### `/aegis task`
Manage tasks and transitions
- Move between states using `mv` (NEVER `cp`)
- Update task metadata
- Track progress

### `/aegis context`
Quick context refresh
- Shows active tasks
- Lists recent changes
- Displays decisions

### `/aegis help`
Show command help and usage

## Task State Flow
```
.context/tasks/planned/  → .context/tasks/active/    (Starting work)
.context/tasks/active/   → .context/tasks/completed/ (Work done)
.context/tasks/active/   → .context/tasks/hold/      (Work blocked)
.context/tasks/hold/     → .context/tasks/active/    (Block resolved)
```

## Framework Structure
```
.context/                # ROOT DIRECTORY (with dot)
├── AI_INSTRUCTIONS.md   # Framework instructions
├── ai/operations/      # Command patterns
├── memory/             # Memory system
│   ├── core/           # Framework memory
│   ├── project/        # Project memory
│   └── session/        # Session state
├── templates/          # Document templates
│   ├── tasks/          # Task templates
│   ├── sessions/       # Session templates
│   └── decisions/      # Decision templates
├── tasks/              # Task management
│   ├── active/         # Current work
│   ├── planned/        # Future work
│   ├── hold/           # Blocked
│   └── completed/      # Done
├── sessions/           # Progress logs
└── decisions/          # Key decisions
```

## Task Operations

### Creating Tasks
```bash
# CORRECT: Create new task from template
cp .context/templates/tasks/TEMPLATE.md .context/tasks/planned/TASK-XXX.md

# Then update content and front matter
```

### Moving Tasks
```bash
# ✅ CORRECT: Move task to active
mv .context/tasks/planned/TASK-XXX.md .context/tasks/active/TASK-XXX.md

# ❌ INCORRECT: Never copy tasks
cp .context/tasks/planned/TASK-XXX.md .context/tasks/active/TASK-XXX.md
```

### Updating Front Matter
Always update these fields after moving:
```yaml
---
status: [new-status]  # Match target directory
updated: YYYY-MM-DDTHH:MM:SS  # Current timestamp with T separator
---
```

### Timestamp Generation
When generating timestamps:
- ALWAYS use the current year (2025)
- ALWAYS use the EXACT current time from metadata (hours:minutes:seconds)
- NEVER use default or placeholder times
- Front matter requires full ISO 8601 format with T separator
- Example: `2025-03-05T12:41:19` (using exact current time)
- Include timezone offset when available

## Task Template
```yaml
---
title: [Task Title]
type: task
status: [planned|active|completed|hold]
created: YYYY-MM-DDTHH:MM:SS
updated: YYYY-MM-DDTHH:MM:SS
id: TASK-XXX
priority: [high|medium|low]
memory_types: [procedural|semantic|episodic]
dependencies: []
tags: []
---
```

## Required Task Sections
- Description
- Objectives
- Steps
- Progress
- Dependencies
- Notes
- Next Steps

## Common Mistakes to Avoid
1. ❌ Creating a `context/` directory (without leading dot)
2. ❌ Using `cp` instead of `mv` for task transitions
3. ❌ Using `mkdir -p` for existing directories
4. ❌ Creating tasks without using template
5. ❌ Modifying template structure
6. ❌ Skipping required fields
7. ❌ Creating duplicate tasks

## Validation Checklist
Before executing any command:
1. Verify path starts with `.context/` (with dot)
2. Use `mv` (not `cp`) for task transitions
3. Skip `mkdir -p` commands - directories exist
4. Update front matter after task moves
5. Use correct timestamp formats:
   - Front Matter: `YYYY-MM-DDTHH:MM:SS`
   - File Names: `YYYY-MM-DD`

## Directory Documentation
1. Every directory contains a README.md that MUST be consulted first
2. README.md files form a hierarchical documentation system:
   - Root README.md: Framework overview
   - Component README.md: Component documentation
   - Subdirectory README.md: Specific usage instructions

## Instruction Prioritization
When working with the framework, follow this priority order:
1. User Instructions (highest priority)
2. Framework Documentation
3. Template Usage
4. Framework Defaults (lowest priority)

## Framework Validation
Before executing any command:
1. Verify `.context` directory structure exists
2. Check all required files are present
3. Validate file permissions
4. Verify README.md files exist and are accessible
5. Follow README.md hierarchy for operations
