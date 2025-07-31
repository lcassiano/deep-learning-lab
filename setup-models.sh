#!/bin/bash

echo "🤖 CONFIGURANDO MODELOS OLLAMA"
echo "==============================="

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "\n${BLUE}1. Verificando modelos instalados:${NC}"
docker exec -it ollama ollama list

echo -e "\n${BLUE}2. Baixando modelos populares...${NC}"

# Array de modelos para baixar
models=(
    "llama2:7b"
    "mistral:7b"
    "codellama:7b"
)

for model in "${models[@]}"; do
    echo -e "\n${YELLOW}Baixando $model...${NC}"
    docker exec -it ollama ollama pull $model
done

echo -e "\n${BLUE}3. Verificando modelos instalados:${NC}"
docker exec -it ollama ollama list

echo -e "\n${GREEN}✅ Configuração concluída!${NC}"
echo -e "\n${YELLOW}Teste com:${NC}"
echo "curl -X POST http://localhost:11434/api/generate \\"
echo "  -H \"Content-Type: application/json\" \\"
echo "  -d '{\"model\": \"llama2\", \"prompt\": \"Olá!\", \"stream\": false}'" 