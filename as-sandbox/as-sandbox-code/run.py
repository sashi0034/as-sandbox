import sys
import subprocess
import time
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# Retrieve the file path from the command line arguments
if len(sys.argv) < 2:
    print("Usage: python script.py <filepath>")
    sys.exit(1)

filepath = os.path.abspath(sys.argv[1])


def run_command():
    """Execute the command 'bin/as-sandobox.exe <filepath>'."""
    cmd = ["bin/as-sandbox.exe", filepath]
    print(f"Executing: {' '.join(cmd)}")
    print("\n-----------------------------------------------\n")
    subprocess.run(cmd)
    print("\n===============================================\n")


class FileChangeHandler(FileSystemEventHandler):
    prev = None

    def on_modified(self, event):
        # If the modified file is the target file, execute the command
        if os.path.abspath(event.src_path) == filepath:
            now = time.strftime("%H:%M:%S")
            if self.prev is not None and now == self.prev:
                return

            self.prev = now

            print(f"Change detected {now} in {filepath}.")
            run_command()


if __name__ == "__main__":
    # Initial execution of the command
    run_command()

    # Monitor the directory containing the target file
    directory = os.path.dirname(filepath)
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, path=directory, recursive=False)
    observer.start()

    print(f"Watching for changes in {filepath}... Press Ctrl+C to exit.")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
