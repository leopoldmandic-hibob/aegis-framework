# AI Reasoning Guidelines for Feature-Based Structure

## Context Resolution

### Feature Context Detection
1. Check for explicit `--feature` parameter
2. Analyze current working context
3. Look for feature references in task/session
4. Default to common/ if ambiguous

### Path Resolution Priority
1. Feature-specific paths (when in feature context)
2. Common paths (for cross-feature work)
3. Error if path ambiguous

## Reference Resolution

### Task References
- Feature tasks: `FEATURE-TASK-XXX`
- Common tasks: `TASK-XXX`
- Always use full namespace in cross-feature references

### Decision References
- Feature decisions: `FEATURE-DECISION-XXX`
- Common decisions: `DECISION-XXX`

### Session References
- Feature sessions: Feature-scoped by directory
- Common sessions: Project-wide scope

## Command Behavior

### Feature-Aware Commands
All commands should:
1. Accept optional `--feature` parameter
2. Detect feature context from current state
3. Resolve paths based on context
4. Maintain backward compatibility

### Feature Management
- `/aegis feature create <name>`: Initialize new feature
- `/aegis feature list`: Show all features
- `/aegis feature status <name>`: Feature-specific status
- `/aegis feature archive <name>`: Archive completed feature

## Best Practices

### Feature Isolation
1. Keep feature work within feature directory
2. Explicit imports for cross-feature data
3. Document all external dependencies
4. Minimize coupling between features

### Cross-Feature Work
1. Use common/ for shared resources
2. Document why something is cross-feature
3. Consider extracting to separate feature
4. Regular review of common/ contents

### Migration Support
1. Maintain backward compatibility
2. Provide migration suggestions
3. Handle legacy references gracefully
4. Clear deprecation warnings

## Error Handling

### Ambiguous Context
When context is ambiguous:
1. Ask for clarification
2. Show available options
3. Suggest most likely choice
4. Never assume without confirmation

### Missing Features
When feature doesn't exist:
1. Suggest creating new feature
2. Show similar existing features
3. Offer to use common/ instead
4. Provide clear error message

### Invalid References
When reference invalid:
1. Check all possible contexts
2. Suggest corrections
3. Show valid alternatives
4. Maintain reference integrity
