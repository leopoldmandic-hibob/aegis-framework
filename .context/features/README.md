# Features Directory

This directory contains feature-specific contexts, enabling feature-based development within the Aegis framework.

## Structure

Each feature has its own self-contained directory with:
```
feature-name/
├── feature_context.md    # Feature overview and metadata
├── tasks/               # Feature-specific tasks
│   ├── planned/
│   ├── active/
│   ├── completed/
│   └── hold/
├── memory/              # Feature-specific memory
├── plan/                # Feature planning documents
├── sessions/            # Feature development sessions
└── decisions/           # Feature-specific decisions
```

## Creating a New Feature

Use the Aegis command:
```
/aegis feature create <feature-name>
```

This will:
1. Create the feature directory structure
2. Generate feature_context.md from template
3. Initialize feature memory
4. Create initial planning document

## Feature Naming Convention

- Use lowercase letters
- Use hyphens for word separation
- Keep names concise but descriptive
- Examples: `user-auth`, `payment-processing`, `email-notifications`

## Cross-Feature References

When referencing items from other features:
- Tasks: `FEATURE-TASK-XXX` (e.g., `AUTH-TASK-001`)
- Decisions: `FEATURE-DECISION-XXX` (e.g., `PAYMENTS-DECISION-001`)
- Use full namespacing for clarity

## Feature Lifecycle

1. **Planning**: Initial feature design and requirements
2. **Active**: Feature under development
3. **Completed**: Feature fully implemented
4. **Deprecated**: Feature no longer maintained

## Best Practices

1. Keep feature contexts focused and cohesive
2. Document dependencies clearly
3. Regular status updates in feature_context.md
4. Archive completed features when appropriate
5. Use common/ for truly cross-cutting concerns
