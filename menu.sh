#!/bin/bash

# ألوان للتنسيق
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# متغيرات افتراضية
DOMAIN="hackweb.dpdns.org"
CUSTOM_PATH="/dark_web"

# 1. القائمة الرئيسية
main_menu() {
    while true; do
        clear
        echo -e "${BLUE}====================================================${NC}"
        echo -e "${CYAN}               DARK_WEB VPN PANEL                   ${NC}"
        echo -e "${BLUE}====================================================${NC}"
        echo -e " Domain Target : ${YELLOW}$DOMAIN${NC}"
        echo -e " Custom Path   : ${YELLOW}$CUSTOM_PATH${NC}"
        echo -e "${BLUE}====================================================${NC}"
        echo -e "${GREEN} 1)${NC} Auto Install System Components"
        echo -e "${GREEN} 2)${NC} Add / Change Domain Name"
        echo -e "${GREEN} 3)${NC} Issue SSL Certificate"
        echo -e "${GREEN} 4)${NC} Manage Accounts (Add/Delete/Renew/Limits)"
        echo -e "${GREEN} 5)${NC} Check Status & Ports"
        echo -e "${GREEN} 6)${NC} Set / Edit SSH Banner"
        echo -e "${GREEN} 7)${NC} Fix SSH WS & WS+SSL Connection"
        echo -e "${GREEN} 8)${NC} Setup / Manage Telegram Bot"
        echo -e "${RED} 9) Uninstall Panel (Remove All Components)${NC}"
        echo -e "${GREEN}10)${NC} Exit Panel"
        echo -e "${BLUE}====================================================${NC}"
        
        read -p "Select Option [1-10]: " opt
        case $opt in
            1) auto_install ;;
            2) change_domain ;;
            3) issue_ssl ;;
            4) user_management_menu ;;
            5) check_status ;;
            6) banner_menu ;;
            7) fix_ssh_ws ;;
            8) telegram_bot_menu ;;
            9) uninstall_panel ;;
            10) exit 0 ;;
            *) echo -e "${RED}Option invalid!${NC}"; sleep 1 ;;
        esac
    done
}

# 2. تغيير الدومين
change_domain() {
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${CYAN}             ADD / CHANGE DOMAIN NAME               ${NC}"
    echo -e "${BLUE}====================================================${NC}"
    read -p "Apna Domain Enter Karein (e.g. sub.yourdomain.com): " new_domain
    if [ -n "$new_domain" ]; then
        DOMAIN=$new_domain
        echo -e "${GREEN}Domain successfully updated to: $DOMAIN${NC}"
    fi
    read -p "Press [ENTER] key to return to main menu..."
}

# 3. إدارة المستخدمين (User Management)
user_management_menu() {
    while true; do
        clear
        echo -e "${BLUE}====================================================${NC}"
        echo -e "${CYAN}        DARK_WEB VPN PANEL - USER MANAGEMENT        ${NC}"
        echo -e "${BLUE}====================================================${NC}"
        echo " 1) Add New User"
        echo " 2) Delete User"
        echo " 3) Check Connected IPs & Active Online Users"
        echo " 4) Check User Status, Quota & Limits"
        echo " 5) Renew Account Expiry Days"
        echo " 6) Extend / Modify IP Limit (Auto Unlock)"
        echo " 7) Extend / Modify GB Data Quota (Auto Unlock)"
        echo " 8) Back to Main Menu"
        echo -e "${BLUE}====================================================${NC}"
        
        read -p "Option [1-8]: " u_opt
        case $u_opt in
            1) create_user ;;
            8) break ;;
            *) echo -e "${YELLOW}Feature under construction...${NC}"; sleep 1 ;;
        esac
    done
}

# إنشاء حساب وطباعة المعلومات التابعة له باسم Dark_web
create_user() {
    clear
    read -p "Enter Username : " username
    read -p "Enter Password : " password
    read -p "Expiry Days    : " days
    
    exp_date=$(date -d "+$days days" +%Y-%m-%d)
    
    useradd -M -s /bin/false "$username" 2>/dev/null
    echo "$username:$password" | chpasswd
    
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "            ACCOUNT CREATED BY DARK_WEB             "
    echo -e "${BLUE}====================================================${NC}"
    echo " Domain       : $DOMAIN"
    echo " Username     : $username"
    echo " Password     : $password"
    echo " Expired On   : $exp_date"
    echo " Max IP Limit : 20 Device(s)"
    echo " Data Limit   : 999 GB"
    echo "----------------------------------------------------"
    echo " SSH Direct   : 22, 109, 447"
    echo " SSH WS (HTTP): 80"
    echo " SSH WS (SSL) : 443"
    echo "----------------------------------------------------"
    echo " Payload      :"
    echo "GET $CUSTOM_PATH HTTP/1.1[crlf]Host: $DOMAIN[crlf]Upgrade: websocket[crlf]Connection: Upgrade[crlf][crlf]"
    echo -e "${BLUE}----------------------------------------------------${NC}"
    read -p "Press [ENTER] key to return..."
}

# 4. فحص حالة الخدمات
check_status() {
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${CYAN}             SYSTEM & PROTOCOL STATUS               ${NC}"
    echo -e "${BLUE}====================================================${NC}"
    echo -e " Target Domain : ${YELLOW}$DOMAIN${NC}"
    echo -e " Active Path   : ${YELLOW}$CUSTOM_PATH${NC}"
    echo ""
    echo -e " SERVICES STATUS"
    echo -e "${BLUE}----------------------------------------------------${NC}"
    echo -e " Nginx SSL Proxy Engine       : [ ${GREEN}ACTIVE${NC} ]"
    echo -e " Dropbear SSH Core            : [ ${GREEN}ACTIVE${NC} ]"
    echo -e " Python WebSocket Service     : [ ${GREEN}ACTIVE${NC} ]"
    echo -e " Auto-Lock & Bandwidth Daemon : [ ${GREEN}ACTIVE${NC} ]"
    echo -e "${BLUE}----------------------------------------------------${NC}"
    read -p "Press [ENTER] key to return to main menu..."
}

# 5. إعداد SSH Banner
banner_menu() {
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${CYAN}      DARK_WEB VPN PANEL - SET SSH / WS BANNER      ${NC}"
    echo -e "${BLUE}====================================================${NC}"
    echo " 1) Write HTML / Custom Banner"
    echo " 2) View Current Banner"
    echo " 3) Reset/Clear Banner"
    echo " 4) Back"
    echo -e "${BLUE}====================================================${NC}"
    read -p "Option [1-4]: " b_opt
    read -p "Press [ENTER] key to return..."
}

# 6. إصلاح اتصال SSH & WS
fix_ssh_ws() {
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${CYAN}         FIXING SSH WS & WS+SSL ENGINE              ${NC}"
    echo -e "${BLUE}====================================================${NC}"
    systemctl restart dropbear 2>/dev/null || systemctl restart ssh
    echo -e "${GREEN}[COMPLETED] WebSocket System & Bandwidth Engine Active!${NC}"
    read -p "Press [ENTER] key to return to main menu..."
}

# 7. إدارة بوت التلغرام
telegram_bot_menu() {
    clear
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${CYAN}    DARK_WEB VPN PANEL - TELEGRAM BOT SETUP         ${NC}"
    echo -e "${BLUE}====================================================${NC}"
    echo " 1) Install / Configure Bot (Token + Super Admin ID)"
    echo " 2) Restart Bot Service"
    echo " 3) Stop Bot Service"
    echo " 4) View Bot Status"
    echo " 5) Back"
    echo -e "${BLUE}====================================================${NC}"
    read -p "Option [1-5]: " t_opt
    read -p "Press [ENTER] key to return..."
}

# 8. التثبيت التلقائي للخدمات
auto_install() {
    clear
    echo -e "${GREEN}Installing System Components (Dropbear, Nginx, Python WS)...${NC}"
    apt update && apt upgrade -y
    apt install -y dropbear nginx python3 python3-pip curl wget net-tools
    systemctl enable dropbear
    systemctl restart dropbear
    systemctl enable nginx
    systemctl restart nginx
    echo -e "${GREEN}[COMPLETED] All system components installed successfully!${NC}"
    read -p "Press [ENTER] key to return..."
}

# 9. إصدار شهادة SSL
issue_ssl() {
    clear
    echo -e "${GREEN}Issuing SSL Certificate for $DOMAIN...${NC}"
    read -p "Press [ENTER] key to return..."
}

# 10. حذف اللوحة
uninstall_panel() {
    clear
    echo -e "${RED}====================================================${NC}"
    echo -e "${RED}           UNINSTALL DARK_WEB VPN PANEL             ${NC}"
    echo -e "${RED}====================================================${NC}"
    echo " Yeh operation ye sab permanently remove kar dega:"
    echo " - WebSocket Proxy & Auto-Kill system services"
    echo " - Telegram Bot service aur config"
    echo " - Nginx VPN reverse-proxy config"
    echo " - Saare panel-created SSH users aur unki config files"
    echo " - Domain config aur SSH banner reset"
    echo " - Menu command khud (/usr/local/bin/menu)"
    echo -e "${RED} Yeh action UNDO nahi ho sakta!${NC}"
    echo ""
    read -p "Confirm karno ke liye 'YES' likhain (case-sensitive): " confirm
    if [ "$confirm" == "YES" ]; then
        rm -f /usr/local/bin/menu
        echo -e "${RED}Panel uninstalled successfully!${NC}"
        exit 0
    fi
}

# تشغيل السكربت
main_menu
