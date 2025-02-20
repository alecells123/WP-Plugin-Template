#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: $0 <new-plugin-name> <new-plugin-url> <new-plugin-author> <new-plugin-author-url>"
    echo "Example: $0 \"My Awesome Plugin\" \"https://github.com/username/my-awesome-plugin\" \"John Doe\" \"https://github.com/username\""
    exit 1
}

# Check if we have all arguments
if [ "$#" -ne 4 ]; then
    show_usage
fi

# Store arguments
NEW_PLUGIN_NAME="$1"
NEW_PLUGIN_URL="$2"
NEW_PLUGIN_AUTHOR="$3"
NEW_PLUGIN_AUTHOR_URL="$4"

# Convert plugin name to different formats
# "My Awesome Plugin" -> "my-awesome-plugin"
SLUG=$(echo "$NEW_PLUGIN_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
# "my-awesome-plugin" -> "my_awesome_plugin"
UNDERSCORE=$(echo "$SLUG" | sed 's/-/_/g')
# "my-awesome-plugin" -> "MyAwesomePlugin"
CAMELCASE=$(echo "$NEW_PLUGIN_NAME" | sed -r 's/([[:blank:]]|^)([[:alpha:]])/\U\2/g' | sed 's/ //g')

echo "Converting WP Plugin Template to $NEW_PLUGIN_NAME..."

# Function to perform replacements in a file
process_file() {
    local file="$1"
    if [ -f "$file" ]; then
        # Replace various formats of the plugin name
        sed -i "s/WP Plugin Template/$NEW_PLUGIN_NAME/g" "$file"
        sed -i "s/WP_Plugin_Template/$CAMELCASE/g" "$file"
        sed -i "s/wp-plugin-template/$SLUG/g" "$file"
        sed -i "s/wp_plugin_template/$UNDERSCORE/g" "$file"
        
        # Replace author and URLs
        sed -i "s|https://github.com/alecells123|$NEW_PLUGIN_URL|g" "$file"
        sed -i "s|Alec Ellsworth|$NEW_PLUGIN_AUTHOR|g" "$file"
        sed -i "s|https://https://github.com/alecells123/|$NEW_PLUGIN_AUTHOR_URL|g" "$file"
    fi
}

# Rename files and directories
find . -depth -name "*wp-plugin-template*" -execdir bash -c '
    old="${1#./}"
    new="${old//wp-plugin-template/'$SLUG'}"
    if [ "$old" != "$new" ]; then
        mv "$old" "$new"
    fi
' bash {} \;

# Process all files
find . -type f -not -path "*/\.*" -not -name "rename-plugin.sh" -exec bash -c '
    process_file "$0"
' {} \;

# Update the main plugin file
if [ -f "$SLUG.php" ]; then
    # Update plugin header information
    sed -i "s/Plugin Name: .*$/Plugin Name: $NEW_PLUGIN_NAME/" "$SLUG.php"
    sed -i "s|Plugin URI: .*$|Plugin URI: $NEW_PLUGIN_URL|" "$SLUG.php"
    sed -i "s|Author: .*$|Author: $NEW_PLUGIN_AUTHOR|" "$SLUG.php"
    sed -i "s|Author URI: .*$|Author URI: $NEW_PLUGIN_AUTHOR_URL|" "$SLUG.php"
fi

echo "Plugin conversion complete!"
echo "New plugin details:"
echo "  Name: $NEW_PLUGIN_NAME"
echo "  Slug: $SLUG"
echo "  Main PHP Class: $CAMELCASE"
echo "  Function Prefix: ${UNDERSCORE}_" 