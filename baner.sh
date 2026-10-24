#!/data/data/com.termux/files/usr/bin/bash

# --- PENGAMAN CTRL+C ---
trap 'echo -e "\n\n\033[1;31m[-] Dibatalkan.\033[0m"; exit 1' 2

clear
echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;37m         MEKI BANNER MANAGER            \033[0m"
echo -e "\033[1;36m========================================\033[0m"
echo ""
echo -e " [1] \033[1;32mInstall / Ganti Tampilan Banner\033[0m"
echo -e " [2] \033[1;31mHapus Banner (Kembali ke Termux Biasa)\033[0m"
echo -e " [3] \033[1;37mKeluar (Exit)\033[0m"
echo -e "\033[1;36m========================================\033[0m"
echo -ne " Pilih menu (1/2/3) : "
read MENU

if [ "$MENU" == "2" ]; then
    echo -e "\n\033[1;31m[*] Menghapus banner...\033[0m"
    sed -i '/.termux_ui.sh/d' ~/.bashrc
    sed -i '/PS1=.*/d' ~/.bashrc
    rm -f ~/.termux_ui.sh
    echo -e "\033[1;32m[+] BERHASIL DIHAPUS!\033[0m"
    echo -e "Silakan tutup dan buka kembali Termux."
    exit 0
elif [ "$MENU" == "3" ]; then
    echo -e "\nKeluar..."
    exit 0
elif [ "$MENU" != "1" ]; then
    echo -e "\n\033[1;31m[-] Pilihan tidak valid.\033[0m"
    exit 1
fi

# --- PROSES INSTALL ---
clear
echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;36m"
figlet -w 40 -c -f standard "MEKI"
echo -e "\033[0m"
echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;37m             [ MEKI BANNER ]\033[0m"
echo -e "\033[1;36m========================================\033[0m"
echo ""

echo -e "\033[1;33m [+] MASUKKAN NAMA ANDA :\033[0m"
echo -ne "     \033[1;37m> \033[1;32m"
read U_NAME
if [ -z "$U_NAME" ]; then U_NAME="USER"; fi
echo "$U_NAME" > ~/.tx_name
echo -e "\033[0m"

echo -e "\033[1;36m----------------------------------------\033[0m"
echo -e "\033[1;33m [+] PILIH WARNA TEMA :\033[0m"
echo -e "     \033[1;32m[1]\033[0m Hijau  (Hacker Matrix)"
echo -e "     \033[1;31m[2]\033[0m Merah  (Blood Cyber)"
echo -e "     \033[1;36m[3]\033[0m Cyan   (Futuristic)"
echo -e "     \033[1;35m[4]\033[0m Ungu   (Neon Vaporwave)"
echo -e "     \033[1;34m[5]\033[0m Biru   (Deep Web)"
echo -e "     \033[1;33m[6]\033[0m Kuning (Warning System)"
echo -e "\033[1;36m----------------------------------------\033[0m"

while true; do
    echo -ne "\033[1;37m Pilih Angka (1-6) : \033[1;32m"
    read U_COLOR
    echo -e "\033[0m"
    case $U_COLOR in
        1) COLOR_CODE='\033[1;32m'; MATRIX_COLOR='green'; break;;
        2) COLOR_CODE='\033[1;31m'; MATRIX_COLOR='red'; break;;
        3) COLOR_CODE='\033[1;36m'; MATRIX_COLOR='cyan'; break;;
        4) COLOR_CODE='\033[1;35m'; MATRIX_COLOR='magenta'; break;;
        5) COLOR_CODE='\033[1;34m'; MATRIX_COLOR='blue'; break;;
        6) COLOR_CODE='\033[1;33m'; MATRIX_COLOR='yellow'; break;;
        *) echo -e "\033[1;31m [-] Pilihan gak ada, ketik 1-6.\033[0m";;
    esac
done

echo "$COLOR_CODE" > ~/.tx_color
echo "$MATRIX_COLOR" > ~/.tx_matrix

echo -e "\n${COLOR_CODE}[*] Memproses konfigurasi sistem...\033[0m"
sleep 0.5
echo -e "${COLOR_CODE}[*] Menginstall dependencies (Mohon Tunggu)...\033[0m"
pkg update -y > /dev/null 2>&1
pkg install figlet cmatrix ncurses-utils -y > /dev/null 2>&1

# --- BIKIN SCRIPT UI (DENGAN LOADING SCREEN) ---
cat << 'EOF' > ~/.termux_ui.sh
#!/data/data/com.termux/files/usr/bin/bash

NAME=$(cat ~/.tx_name)
COLOR=$(cat ~/.tx_color)
MATRIX=$(cat ~/.tx_matrix)
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "\n"
echo -e "${COLOR}Initializing Secure Node...${NC}"
sleep 0.5
# Matrix 2 detik biar pasti kelihatan
timeout 2 cmatrix -C $MATRIX -s
clear
echo -e "\n"

# Fake Loading Bar Cyber
echo -ne "${COLOR}[*] Loading Interface ["
for i in {1..15}; do echo -ne "█"; sleep 0.05; done
echo -e "] 100%${NC}"
sleep 0.4
clear
echo -e "\n"

echo -e "${COLOR}========================================${NC}"
echo -e "${COLOR}"
figlet -w 40 -c -f standard "$NAME"
echo -e "${NC}"
echo -e "${COLOR}========================================${NC}"
echo -e "        ${COLOR}[ SYSTEM SECURED ]${NC}"
echo -e "${COLOR}========================================${NC}"

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
echo ""
EOF

chmod +x ~/.termux_ui.sh

# Daftarkan ke bashrc
sed -i '/.termux_ui.sh/d' ~/.bashrc
sed -i '/PS1=.*/d' ~/.bashrc
echo "~/.termux_ui.sh" >> ~/.bashrc
echo "PS1='\[$COLOR_CODE\]❯ \[\033[0m\]'" >> ~/.bashrc
echo "source ~/.bashrc" > ~/.bash_profile

# Matikan pengaman
trap - 2

echo -e "\n${COLOR_CODE}========================================\033[0m"
echo -e "${COLOR_CODE}   [+] INSTALASI BERHASIL, $U_NAME!\033[0m"
echo -e "${COLOR_CODE}   [+] Menampilkan Hasil...\033[0m"
echo -e "${COLOR_CODE}========================================\033[0m"
sleep 1

# --- PANGGIL TAMPILAN LANGSUNG DI SINI ---
bash ~/.termux_ui.sh
