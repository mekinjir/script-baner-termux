#!/data/data/com.termux/files/usr/bin/bash

clear
echo -e "\033[1;36m==========================================\033[0m"
echo -e "\033[1;37m      INSTALLER BANNER TERMUX CYBER       \033[0m"
echo -e "\033[1;36m==========================================\033[0m"
echo ""

# 1. Input Nama
read -p " [>] Masukkan Nama (tanpa spasi): " U_NAME
if [ -z "$U_NAME" ]; then U_NAME="USER"; fi
echo "$U_NAME" > ~/.tx_name

# 2. Pilih Warna (Banyak Pilihan)
echo -e "\n [>] Pilih Warna Tema:"
echo "     1. Hijau (Hacker)"
echo "     2. Merah (Blood/Cyber)"
echo "     3. Cyan (Futuristic)"
echo "     4. Ungu (Neon/Vaporwave)"
echo "     5. Biru (Ocean/Deep Web)"
echo "     6. Kuning (Warning System)"
read -p "     Pilih (1-6): " U_COLOR

case $U_COLOR in
    1) COLOR_CODE='\033[1;32m'; MATRIX_COLOR='green';;
    2) COLOR_CODE='\033[1;31m'; MATRIX_COLOR='red';;
    3) COLOR_CODE='\033[1;36m'; MATRIX_COLOR='cyan';;
    4) COLOR_CODE='\033[1;35m'; MATRIX_COLOR='magenta';;
    5) COLOR_CODE='\033[1;34m'; MATRIX_COLOR='blue';;
    6) COLOR_CODE='\033[1;33m'; MATRIX_COLOR='yellow';;
    *) COLOR_CODE='\033[1;32m'; MATRIX_COLOR='green';;
esac
echo "$COLOR_CODE" > ~/.tx_color
echo "$MATRIX_COLOR" > ~/.tx_matrix

# 3. Proses Instalasi Dependencies
echo -e "\n [*] Menginstall dependencies (Mohon tunggu)..."
pkg update -y > /dev/null 2>&1
pkg install figlet cmatrix ncurses-utils -y > /dev/null 2>&1

# 4. Membuat Script Utama (UI)
cat << 'EOF' > ~/.termux_ui.sh
#!/data/data/com.termux/files/usr/bin/bash

NAME=$(cat ~/.tx_name)
COLOR=$(cat ~/.tx_color)
MATRIX=$(cat ~/.tx_matrix)
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "\n"

# Efek Matrix
echo -e "${COLOR}Initializing Secure Node...${NC}"
sleep 0.2
timeout 1.5 cmatrix -C $MATRIX -s
clear
echo -e "\n"

# Banner ASCII (Tengah)
echo -e "${COLOR}========================================${NC}"
echo -e "${COLOR}"
figlet -w 40 -c -f standard "$NAME"
echo -e "${NC}"
echo -e "${COLOR}========================================${NC}"
echo -e "        ${COLOR}[ 鎖 SYSTEM SECURED ]${NC}"
echo -e "${COLOR}========================================${NC}"

# Dashboard Info (Rapi & Berwarna)
echo -e " ${COLOR}[+]${NC} STATUS   : ${WHITE}COMPROMISED${NC}"
echo -e " ${COLOR}[+]${NC} OPERATOR : ${WHITE}$NAME${NC}"
echo -e " ${COLOR}[+]${NC} AUTHOR   : ${WHITE}mekinjir${NC}"
echo -e " ${COLOR}[+]${NC} ACCESS   : ${WHITE}ROOT / ADMIN${NC}"
echo -e " ${COLOR}[+]${NC} DEVICE   : ${WHITE}SECURE-NODE-01${NC}"
echo -e " ${COLOR}[+]${NC} KERNEL   : ${WHITE}cyber-kernel-6.6${NC}"
echo -e " ${COLOR}[+]${NC} NETWORK  : ${WHITE}ENCRYPTED${NC}"
echo -e " ${COLOR}[+]${NC} TIME     : ${WHITE}$(date +%H:%M:%S)${NC}"
echo -e " ${COLOR}[+]${NC} DATE     : ${WHITE}$(date +%d-%m-%Y)${NC}"
echo -e "${COLOR}========================================${NC}"

# Teks Welcome
echo -e "${COLOR}Working with packages:${NC}"
echo -e "  Search:  pkg search <query>"
echo -e "  Install: pkg install <package>"
echo -e "  Update:  pkg update"
echo -e "${COLOR}========================================${NC}"
echo ""
EOF

chmod +x ~/.termux_ui.sh

# 5. Bersihkan .bashrc lama & pasang yang baru
sed -i '/.termux_ui.sh/d' ~/.bashrc
sed -i '/.cyber_ui.sh/d' ~/.bashrc
sed -i '/.meki_green.sh/d' ~/.bashrc
sed -i '/.meki_ui.sh/d' ~/.bashrc
sed -i '/PS1=.*❯/d' ~/.bashrc

echo "~/.termux_ui.sh" >> ~/.bashrc
echo "PS1='\[$COLOR_CODE\]❯ \[\033[0m\]'" >> ~/.bashrc
echo "source ~/.bashrc" > ~/.bash_profile

# 6. Selesai
echo -e "\n${COLOR}[+] INSTALASI BERHASIL!${NC}"
echo -e "${COLOR}[+] Nama: $NAME | Warna telah disimpan.${NC}"
echo -e "${COLOR}[+] Silakan tutup Termux dan buka lagi.${NC}"

# Jalanin langsung
source ~/.bashrc
