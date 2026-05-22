# System Monitoring and Alerting Script

A shell script that monitors key system resources on a Linux server and alerts
when predefined thresholds are crossed. Built as part of the DevOps Institute
Mumbai Capstone Project.

---

## What It Does

| Feature | Description |
|---|---|
| Disk Monitor | Checks all mounted partitions and alerts if usage exceeds threshold |
| Memory Monitor | Checks RAM usage and alerts if usage exceeds threshold |
| Top Processes | Shows top 5 processes by CPU and Memory consumption |
| Run Summary | Displays total alerts fired and final system status |
| Alert Logging | All alerts are saved to `monitor.log` with timestamps |

---

## Requirements

- Linux system (tested on Ubuntu 22.04 on AWS EC2)
- Bash shell
- Standard Linux tools: `df`, `free`, `ps`, `awk`, `mktemp`

---

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/system-monitoring-script.git
cd system-monitoring-script
```

### 2. Make the script executable

```bash
chmod +x system_monitor.sh
```

### 3. Run the script

```bash
./system_monitor.sh
```

---

## Configuration

Open `system_monitor.sh` and edit the values at the top of the file:

```bash
DISK_THRESHOLD=80      # Alert if any disk partition exceeds 80% usage
MEMORY_THRESHOLD=80    # Alert if RAM usage exceeds 80%
CPU_TOP_COUNT=5        # Number of top processes to display
LOG_FILE="monitor.log" # Path to the alert log file
```

---

## Sample Output

