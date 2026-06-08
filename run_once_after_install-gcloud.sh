#!/bin/bash

command -v gcloud &>/dev/null && exit 0

curl -fsSL https://sdk.cloud.google.com | CLOUDSDK_CORE_DISABLE_PROMPTS=1 bash
