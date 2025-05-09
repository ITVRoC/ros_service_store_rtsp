### Generating video files with start timestamp saved as metadata
For compatibility reasons, the store_rtsp_service.py script saves video segments as .mp4 files, which do not support custom metadata. To accomomodate, the timestamp is saved in a .txt file instead, with the same base name as the video segments, but suffixed with -timestamp_zero.
After a compiled video has been created from video segments, the save_timestamp_to_video.sh script can be used to copy it onto an .mkv file, with the timestamp saved as metadata.

<pre> save_timestamp_to_video.sh input_video.mp4 input_text_file.txt </pre>

For the script to be accessible from any directory, a short setup is required:
- Place the script file in /usr/local/bin
- Provide excutable permissions
    <pre> chmod +x save_timestamp_to_video.sh </pre>

Optionally, an alias can be setup to allow calling the script with a shorter name

<pre> alias myalias='save_timestamp_to_video.sh' </pre>
  
