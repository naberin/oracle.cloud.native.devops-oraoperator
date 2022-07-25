PYTHON_FUNCTION=$CB_STATE_DIR/tasks/generate.py

CREATE_BRANCH_TOKEN=$(python $PYTHON_FUNCTION)
state_set '.lab.webhook-tokens.create-branch-webhook |= $VAL' CREATE_BRANCH_TOKEN

DELETE_BRANCH_TOKEN=$(python $PYTHON_FUNCTION)
state_set '.lab.webhook-tokens.delete-branch-webhook |= $VAL' DELETE_BRANCH_TOKEN

PUSH_BRANCH_TOKEN=$(python $PYTHON_FUNCTION)
state_set '.lab.webhook-tokens.push-branch-webhook |= $VAL' PUSH_BRANCH_TOKEN