#!/bin/bash

# for file in configs/configs-to-run/*.txt; do
#     echo "Training with config: $file"
#     python train.py --config "$file"
# done

for file in configs/configs-to-run/*.txt; do
    echo "Training with config: $file"
    # python evaluate.py --config $file --tracker_resume 3000 --frame_interval 5 --num_frames 64
    python make_overlay_video.py --config $file --tracker_resume 3000 --test_dirs 1 --out tracking_video --n_frames 1000 --smooth_crops --framerate 24 --export_meshes
done

