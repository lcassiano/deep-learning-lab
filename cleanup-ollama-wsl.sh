#!/bin/bash

echo "🧹 LIMPEZA COMPLETA DO OLLAMA - WSL2"
echo "======================================"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "\n${BLUE}1. Parando serviço systemd (se existir):${NC}"
sudo systemctl stop ollama 2>/dev/null
sudo systemctl disable ollama 2>/dev/null
sudo systemctl mask ollama 2>/dev/null

echo -e "\n${BLUE}2. Matando processos Ollama:${NC}"
sudo pkill -9 ollama 2>/dev/null
sudo pkill -f ollama 2>/dev/null

echo -e "\n${BLUE}3. Parando containers Docker:${NC}"
docker stop $(docker ps -q) 2>/dev/null
docker-compose down 2>/dev/null

echo -e "\n${BLUE}4. Verificando se ainda há processos:${NC}"
ps aux | grep ollama

echo -e "\n${BLUE}5. Verificando portas:${NC}"
sudo ss -tulpn | grep :11434

echo -e "\n${BLUE}6. Verificando arquivos de configuração:${NC}"
find /etc -name "*ollama*" 2>/dev/null
find ~/.config -name "*ollama*" 2>/dev/null

echo -e "\n${YELLOW}=== PRÓXIMOS PASSOS ===${NC}"
echo "1. Se ainda houver processos, reinicie o WSL2:"
echo "   wsl --shutdown (no PowerShell)"
echo ""
echo "2. Depois inicie apenas via Docker:"
echo "   docker-compose up -d ollama" 