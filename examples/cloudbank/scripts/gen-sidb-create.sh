# initialization
STATE_LOCATION=$CB_STATE_DIR/state.json


# generate YAML
echo -n "Generating YAML file..."
YAML_FILE=$CB_KUBERNETES_GEN_FILES_DIR/sidb-create.yaml
cp $CB_KUBERNETES_TEMPLATES_DIR/sidb-create-template.yaml $YAML_FILE
echo "DONE"

# Output copy
echo ""
echo "To apply:"
echo "kubectl apply -f $YAML_FILE"
echo ""
