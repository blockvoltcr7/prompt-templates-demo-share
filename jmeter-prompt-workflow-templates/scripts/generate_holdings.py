#!/usr/bin/env python3
"""
Generate random holdings data for testing.

Creates a JSON file with random stock symbols in the testdata folder.
"""

import json
import random
import string
from pathlib import Path

# Configuration
NUM_HOLDINGS = 580  # Set this to the number of holdings you want to generate


def generate_random_symbol(length=4):
    """Generate a random uppercase alphabetic string."""
    return ''.join(random.choices(string.ascii_uppercase, k=length))


def generate_holdings_data(count):
    """Generate holdings data with the specified number of random symbols."""
    holdings = [generate_random_symbol() for _ in range(count)]
    return {"holdings": holdings}


def main():
    # Determine the output file path
    script_dir = Path(__file__).parent
    testdata_dir = script_dir.parent / "testdata"
    
    # Generate random number suffix
    random_suffix = ''.join(random.choices(string.digits, k=6))
    output_file = testdata_dir / f"holdings_{NUM_HOLDINGS}_{random_suffix}.json"
        
    # Ensure testdata directory exists
    testdata_dir.mkdir(exist_ok=True)
    
    # Generate the data
    data = generate_holdings_data(NUM_HOLDINGS)
    
    # Write to JSON file
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2)
    
    print(f"✅ Generated {NUM_HOLDINGS} holdings")
    print(f"📁 Output file: {output_file}")
    print(f"📊 Sample: {data['holdings'][:5]}{'...' if len(data['holdings']) > 5 else ''}")


if __name__ == "__main__":
    main()
