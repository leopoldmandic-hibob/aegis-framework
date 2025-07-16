#!/bin/bash

# Aegis Framework Feature-Based Structure Migration Script
# This script migrates the existing Aegis framework to a feature-based structure

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONTEXT_DIR=".context"
BACKUP_DIR=".context_backup_$(date +%Y%m%d_%H%M%S)"

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create directory if it doesn't exist
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_info "Created directory: $1"
    fi
}

# Function to create .gitkeep in empty directories
add_gitkeep() {
    find "$1" -type d -empty -exec touch {}/.gitkeep \;
}

# Check if .context directory exists
if [ ! -d "$CONTEXT_DIR" ]; then
    print_error ".context directory not found!"
    exit 1
fi

print_info "Starting Aegis Framework Feature-Based Structure Migration"

# Step 1: Create backup
print_info "Creating backup of existing structure..."
cp -r "$CONTEXT_DIR" "$BACKUP_DIR"
print_success "Backup created: $BACKUP_DIR"

# Step 2: Create new directory structure
print_info "Creating new feature-based directory structure..."

# Create features directory and example features
create_dir "$CONTEXT_DIR/features"
create_dir "$CONTEXT_DIR/features/auth"
create_dir "$CONTEXT_DIR/features/auth/tasks/planned"
create_dir "$CONTEXT_DIR/features/auth/tasks/active"
create_dir "$CONTEXT_DIR/features/auth/tasks/completed"
create_dir "$CONTEXT_DIR/features/auth/tasks/hold"
create_dir "$CONTEXT_DIR/features/auth/memory"
create_dir "$CONTEXT_DIR/features/auth/plan"
create_dir "$CONTEXT_DIR/features/auth/sessions"
create_dir "$CONTEXT_DIR/features/auth/decisions"

create_dir "$CONTEXT_DIR/features/payments"
create_dir "$CONTEXT_DIR/features/payments/tasks/planned"
create_dir "$CONTEXT_DIR/features/payments/tasks/active"
create_dir "$CONTEXT_DIR/features/payments/tasks/completed"
create_dir "$CONTEXT_DIR/features/payments/tasks/hold"
create_dir "$CONTEXT_DIR/features/payments/memory"
create_dir "$CONTEXT_DIR/features/payments/plan"
create_dir "$CONTEXT_DIR/features/payments/sessions"
create_dir "$CONTEXT_DIR/features/payments/decisions"

create_dir "$CONTEXT_DIR/features/notifications"
create_dir "$CONTEXT_DIR/features/notifications/tasks/planned"
create_dir "$CONTEXT_DIR/features/notifications/tasks/active"
create_dir "$CONTEXT_DIR/features/notifications/tasks/completed"
create_dir "$CONTEXT_DIR/features/notifications/tasks/hold"
create_dir "$CONTEXT_DIR/features/notifications/memory"
create_dir "$CONTEXT_DIR/features/notifications/plan"
create_dir "$CONTEXT_DIR/features/notifications/sessions"
create_dir "$CONTEXT_DIR/features/notifications/decisions"

# Create common directory structure
create_dir "$CONTEXT_DIR/common"
create_dir "$CONTEXT_DIR/common/tasks/planned"
create_dir "$CONTEXT_DIR/common/tasks/active"
create_dir "$CONTEXT_DIR/common/tasks/completed"
create_dir "$CONTEXT_DIR/common/tasks/hold"
create_dir "$CONTEXT_DIR/common/memory"
create_dir "$CONTEXT_DIR/common/plan"
create_dir "$CONTEXT_DIR/common/sessions"
create_dir "$CONTEXT_DIR/common/decisions"

# Create feature templates directory
create_dir "$CONTEXT_DIR/templates/features"

# Add .gitkeep to empty directories
add_gitkeep "$CONTEXT_DIR/features"
add_gitkeep "$CONTEXT_DIR/common"

print_success "Feature-based directory structure created"

# Step 3: Move memory system to common
if [ -d "$CONTEXT_DIR/memory" ]; then
    print_info "Moving global memory to common/memory..."
    cp -r "$CONTEXT_DIR/memory/"* "$CONTEXT_DIR/common/memory/" 2>/dev/null || true
    print_success "Memory system moved to common/memory"
fi

# Step 4: Move existing plan to common
if [ -d "$CONTEXT_DIR/plan" ]; then
    print_info "Moving global plan to common/plan..."
    cp -r "$CONTEXT_DIR/plan/"* "$CONTEXT_DIR/common/plan/" 2>/dev/null || true
    print_success "Plan moved to common/plan"
fi

# Step 5: Move existing tasks to common (temporarily)
if [ -d "$CONTEXT_DIR/tasks" ]; then
    print_info "Moving existing tasks to common/tasks..."
    for state in planned active completed hold; do
        if [ -d "$CONTEXT_DIR/tasks/$state" ]; then
            cp -r "$CONTEXT_DIR/tasks/$state/"* "$CONTEXT_DIR/common/tasks/$state/" 2>/dev/null || true
        fi
    done
    print_success "Tasks moved to common/tasks"
fi

# Step 6: Move existing sessions to common
if [ -d "$CONTEXT_DIR/sessions" ]; then
    print_info "Moving existing sessions to common/sessions..."
    cp -r "$CONTEXT_DIR/sessions/"* "$CONTEXT_DIR/common/sessions/" 2>/dev/null || true
    print_success "Sessions moved to common/sessions"
fi

# Step 7: Move existing decisions to common
if [ -d "$CONTEXT_DIR/decisions" ]; then
    print_info "Moving existing decisions to common/decisions..."
    cp -r "$CONTEXT_DIR/decisions/"* "$CONTEXT_DIR/common/decisions/" 2>/dev/null || true
    print_success "Decisions moved to common/decisions"
fi

# Step 8: Create feature context templates
print_info "Creating feature templates..."

# Create feature context template
cat > "$CONTEXT_DIR/templates/features/feature_context_TEMPLATE.md" << 'EOF'
# Feature: [Feature Name]
---
type: feature
name: [feature-name]
status: [planning|active|completed|deprecated]
created: [YYYY-MM-DDTHH:MM:SS]
updated: [YYYY-MM-DDTHH:MM:SS]
owner: [team/person]
priority: [high|medium|low]
---

## Overview
[Comprehensive description of the feature, its purpose, and value proposition]

## Objectives
- [Primary objective 1]
- [Primary objective 2]
- [Primary objective 3]

## Dependencies
### Internal Dependencies
- Feature: [feature-name] - [Why it's needed]
- Component: [component-name] - [Why it's needed]

### External Dependencies
- Service: [service-name] - [Why it's needed]
- Library: [library-name] - [Why it's needed]

## Architecture
[High-level architecture description and key design decisions]

## Status
### Current Phase
[Planning | Design | Implementation | Testing | Deployed | Maintenance]

### Progress
- [ ] Requirements gathering
- [ ] Design approval
- [ ] Implementation
- [ ] Testing
- [ ] Documentation
- [ ] Deployment

## Key Decisions
- [DECISION-001]: [Brief description]
- [DECISION-002]: [Brief description]

## Metrics
- Success Criteria: [How success is measured]
- KPIs: [Key performance indicators]

## Team
- Owner: [name]
- Contributors: [names]
- Stakeholders: [names]

## Notes
[Any additional context or considerations]
EOF

# Create feature plan template
cat > "$CONTEXT_DIR/templates/features/feature_plan_TEMPLATE.md" << 'EOF'
# Feature Plan: [Feature Name]
---
type: feature-plan
feature: [feature-name]
status: active
created: [YYYY-MM-DDTHH:MM:SS]
updated: [YYYY-MM-DDTHH:MM:SS]
---

## Feature Overview
[Brief recap of the feature purpose and goals]

## Implementation Phases

### Phase 1: [Phase Name] ([timeframe])
#### Objectives
- [Objective 1]
- [Objective 2]

#### Tasks
- [ ] [FEATURE-TASK-001]: [Task description]
- [ ] [FEATURE-TASK-002]: [Task description]

#### Deliverables
- [Deliverable 1]
- [Deliverable 2]

### Phase 2: [Phase Name] ([timeframe])
[Similar structure as Phase 1]

## Dependencies Timeline
- [Date]: [Dependency] must be ready
- [Date]: [Integration point] with [other feature]

## Risk Mitigation
| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| [Risk 1] | High | Medium | [Mitigation strategy] |
| [Risk 2] | Medium | Low | [Mitigation strategy] |

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Resource Requirements
- Development: [time/people]
- Testing: [time/people]
- Documentation: [time/people]

## Notes
[Additional planning considerations]
EOF

print_success "Feature templates created"

# Step 9: Create feature.yaml operation file
print_info "Creating feature management operations..."

cat > "$CONTEXT_DIR/ai/operations/feature.yaml" << 'EOF'
name: feature
description: Manage feature-based development contexts
version: 1.0

validation_source:
  file: validation.yaml
  type: command_validation
  rules:
    - feature

input:
  type: command
  pattern: /aegis feature [subcommand]
  subcommands:
    - name: create
      description: Create a new feature context
      params:
        - name: feature_name
          required: true
          validation: lowercase, alphanumeric, hyphens
    - name: list
      description: List all features
    - name: status
      description: Show feature status
      params:
        - name: feature_name
          required: true
    - name: archive
      description: Archive a completed feature
      params:
        - name: feature_name
          required: true

output:
  type: operation
  actions:
    - manage_feature
    - update_context

steps:
  1_validate:
    - check_framework:
        rules:
          - framework_structure
          - required_files
          - permissions
    - validate_feature_name:
        rules:
          - lowercase_only
          - alphanumeric_hyphens
          - no_spaces
          - max_length_30

  2_execute_create:
    condition: subcommand == "create"
    steps:
      - create_feature_structure:
          directories:
            - features/{feature_name}
            - features/{feature_name}/tasks/planned
            - features/{feature_name}/tasks/active
            - features/{feature_name}/tasks/completed
            - features/{feature_name}/tasks/hold
            - features/{feature_name}/memory
            - features/{feature_name}/plan
            - features/{feature_name}/sessions
            - features/{feature_name}/decisions
      - create_feature_context:
          template: templates/features/feature_context_TEMPLATE.md
          target: features/{feature_name}/feature_context.md
          variables:
            - feature_name
            - created_date
            - owner
      - create_feature_plan:
          template: templates/features/feature_plan_TEMPLATE.md
          target: features/{feature_name}/plan/feature_plan.md
          variables:
            - feature_name
            - created_date
      - initialize_feature_memory:
          files:
            - features/{feature_name}/memory/context.json
            - features/{feature_name}/memory/state.json

  3_execute_list:
    condition: subcommand == "list"
    steps:
      - scan_features_directory:
          path: features/
          exclude: [".gitkeep", "README.md"]
      - load_feature_contexts:
          foreach: feature_directory
          load: feature_context.md
          extract: [name, status, owner, created, updated]
      - format_feature_list:
          columns: [Name, Status, Owner, Updated]
          sort_by: updated
          order: desc

  4_execute_status:
    condition: subcommand == "status"
    steps:
      - validate_feature_exists:
          path: features/{feature_name}
      - load_feature_context:
          file: features/{feature_name}/feature_context.md
      - count_tasks:
          planned: features/{feature_name}/tasks/planned/
          active: features/{feature_name}/tasks/active/
          completed: features/{feature_name}/tasks/completed/
          hold: features/{feature_name}/tasks/hold/
      - recent_activity:
          sessions: features/{feature_name}/sessions/
          decisions: features/{feature_name}/decisions/
          limit: 5
      - format_status_report:
          sections:
            - overview
            - task_summary
            - recent_activity
            - next_steps

  5_verify:
    - validate_operation_result
    - update_project_context
    - log_operation

errors:
  feature:
    invalid_name: "Feature name must be lowercase with hyphens only"
    already_exists: "Feature {feature_name} already exists"
    not_found: "Feature {feature_name} not found"
    creation_failed: "Failed to create feature structure"

recovery:
  feature:
    invalid_name: "Use lowercase letters and hyphens only (e.g., user-auth)"
    already_exists: "Choose a different feature name or update existing"
    not_found: "Check feature name or use 'feature list' to see available features"
    creation_failed: "Check permissions and try again"

command_template:
  name: feature
  description: "Template for implementing feature management commands"
  version: 1.0
  
  required_components:
    pre_execution:
      - feature_validation:
          description: "Validate feature name and structure"
          validation:
            - name_valid: "Feature name must be valid"
          implementation: |
            1. Check feature name format (lowercase, hyphens)
            2. Verify feature doesn't already exist (for create)
            3. Verify feature exists (for status/archive)
    
    execution:
      - feature_creation:
          description: "Create new feature structure"
          validation:
            - structure_created: "Feature structure must be created"
          implementation: |
            1. Create feature directory structure
            2. Copy templates to create initial files
            3. Initialize feature memory
            4. Update project context with new feature
      
      - feature_listing:
          description: "List all features"
          validation:
            - list_generated: "Feature list must be generated"
          implementation: |
            1. Scan features directory
            2. Load each feature's context
            3. Format and display feature information
      
      - feature_status:
          description: "Show feature status"
          validation:
            - status_generated: "Feature status must be generated"
          implementation: |
            1. Load feature context
            2. Count tasks in each state
            3. Find recent activity
            4. Generate status report
    
    post_execution:
      - verification:
          description: "Verify operation completed successfully"
          validation:
            - operation_verified: "Operation must be verified"
          implementation: |
            1. Verify all files created/updated
            2. Update project context
            3. Log operation for audit trail
EOF

print_success "Feature management operations created"

# Step 10: Create README for features directory
cat > "$CONTEXT_DIR/features/README.md" << 'EOF'
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
EOF

# Step 11: Create README for common directory
cat > "$CONTEXT_DIR/common/README.md" << 'EOF'
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
EOF

# Step 12: Update AI reasoning guidelines
print_info "Creating AI reasoning guidelines..."

cat > "$CONTEXT_DIR/ai/reasoning_guidelines.md" << 'EOF'
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
EOF

print_success "AI reasoning guidelines created"

# Step 13: Create migration summary
print_info "Creating migration summary..."

cat > "$CONTEXT_DIR/MIGRATION_SUMMARY.md" << 'EOF'
# Feature-Based Structure Migration Summary

## Migration Date
$(date +"%Y-%m-%d %H:%M:%S")

## What Changed

### New Structure
- Created `features/` directory for feature-specific contexts
- Created `common/` directory for shared resources
- Added feature management operations
- Updated templates for feature support

### Content Migration
- Existing tasks moved to `common/tasks/`
- Global memory moved to `common/memory/`
- Project plan moved to `common/plan/`
- Sessions moved to `common/sessions/`
- Decisions moved to `common/decisions/`

### New Capabilities
- Feature creation: `/aegis feature create <name>`
- Feature listing: `/aegis feature list`
- Feature status: `/aegis feature status <name>`
- Feature-scoped operations with `--feature` flag

## Next Steps

1. **Analyze existing tasks** to determine feature assignment
2. **Create features** for major components
3. **Move tasks** to appropriate features
4. **Update references** to use new namespacing
5. **Remove old structure** after verification

## Backward Compatibility

The old structure is preserved in:
- Backup: `$(basename $BACKUP_DIR)`
- Original directories still exist (will be removed after full migration)

## Important Notes

- All existing commands work with `common/`
- New `--feature` flag enables feature-specific operations
- References need updating to include feature namespacing
- Review `common/` regularly to move items to features
EOF

print_success "Migration summary created"

# Final summary
echo ""
print_success "=== Migration Complete ==="
print_info "Backup created at: $BACKUP_DIR"
print_info "New structure created with example features: auth, payments, notifications"
print_info "Existing content moved to common/ directory"
print_info "Feature management operations added"
echo ""
print_warning "Next steps:"
print_warning "1. Review the migration summary in $CONTEXT_DIR/MIGRATION_SUMMARY.md"
print_warning "2. Create features for your major components"
print_warning "3. Move relevant tasks from common/ to features/"
print_warning "4. Update task references to include feature namespacing"
print_warning "5. Remove old directories after verification"
echo ""
print_info "To create a new feature: /aegis feature create <feature-name>"
print_info "To list features: /aegis feature list"
print_info "To see feature status: /aegis feature status <feature-name>" 