#!/bin/bash
# expects state_functions.env to exist inside CB_STATE_DIR
# expects environment variables set by source.env or ~/.bashrc



if [ -f ~/.bashrc ]; then
  # for BASH
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
  """ >> ~/.bashrc


elif [ -f ~/.zshrc ]; then
  # for ZSH
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
  """ >> ~/.zshrc

fi