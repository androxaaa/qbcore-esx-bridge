# qbcore-esx-bridge

## Overview

The `qbcore-esx-bridge` is a compatibility layer that allows QB-Core scripts to function seamlessly with your ESX-based `es_extended`. It acts as an intermediary by translating data structures, converting events, and mapping essential functions between the two frameworks.

## Installation Instructions

1. **Create a new resource folder**:
   - Navigate to your server’s resources directory and create a folder named `qb-core`.

2. **Add Files**:
   - Copy all files from the artifacts above into this newly created folder.

3. **Modify `server.cfg`**:
   - In your `server.cfg`, ensure that `qb-core` is added in the correct loading order:
     - `ensure es_extended` (should be first)
     - `ensure qb-core` (should be second)
     - All other QB-Core scripts (should follow after `qb-core`)

   The correct order is essential for proper functionality.

## Key Features

- **Player Data Conversion**: Transforms player data between ESX and QB-Core formats.
- **Inventory Functionality**: Maps inventory-related functions between the frameworks.
- **Money Transactions**: Handles money transactions across both frameworks.
- **Notifications Compatibility**: Ensures notifications work across both systems.
- **Job Information Mapping**: Converts job data structures for compatibility.
- **Callback System**: Implements a robust callback system between ESX and QB-Core.
- **Item Data Mapping**: Standardizes item data structures between the two frameworks.

## Notes & Limitations

- This bridge provides basic functionality for common operations. Depending on the QB-Core scripts you intend to use, additional functions may need to be added.
- Certain QB-Core features, such as gangs, cryptocurrency, and duty systems, do not have direct equivalents in ESX. Placeholder values are provided for these features.
- If you encounter errors with specific QB-Core scripts, additional functionality may need to be implemented in the bridge, or the scripts themselves might require modification.
- For complex scripts that rely heavily on QB-Core-specific features, you may need to create custom middleware or make script modifications to ensure full compatibility.

## Contributions

Contributions are welcome! I will not provide support as I made this for funs.

---
