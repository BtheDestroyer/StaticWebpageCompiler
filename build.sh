#!/bin/bash
export STATIC_PATH="./static/"
export OUTPUT_PATH="${STATIC_PATH}index.html"
export TEMPLATE_PATH="./template/"
# Add, remove, or re-order your desired template files
TEMPLATE_FILES="header
about
experience
blog
contact
footer"

echo "" > ${OUTPUT_PATH}
for file in ${TEMPLATE_FILES}; do
  echo "Reading ${TEMPLATE_PATH}${file}.html"
  if [[ -d ./${file} ]]; then
    echo "  Building intermediary..."
    echo "" > "${TEMPLATE_PATH}${file}.html"
    echo "./${file}/build.sh"
    if [[ -f ./${file}/build.sh ]]; then
      echo "  Running subscript..."
      export INTERMEDIARY_OUTPUT=".${TEMPLATE_PATH}${file}.html"
      if (cd ./${file}; bash ./build.sh); then
        echo "  Subscript finished succesfully"
      else
        echo "  Subscript failed"
        exit -1
      fi
      export INTERMEDIARY_OUTPUT=""
    else
      for file2 in `ls -r ./${file}/*.html`; do
        cat ${file2} >> "${TEMPLATE_PATH}${file}.html"
      done
    fi
  fi
  cat ${TEMPLATE_PATH}${file}.html >> "${OUTPUT_PATH}"
done
echo "Finished building ${OUTPUT_PATH}"
