#!/data/data/com.termux/files/usr/bin/bash

echo -e "\033[1;32m[*] Memulai Instalasi Tampilan Cyber Security...\033[0m"
pkg update -y > /dev/null 2>&1
pkg install figlet cmatrix ncurses-utils -y > /dev/null 2>&1

# Minta input nama
echo -e "\033[1;32m[?] Siapa nama yang mau ditampilkan di layar?\033[0m"
read -p "    (Ketik nama, contoh: MEKI / BUDI / ZYN0X): " USER_NAME

# Kalau user gak ngetik apa-apa, default ke MEKI
if [ -z "$USER_NAME" ]; then
    USER_NAME="MEKI"
fi

# Simpan nama ke file config
echo "$USER_NAME" > ~/.cyber_name

# Bikin script tampilannya
cat << 'EOF' > ~/.cyber_ui.sh
#!/data/data/com.termux/files/usr/bin/bash
NAME=$(cat ~/.cyber_name)
GREEN='\033[1;32m'
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "\n"

# 1. MATRIX
echo -e "${GREEN}Booting Secure Connection...${NC}"
sleep 0.2
timeout 1.5 cmatrix -C green -s
clear
echo -e "\n"

# 2. LOADING BAR
function cyber_load() {
    echo -ne "${GREEN}[*] $1 ["
    for i in {1..8}; do echo -ne "="; sleep 0.03; done
    echo -e "] OK${NC}"
}
cyber_load "Bypassing Firewall"
cyber_load "Decrypting Payload"
cyber_load "Mounting System   "
sleep 0.2
clear
echo -e "\n"

# 3. BANNER DINAMIS (Huruf Besar Sesuai Input)
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}"
figlet -w 40 -c -f standard "$NAME"
echo -e "${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}          [ 鎖 SYSTEM SECURED ]${NC}"
echo -e "${GREEN}========================================${NC}"

# 4. DASHBOARD
echo -e " ${GREEN}[+]${NC} STATUS   : ${WHITE}COMPROMISED${NC}"
echo -e " ${GREEN}[+]${NC} OPERATOR : ${WHITE}$NAME${NC}"
echo -e " ${GREEN}[+]${NC} AUTHOR   : ${WHITE}mekinjir${NC}"
echo -e " ${GREEN}[+]${NC} ACCESS   : ${WHITE}ROOT / ADMIN${NC}"
echo -e " ${GREEN}[+]${NC} DEVICE   : ${WHITE}SECURE-NODE-01${NC}"
echo -e " ${GREEN}[+]${NC} KERNEL   : ${WHITE}cyber-kernel-6.6${NC}"
echo -e " ${GREEN}[+]${NC} NETWORK  : ${WHITE}ENCRYPTED${NC}"
echo -e " ${GREEN}[+]${NC} TIME     : ${WHITE}$(date +%H:%M:%S)${NC}"
echo -e " ${GREEN}[+]${NC} DATE     : ${WHITE}$(date +%d-%m-%Y)${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
EOF

chmod +x ~/.cyber_ui.sh

# Hapus script lama (kalau ada)
sed -i '/.cyber_ui.sh/d' ~/.bashrc
sed -i '/.meki_green.sh/d' ~/.bashrc
sed -i '/.meki_ui.sh/d' ~/.bashrc
sed -i '/PS1=.*❯/d' ~/.bashrc

# Daftarkan ke bashrc
echo "~/.cyber_ui.sh" >> ~/.bashrc
echo "PS1='\[\e[1;32m\]❯ \[\e[0m\]'" >> ~/.bashrc
echo "source ~/.bashrc" > ~/.bash_profile

echo -e "\033[1;32m[+] INSTALASI BERHASIL!\033[0m"
echo -e "\033[1;32m[+] Nama yang dipakai: $USER_NAME\033[0m"
echo -e "\033[1;32m[+] Silakan tutup Termux dan buka lagi.\033[0m"

# Jalanin langsung
source ~/.bashrc
