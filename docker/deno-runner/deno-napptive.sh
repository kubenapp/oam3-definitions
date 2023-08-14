#!/bin/bash

# This script clones a given git repository and launches a deno run command based on the parameters passed
# as environment variables.

# Check if the GitHub repository URL is provided as an environment variable
if [ -z "$REPO_URL" ]; then
  echo "Error: GitHub main repository URL not provided. Please set the REPO_URL environment variable."
  exit 1
fi

# Set the default clone directory for the main GitHub repository
MAIN_REPO_DIRECTORY="/tmp/main_repo"

# Check if GITHUB_TOKEN is not empty (private repository)
if [[ -n $GITHUB_TOKEN ]]; then
    if [[ -z $USER_NAME ]]; then
      echo "USER_NAME environment variable is required with GITHUB_TOKEN to clone private repositories"
      exit 1
    fi
    # Clone the private repository using the extracted credentials
    echo "Cloning a private Git main repository..."
    echo $REPO_URL >> config.txt
    sed "s/github/$USER_NAME:$GITHUB_TOKEN@github/g" config.txt > updated_config.txt
    export UPDATED_URL=$(cat updated_config.txt)
    git clone --depth=1 "$UPDATED_URL" "$MAIN_REPO_DIRECTORY"
    rm -rf config.txt updated_config.txt

else
    # Clone the public repository without credentials
    echo "Cloning a public Git main repository..."
    git clone --depth=1 $REPO_URL $MAIN_REPO_DIRECTORY
fi
# Set the default Deno code directory to the root of the cloned repository
DENO_DIRECTORY_ABSOLUTE_PATH="$MAIN_REPO_DIRECTORY"

# If DENO_PATH is provided, calculate the absolute path
if [ -n "$DENO_PATH" ]; then
  DENO_DIRECTORY_ABSOLUTE_PATH="$MAIN_REPO_DIRECTORY/$DENO_PATH"

  # Check if the Deno code directory exists
  if [ ! -d "$DENO_DIRECTORY_ABSOLUTE_PATH" ]; then
    echo "Warning: The specified Deno code directory does not exist within the main repository. Running Deno from the root of the main repository."
    DENO_DIRECTORY_ABSOLUTE_PATH="$MAIN_REPO_DIRECTORY"
  fi
fi

# Check if the ENTRYPOINT environment variable is provided
if [ -z "$ENTRYPOINT" ]; then
  echo "Error: ENTRYPOINT environment variable not provided. Please set the ENTRYPOINT variable to specify the entry point for the Deno application."
  exit 1
fi

# Read Deno options from environment variables
deno_options=""
if [ "$ALLOW_NET" = "true" ]; then
  deno_options="$deno_options --allow-net"
fi
if [ "$ALLOW_SYS" = "true" ]; then
  deno_options="$deno_options --allow-sys"
fi
if [ "$ALLOW_ENV" = "true" ]; then
  deno_options="$deno_options --allow-env"
fi
if [ "$ALLOW_HRTIME" = "true" ]; then
  deno_options="$deno_options --allow-hrtime"
fi
if [ "$ALLOW_FFI" = "true" ]; then
  deno_options="$deno_options --allow-ffi"
fi
if [ "$ALLOW_READ" = "true" ]; then
  deno_options="$deno_options --allow-read"
fi
if [ "$ALLOW_WRITE" = "true" ]; then
  deno_options="$deno_options --allow-write"
fi
if [ "$ALLOW_RUN" = "true" ]; then
  deno_options="$deno_options --allow-run"
fi
if [ "$ALLOW_ALL" = "true" ]; then
  deno_options="$deno_options --allow-all"
fi


# Change to the Deno code directory
cd "$DENO_DIRECTORY_ABSOLUTE_PATH"

# Run the Deno application with the specified options and entry point
deno run $deno_options "$ENTRYPOINT"