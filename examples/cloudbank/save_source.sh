#!/bin/bash
# expects state_functions.env to exist inside CB_STATE_DIR
# expects environment variables set by source.env or ~/.bashrc

echo """
# ====================== BEGIN CLOUDBANK SOURCE ENV ======================

export LAB_HOME=${LAB_HOME}
export ROOT_DIR=${ROOT_DIR}
export CB_ROOT_DIR=${CB_ROOT_DIR}
export CB_STATE_DIR=${CB_STATE_DIR}
export CB_TERRAFORM_DIR=${CB_TERRAFORM_DIR}
export CB_KUBERNETES_TEMPLATES_DIR=${CB_KUBERNETES_TEMPLATES_DIR}
export CB_KUBERNETES_GEN_FILES_DIR=${CB_KUBERNETES_GEN_FILES_DIR}

source ${CB_STATE_DIR}/state_functions.env
# ====================== END CLOUDBANK SOURCE ENV ==========================
""" >> $CB_STATE_DIR/source.env

if [ -f ~/.bashrc ]; then
  # for BASH
  cat $CB_STATE_DIR/source.env >> ~/.bashrc
elif
  [ -f ~/.zshrc ]; then
  # for ZSH
  cat $CB_STATE_DIR/source.env >> ~/.zshrc
fi
