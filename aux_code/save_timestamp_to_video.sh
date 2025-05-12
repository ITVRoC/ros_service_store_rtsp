#!/usr/bin/env bash
# Usage: add_timestamp.sh <input_video> <timestamp_txt>
# Reads a timestamp from the provided text file and writes it into
# the output MKV metadata as "timestamp_zero".

if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 <input_video> <timestamp_file>"
    exit 1
fi

INPUT_VIDEO="$1"
TIMESTAMP_FILE="$2"

# Validate inputs
if [[ ! -f "$INPUT_VIDEO" ]]; then
    echo "Error: video file not found: $INPUT_VIDEO"
    exit 1
fi
if [[ ! -f "$TIMESTAMP_FILE" ]]; then
    echo "Error: timestamp file not found: $TIMESTAMP_FILE"
    exit 1
fi

# Read and sanitize timestamp
TIMESTAMP_ZERO=$(<"$TIMESTAMP_FILE")
TIMESTAMP_ZERO=$(echo "$TIMESTAMP_ZERO" | tr -d '[:space:]')

# Derive base name and extension
BASE_NAME="${INPUT_VIDEO%.*}"
EXT="${INPUT_VIDEO##*.}"

# Choose output filename: avoid in-place editing for MKV inputs
if [[ "$EXT" == "mkv" ]]; then
    OUTPUT_VIDEO="${BASE_NAME}-with_timestamp.mkv"
else
    OUTPUT_VIDEO="${BASE_NAME}.mkv"
fi

# Run ffmpeg to copy streams and add metadata
ffmpeg -i "$INPUT_VIDEO" -metadata timestamp_zero="$TIMESTAMP_ZERO" -c copy "$OUTPUT_VIDEO" \
  && echo "Created '$OUTPUT_VIDEO' with timestamp_zero=$TIMESTAMP_ZERO"
