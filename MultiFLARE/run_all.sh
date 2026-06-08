#!/bin/bash

for file in configs/neu-config/*.txt; do
    echo "Training with config: $file"
    python train.py --config "$file"
done
