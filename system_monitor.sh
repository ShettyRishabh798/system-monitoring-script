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

# Function to log a message to the log file with a timestamp
log_alert() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# -----------------------------------------------------------------------------
# FEATURE 1 — Disk Usage Monitor
# -----------------------------------------------------------------------------
check_disk_usage() {
    print_header "DISK USAGE MONITOR"

    # df -H shows disk usage in human-readable sizes
    # We skip the first header line with 'tail -n +2'
    # awk extracts the Use% column (column 5) and the mount point (column 6)
    df -H | tail -n +2 | awk '{print $5, $6}' | while read -r usage mount; do

        # Remove the % sign so we can compare it as a number
        usage_num=${usage%%%}

        # Only process lines where usage is actually a number
        # (some special filesystems return non-numeric values)
        if [[ "$usage_num" =~ ^[0-9]+$ ]]; then

            if [ "$usage_num" -ge "$DISK_THRESHOLD" ]; then
                # ALERT — usage is at or above threshold
                echo -e "${RED}[ALERT] Disk usage on $mount is at ${usage} — exceeds threshold of ${DISK_THRESHOLD}%${NC}"
                log_alert "DISK ALERT: $mount is at ${usage} (threshold: ${DISK_THRESHOLD}%)"
            else
                # OK — usage is below threshold
                echo -e "${GREEN}[OK]    Disk usage on $mount is at ${usage}${NC}"
            fi

        fi
    done
}

# -----------------------------------------------------------------------------
# FEATURE 2 — Memory Usage Monitor
# -----------------------------------------------------------------------------
check_memory_usage() {
    print_header "MEMORY USAGE MONITOR"

    # free -m shows memory in megabytes
    # We grab the 'Mem:' line, then extract total (col 2) and used (col 3)
    total_mem=$(free -m | awk '/^Mem:/ {print $2}')
    used_mem=$(free -m | awk '/^Mem:/ {print $3}')

    # Calculate usage percentage (integer division is fine here)
    mem_usage_percent=$(( used_mem * 100 / total_mem ))

    echo "Total Memory : ${total_mem} MB"
    echo "Used Memory  : ${used_mem} MB"
    echo "Usage        : ${mem_usage_percent}%"
    echo ""

    if [ "$mem_usage_percent" -ge "$MEMORY_THRESHOLD" ]; then
        echo -e "${RED}[ALERT] Memory usage is at ${mem_usage_percent}% — exceeds threshold of ${MEMORY_THRESHOLD}%${NC}"
        log_alert "MEMORY ALERT: Usage is at ${mem_usage_percent}% (threshold: ${MEMORY_THRESHOLD}%)"
    else
        echo -e "${GREEN}[OK]    Memory usage is at ${mem_usage_percent}% — within safe limits${NC}"
    fi
}


# -----------------------------------------------------------------------------
# MAIN — This is where the script starts executing
# -----------------------------------------------------------------------------

echo ""
echo "====================================================="
echo "       SYSTEM MONITOR — $(date '+%Y-%m-%d %H:%M:%S')"
echo "====================================================="
echo "Thresholds set — Disk: ${DISK_THRESHOLD}%  Memory: ${MEMORY_THRESHOLD}%"

# Call the disk usage function
check_disk_usage

echo ""
echo "====================================================="
echo "  Monitoring complete. Log saved to: $LOG_FILE"
echo "====================================================="
echo ""

