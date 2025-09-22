#!/bin/bash

# ========================================
# TMM-WEB BACKUP SCRIPT
# ========================================
# Comprehensive backup solution for Thapelo Masebe's portfolio website

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
PROJECT_NAME="tmm-web"
BACKUP_ROOT="../tmm-web-backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$BACKUP_ROOT/tmm-web-backup-$TIMESTAMP"
MAX_BACKUPS=10

echo -e "${BLUE}💾 TMM-WEB BACKUP SCRIPT${NC}"
echo -e "${BLUE}========================${NC}"

# Function to create directory structure
create_backup_structure() {
    echo -e "${BLUE}Creating backup directory structure...${NC}"
    
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$BACKUP_DIR/assets/images/portfolio"
    mkdir -p "$BACKUP_DIR/css"
    mkdir -p "$BACKUP_DIR/js"
    mkdir -p "$BACKUP_DIR/docs"
    
    echo -e "${GREEN}✅ Backup structure created${NC}"
}

# Function to backup core files
backup_core_files() {
    echo -e "${BLUE}Backing up core files...${NC}"
    
    # HTML files
    cp index.html "$BACKUP_DIR/"
    cp archive.html "$BACKUP_DIR/"
    
    # CSS files
    cp -r css/ "$BACKUP_DIR/"
    
    # JavaScript files
    cp -r js/ "$BACKUP_DIR/"
    
    # PWA files
    cp manifest.json "$BACKUP_DIR/"
    cp sw.js "$BACKUP_DIR/"
    
    # Documentation files
    cp *.md "$BACKUP_DIR/docs/" 2>/dev/null || true
    
    # Scripts
    cp *.sh "$BACKUP_DIR/" 2>/dev/null || true
    
    echo -e "${GREEN}✅ Core files backed up${NC}"
}

# Function to backup assets
backup_assets() {
    echo -e "${BLUE}Backing up assets...${NC}"
    
    if [ -d "assets" ]; then
        cp -r assets/ "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Assets backed up${NC}"
    else
        echo -e "${YELLOW}⚠️  No assets directory found${NC}"
    fi
}

# Function to backup git repository
backup_git() {
    echo -e "${BLUE}Backing up git repository...${NC}"
    
    if [ -d ".git" ]; then
        cp -r .git "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Git repository backed up${NC}"
    else
        echo -e "${YELLOW}⚠️  No git repository found${NC}"
    fi
}

# Function to create backup manifest
create_backup_manifest() {
    echo -e "${BLUE}Creating backup manifest...${NC}"
    
    cat > "$BACKUP_DIR/BACKUP_MANIFEST.txt" << EOF
TMM-WEB Backup Manifest
=======================
Backup Date: $(date)
Backup Type: Full Site Backup
Project: $PROJECT_NAME
Version: $(git rev-parse --short HEAD 2>/dev/null || echo "Unknown")

Files Included:
- HTML: index.html, archive.html
- CSS: css/ directory
- JavaScript: js/ directory
- Assets: assets/ directory
- PWA: manifest.json, sw.js
- Documentation: *.md files
- Scripts: *.sh files
- Git: .git/ directory

Backup Size: $(du -sh "$BACKUP_DIR" | cut -f1)
Total Files: $(find "$BACKUP_DIR" -type f | wc -l)

Restore Instructions:
1. Copy backup directory to desired location
2. Run: chmod +x *.sh
3. Run: ./deploy.sh
4. Test site functionality

Created by: TMM-WEB Backup Script
EOF
    
    echo -e "${GREEN}✅ Backup manifest created${NC}"
}

# Function to compress backup
compress_backup() {
    echo -e "${BLUE}Compressing backup...${NC}"
    
    cd "$BACKUP_ROOT"
    tar -czf "tmm-web-backup-$TIMESTAMP.tar.gz" "tmm-web-backup-$TIMESTAMP"
    rm -rf "tmm-web-backup-$TIMESTAMP"
    
    echo -e "${GREEN}✅ Backup compressed: tmm-web-backup-$TIMESTAMP.tar.gz${NC}"
    echo -e "${BLUE}Backup size: $(du -sh "tmm-web-backup-$TIMESTAMP.tar.gz" | cut -f1)${NC}"
    
    cd - > /dev/null
}

# Function to clean old backups
clean_old_backups() {
    echo -e "${BLUE}Cleaning old backups...${NC}"
    
    cd "$BACKUP_ROOT"
    
    # Count current backups
    BACKUP_COUNT=$(ls -1 tmm-web-backup-*.tar.gz 2>/dev/null | wc -l)
    
    if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
        echo -e "${YELLOW}Found $BACKUP_COUNT backups, keeping only $MAX_BACKUPS${NC}"
        
        # Remove oldest backups
        ls -1t tmm-web-backup-*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm -f
        
        echo -e "${GREEN}✅ Old backups cleaned${NC}"
    else
        echo -e "${BLUE}Backup count ($BACKUP_COUNT) within limit ($MAX_BACKUPS)${NC}"
    fi
    
    cd - > /dev/null
}

# Function to verify backup
verify_backup() {
    echo -e "${BLUE}Verifying backup...${NC}"
    
    BACKUP_FILE="$BACKUP_ROOT/tmm-web-backup-$TIMESTAMP.tar.gz"
    
    if [ -f "$BACKUP_FILE" ]; then
        echo -e "${GREEN}✅ Backup file exists${NC}"
        
        # Test archive integrity
        if tar -tzf "$BACKUP_FILE" > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Backup archive is valid${NC}"
        else
            echo -e "${RED}❌ Backup archive is corrupted${NC}"
            return 1
        fi
        
        # Check file count
        FILE_COUNT=$(tar -tzf "$BACKUP_FILE" | wc -l)
        echo -e "${BLUE}Files in backup: $FILE_COUNT${NC}"
        
        # Check size
        BACKUP_SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
        echo -e "${BLUE}Backup size: $BACKUP_SIZE${NC}"
        
    else
        echo -e "${RED}❌ Backup file not found${NC}"
        return 1
    fi
}

# Function to list available backups
list_backups() {
    echo -e "${BLUE}Available backups:${NC}"
    
    if [ -d "$BACKUP_ROOT" ]; then
        ls -la "$BACKUP_ROOT" | grep "tmm-web-backup-" | awk '{print $9, $6, $7, $8, $5}' | while read name date1 date2 date3 size; do
            echo -e "${BLUE}$name${NC} - $date1 $date2 $date3 ($size)"
        done
    else
        echo -e "${YELLOW}No backup directory found${NC}"
    fi
}

# Function to restore from backup
restore_backup() {
    echo -e "${BLUE}Restore from backup${NC}"
    
    list_backups
    
    read -p "Enter backup name to restore: " backup_name
    
    BACKUP_FILE="$BACKUP_ROOT/$backup_name"
    
    if [ -f "$BACKUP_FILE" ]; then
        echo -e "${BLUE}Restoring from $backup_name...${NC}"
        
        # Create restore directory
        RESTORE_DIR="../tmm-web-restore-$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$RESTORE_DIR"
        
        # Extract backup
        tar -xzf "$BACKUP_FILE" -C "$RESTORE_DIR"
        
        echo -e "${GREEN}✅ Backup restored to $RESTORE_DIR${NC}"
        echo -e "${BLUE}To use restored backup:${NC}"
        echo "1. cd $RESTORE_DIR"
        echo "2. Run: ./deploy.sh"
        
    else
        echo -e "${RED}Backup not found: $backup_name${NC}"
    fi
}

# Function to create incremental backup
create_incremental_backup() {
    echo -e "${BLUE}Creating incremental backup...${NC}"
    
    # Find latest backup
    LATEST_BACKUP=$(ls -1t "$BACKUP_ROOT"/tmm-web-backup-*.tar.gz 2>/dev/null | head -1)
    
    if [ -n "$LATEST_BACKUP" ]; then
        echo -e "${BLUE}Latest backup: $LATEST_BACKUP${NC}"
        
        # Create incremental backup
        INCREMENTAL_DIR="$BACKUP_ROOT/tmm-web-incremental-$TIMESTAMP"
        mkdir -p "$INCREMENTAL_DIR"
        
        # Copy only changed files
        rsync -av --compare-dest="$LATEST_BACKUP" . "$INCREMENTAL_DIR/"
        
        # Compress incremental backup
        cd "$BACKUP_ROOT"
        tar -czf "tmm-web-incremental-$TIMESTAMP.tar.gz" "tmm-web-incremental-$TIMESTAMP"
        rm -rf "tmm-web-incremental-$TIMESTAMP"
        
        echo -e "${GREEN}✅ Incremental backup created${NC}"
        cd - > /dev/null
    else
        echo -e "${YELLOW}No previous backup found, creating full backup${NC}"
        create_full_backup
    fi
}

# Function to create full backup
create_full_backup() {
    echo -e "${BLUE}Creating full backup...${NC}"
    
    create_backup_structure
    backup_core_files
    backup_assets
    backup_git
    create_backup_manifest
    compress_backup
    clean_old_backups
    verify_backup
    
    echo -e "${GREEN}🎉 Full backup completed successfully!${NC}"
    echo -e "${BLUE}Backup location: $BACKUP_ROOT/tmm-web-backup-$TIMESTAMP.tar.gz${NC}"
}

# Function to schedule automatic backups
schedule_backups() {
    echo -e "${BLUE}Setting up automatic backups...${NC}"
    
    # Create cron job for daily backups
    CRON_JOB="0 2 * * * cd $(pwd) && ./backup.sh --auto"
    
    echo -e "${YELLOW}Add this cron job for daily backups at 2 AM:${NC}"
    echo "$CRON_JOB"
    echo ""
    echo -e "${BLUE}To add to crontab:${NC}"
    echo "crontab -e"
    echo "Then add the line above"
}

# Function to backup to cloud
backup_to_cloud() {
    echo -e "${BLUE}Cloud backup options:${NC}"
    echo "1) Google Drive (using rclone)"
    echo "2) Dropbox (using rclone)"
    echo "3) AWS S3 (using aws cli)"
    echo "4) Manual cloud backup"
    
    read -p "Choose option (1-4): " option
    
    case $option in
        1)
            if command -v rclone >/dev/null 2>&1; then
                echo -e "${BLUE}Uploading to Google Drive...${NC}"
                rclone copy "$BACKUP_ROOT" "gdrive:tmm-web-backups"
                echo -e "${GREEN}✅ Uploaded to Google Drive${NC}"
            else
                echo -e "${YELLOW}⚠️  rclone not installed. Install with: brew install rclone${NC}"
            fi
            ;;
        2)
            if command -v rclone >/dev/null 2>&1; then
                echo -e "${BLUE}Uploading to Dropbox...${NC}"
                rclone copy "$BACKUP_ROOT" "dropbox:tmm-web-backups"
                echo -e "${GREEN}✅ Uploaded to Dropbox${NC}"
            else
                echo -e "${YELLOW}⚠️  rclone not installed. Install with: brew install rclone${NC}"
            fi
            ;;
        3)
            if command -v aws >/dev/null 2>&1; then
                echo -e "${BLUE}Uploading to AWS S3...${NC}"
                aws s3 sync "$BACKUP_ROOT" "s3://your-bucket/tmm-web-backups"
                echo -e "${GREEN}✅ Uploaded to AWS S3${NC}"
            else
                echo -e "${YELLOW}⚠️  AWS CLI not installed. Install with: brew install awscli${NC}"
            fi
            ;;
        4)
            echo -e "${BLUE}Manual cloud backup instructions:${NC}"
            echo "1. Upload backup files to your preferred cloud storage"
            echo "2. Organize in folder: tmm-web-backups/"
            echo "3. Keep multiple versions for redundancy"
            echo "4. Test restore process periodically"
            ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
}

# Main function
main() {
    # Handle command line arguments
    if [ "$1" = "--auto" ]; then
        echo -e "${BLUE}Running automatic backup...${NC}"
        create_full_backup
        exit 0
    fi
    
    echo -e "${BLUE}Choose backup option:${NC}"
    echo "1) Create full backup"
    echo "2) Create incremental backup"
    echo "3) List available backups"
    echo "4) Restore from backup"
    echo "5) Schedule automatic backups"
    echo "6) Backup to cloud"
    echo "7) Verify existing backups"
    
    read -p "Enter choice (1-7): " choice
    
    case $choice in
        1) create_full_backup ;;
        2) create_incremental_backup ;;
        3) list_backups ;;
        4) restore_backup ;;
        5) schedule_backups ;;
        6) backup_to_cloud ;;
        7) verify_backup ;;
        *) echo -e "${RED}Invalid choice${NC}" && exit 1 ;;
    esac
}

# Run main function
main "$@"
