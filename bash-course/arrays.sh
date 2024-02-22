#!/bin/bash

# Define an array
colors=("Red" "Green" "Blue" "Yellow")

# Print the entire array
echo "All colors: ${colors[@]}"

# Access individual elements
echo "First color: ${colors[0]}"
echo "Second color: ${colors[1]}"

# Add an element to the end of the array
colors+=("Orange")

# Print the updated array
echo "Colors after adding Orange: ${colors[@]}"

# Iterate through the array
echo "Iterating through colors:"
for color in "${colors[@]}"; do
   echo " - $color"
done

# Find the length of the array
array_length=${#colors[@]}
echo "Number of colors: $array_length"

# Remove an element by value
color_to_remove="Blue"
colors=("${colors[@]/$color_to_remove}")

# Print the array after removal
echo "Colors after removing $color_to_remove: ${colors[@]}"