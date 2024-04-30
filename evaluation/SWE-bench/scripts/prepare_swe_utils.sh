#!/bin/bash

EVAL_WORKSPACE="evaluation/SWE-bench/eval_workspace"
# mkdir -p $EVAL_WORKSPACE

## 1. Prepare REPO
# echo "==== Prepare SWE-bench repo ===="
# OD_SWE_BENCH_REPO_PATH="https://github.com/OpenDevin/OD-SWE-bench.git"
# OD_SWE_BENCH_REPO_BRANCH="eval"
# git clone -b $OD_SWE_BENCH_REPO_BRANCH $OD_SWE_BENCH_REPO_PATH $EVAL_WORKSPACE/OD-SWE-bench

# 2. Prepare DATA
echo "==== Prepare SWE-bench data ===="
EVAL_IMAGE=ghcr.io/opendevin/eval-swe-bench:latest
EVAL_WORKSPACE=$(realpath $EVAL_WORKSPACE)
chmod +x $EVAL_WORKSPACE/OD-SWE-bench/swebench/harness/prepare_data.sh
docker run \
    -v $EVAL_WORKSPACE:/workspace \
    -w /workspace/OD-SWE-bench/swebench/harness \
    -u $(id -u):$(id -g) \
    -e HF_DATASETS_CACHE="/tmp" \
    --rm -it $EVAL_IMAGE \
    /opt/miniforge3/bin/conda run -n swe-bench-eval ./prepare_data.sh

# cp $EVAL_WORKSPACE/OD-SWE-bench/swebench/harness/eval_data/instances/swe-bench-test.json /tmp/cache
