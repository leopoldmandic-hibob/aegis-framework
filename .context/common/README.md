# Common Directory

This directory contains cross-feature shared resources and project-wide elements.

## Structure

```
common/
├── tasks/              # Cross-feature tasks
├── memory/             # Global framework memory
├── plan/               # Project-wide planning
├── sessions/           # Project-wide sessions
└── decisions/          # Architecture-level decisions
```

## When to Use Common

Place items here when they:
- Affect multiple features
- Define project-wide standards
- Contain architectural decisions
- Represent infrastructure work
- Are truly cross-cutting concerns

## Task References

Tasks in common use the standard format:
- `TASK-XXX` (e.g., `TASK-001`)

## Memory System

The global memory system remains here:
- Core framework configuration
- Project-wide context
- Session management
- Self-improvement data

## Best Practices

1. Prefer feature-specific placement when possible
2. Use common/ only for truly shared resources
3. Document why something is in common/
4. Regular review to move items to features
5. Keep architectural decisions here
