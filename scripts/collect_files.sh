#!/bin/bash

# Configuration
DIRECTORIES=("$PWD")  # Use current directory
SITES_DIR="$HOME/Sites"  # Fixed output parent directory
OUTPUT_DIR="$SITES_DIR/collected_files"  # Fixed output directory

# File extensions to collect
EXTENSIONS=(
    "py"
    "tsx"
    "md"
    "txt"
    "Dockerfile"
    "dockerfile"
    "docker-compose.yml"
    "docker-compose.yaml"
)

# Directories to exclude
EXCLUDE_PATTERNS=(
    "node_modules"
    "__pycache__"
    ".git"
    "dist"
    "build"
    "venv"
    ".env"
    "coverage"
    "test"
    "tests"
    ".next"
    ".vscode"
    "eslint"
    "docs/rules"
    "components/ui"
)

# Max number of files to collect
MAX_FILES=30

# Function to check if path should be excluded
should_exclude() {
    local path="$1"
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        if [[ "$path" == *"$pattern"* ]]; then
            return 0  # true, should exclude
        fi
    done
    return 1  # false, should not exclude
}

# Function to collect files
collect_files() {
    local dir="$1"
    echo "Collecting files from $dir..."
    
    # Temporary file to store all found files
    temp_file=$(mktemp)
    
    # Create exclude pattern for find command
    exclude_pattern=""
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        exclude_pattern="$exclude_pattern -not -path '*/$pattern/*'"
    done
    
    # Find files but exclude unwanted directories
    for ext in "${EXTENSIONS[@]}"; do
        if [[ "$ext" == "Dockerfile" || "$ext" == "dockerfile" ]]; then
            eval "find '$dir' $exclude_pattern -type f -name '$ext'" >> "$temp_file"
        elif [[ "$ext" == "docker-compose.yml" || "$ext" == "docker-compose.yaml" ]]; then
            eval "find '$dir' $exclude_pattern -type f -name '$ext'" >> "$temp_file"
        else
            eval "find '$dir' $exclude_pattern -type f -name '*.$ext'" >> "$temp_file"
        fi
    done
    
    # Sort files by modification time (newest first) and take top MAX_FILES
    if [ -s "$temp_file" ]; then
        while IFS= read -r file; do
            cp "$file" "$OUTPUT_DIR"/
        done < <(ls -t $(cat "$temp_file") | head -n $MAX_FILES)
    fi
    
    # Clean up
    rm "$temp_file"
}

# Function to generate tree structure
generate_tree() {
    echo "Generating directory tree structure..."
    {
        echo "Original Directory Structure (Excluding filtered directories):"
        echo "=========================="
        for dir in "${DIRECTORIES[@]}"; do
            expanded_dir=$(eval echo "$dir")
            echo -e "\nDirectory: $expanded_dir"
            if [ -d "$expanded_dir" ]; then
                # Create exclude pattern for tree command
                exclude_pattern=""
                for pattern in "${EXCLUDE_PATTERNS[@]}"; do
                    exclude_pattern="$exclude_pattern -I $pattern"
                done
                eval "tree '$expanded_dir' $exclude_pattern --noreport"
            else
                echo "Directory not found"
            fi
        done
        
        echo -e "\nCollected Files:"
        echo "=========================="
        ls -1 "$OUTPUT_DIR"
    } > "$OUTPUT_DIR/directory_structure.txt"
}

# Main execution
echo "Starting file collection..."

# Ensure Sites directory exists
if [ ! -d "$SITES_DIR" ]; then
    echo "Error: $SITES_DIR directory does not exist"
    exit 1
fi

# Remove existing output directory if it exists
if [ -d "$OUTPUT_DIR" ]; then
    echo "Removing existing $OUTPUT_DIR directory..."
    rm -rf "$OUTPUT_DIR"
fi

# Create fresh output directory
echo "Creating new $OUTPUT_DIR directory..."
mkdir -p "$OUTPUT_DIR"

# Collect files from each directory
for dir in "${DIRECTORIES[@]}"; do
    expanded_dir=$(eval echo "$dir")
    echo "Processing directory: $expanded_dir"
    
    if [ -d "$expanded_dir" ]; then
        collect_files "$expanded_dir"
    else
        echo "Warning: Directory not found - $expanded_dir"
    fi
done

# Generate tree structure
if command -v tree >/dev/null 2>&1; then
    generate_tree
else
    echo "Warning: 'tree' command not found. Directory structure will be limited."
    for dir in "${DIRECTORIES[@]}"; do
        expanded_dir=$(eval echo "$dir")
        if [ -d "$expanded_dir" ]; then
            ls -R "$expanded_dir" >> "$OUTPUT_DIR/directory_structure.txt"
        fi
    done
fi

# Count and list collected files
file_count=$(ls -1 "$OUTPUT_DIR" | wc -l)
file_count=$((file_count - 1))  # Subtract 1 to exclude directory_structure.txt

echo -e "\nCollected $file_count files:"
ls -1 "$OUTPUT_DIR" | grep -v "directory_structure.txt"

echo -e "\nDone! Files have been collected in $OUTPUT_DIR"
echo "Directory structure has been saved to $OUTPUT_DIR/directory_structure.txt"
