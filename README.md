# shell-util-playstore
## File Directory Operations
- **Make a Directory (`mkdir`):** Creates a directory.
  - **Usage:** `mkdir [directory name]`
- **Creating Nested Directories:** Creates nested directories.
  - **Usage:** `mkdir -p [directory path]`
- **Setting Permissions during Creation:** Sets permissions for the new directory.
  - **Usage:** `mkdir -m 755 [directory name]`
- **Creating Multiple Directories:** Creates multiple directories in a single command.
  - **Usage:** `mkdir [directory name 1] [directory name 2]`
- **Interactive Mode:** Prompts before creating if the directory conflicts.
  - **Usage:** `mkdir -i [new_directory]`
- **Interactive Mode (Verbose):** Displays a message for each directory created.
  - **Usage:** `mkdir -v [new_directory]`
- **Create A Simple Temporary Directory:** Creates a temporary directory in `/tmp`.
  - **Usage:** `mktemp -d`
- **Create A Simple Temporary Directory with Custom Name:** Creates a temporary directory in `/tmp` with a custom name template.
  - **Usage:** `mktemp -d [template]` (e.g., `mktemp -d random-xxxxx`)
  You can also add a suffix to a template while creating the directory, for example:
  - **Example:** `mktemp -d random-xxxxx_suffix`
