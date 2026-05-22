#!/bin/bash

# =============================================================================
# Script Name : system_monitor.sh
# Description : Monitors disk, memory, and CPU usage on a Linux system.
#               Displays alerts when usage crosses defined thresholds.
#               Logs all alerts to a log file with timestamps.
# Author      : Your Name
# Created     : $(date +%Y-%m-%d)
# =============================================================================

# -----------------------------------------------------------------------------
# CONFIGURATION — Edit these thresholds to suit your environment
# -----------------------------------------------------------------------------
DISK_THRESHOLD=80       # Alert if disk usage % exceeds this value
MEMORY_THRESHOLD=80     # Alert if memory usage % exceeds this value
CPU_TOP_COUNT=5         # Number of top CPU-consuming processes to display
LOG_FILE="monitor.log"  # Log file where alerts will be saved

# -----------------------------------------------------------------------------
# COLORS — Makes terminal output easier to read
# -----------------------------------------------------------------------------
RED='\033[0;31m'        # Used for critical alerts
YELLOW='\033[1;33m'     # Used for warnings
GREEN='\033[0;32m'      # Used for OK status
NC='\033[0m'            # NC = No Color, resets color back to normal

# -----------------------------------------------------------------------------
# FUNCTIONS — Each monitoring feature will be its own function
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo ""
    echo "============================================="
    echo "  $1"
    echo "============================================="
}

# -----------------------------------------------------------------------------
# MAIN — This is where the script starts executing
# -----------------------------------------------------------------------------

echo ""
echo "====================================================="
echo "       SYSTEM MONITOR — $(date '+%Y-%m-%d %H:%M:%S')"
echo "====================================================="
echo "Thresholds set — Disk: ${DISK_THRESHOLD}%  Memory: ${MEMORY_THRESHOLD}%"
echo ""
echo "Script is ready. Features coming soon..."
