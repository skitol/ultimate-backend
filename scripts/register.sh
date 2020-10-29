#!/bin/bash
# shellcheck disable=SC2207
PROJECTS=($(jq -r '.projects[] | select(.type == "application") | .root' ./nest-cli.json))
BOOTSTRAP_PATH=src/bootstrap-development.yaml
CONFIG_PATH_PRIVATE=config.yaml
CONFIG_PATH_DEFAULT=config.example
echo "Service Registration system started"

for PROJECT_DIR in "${PROJECTS[@]}"; do
  echo "\n-----"
  echo "Checking: ${PROJECT_DIR}"
  if [ ! -f "./${PROJECT_DIR}/${BOOTSTRAP_PATH}" ]; then
    echo "./${PROJECT_DIR}/${BOOTSTRAP_PATH} not found, skipping service"
    continue
  fi

  SVC_NAME=$(yq r ./${PROJECT_DIR}/${BOOTSTRAP_PATH} 'service.name')

  if [ ! -f "./${PROJECT_DIR}/${CONFIG_PATH_PRIVATE}" ]; then
    CONFIG_PATH=${CONFIG_PATH_DEFAULT}
  else
    CONFIG_PATH=${CONFIG_PATH_PRIVATE}
  fi

  echo "Service: ${SVC_NAME}"
  echo "Config: ${CONFIG_PATH}"

  if [ ! -f "./${PROJECT_DIR}/${CONFIG_PATH}" ]; then
    echo "ERROR: ./${PROJECT_DIR}/${CONFIG_PATH} file not found."
    continue
  fi

  consul kv put ultimatebackend/config/${SVC_NAME} \@./${PROJECT_DIR}/${CONFIG_PATH}
done

echo "\nService Registration system completed!"
