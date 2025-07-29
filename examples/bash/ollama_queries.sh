#!/bin/bash

# Script de exemplos para API do Ollama
# Demonstra diferentes tipos de queries via curl

OLLAMA_URL="http://localhost:11434"
MODEL="llama2"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🤖 Ollama API Examples${NC}"
echo "=========================="

# Função para fazer query
query_ollama() {
    local prompt="$1"
    local model="${2:-$MODEL}"
    
    echo -e "${YELLOW}📝 Prompt:${NC} $prompt"
    echo -e "${YELLOW}🤖 Modelo:${NC} $model"
    echo -e "${GREEN}📡 Resposta:${NC}"
    
    curl -s -X POST "$OLLAMA_URL/api/generate" \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"$model\",
            \"prompt\": \"$prompt\",
            \"stream\": false
        }" | jq -r '.response'
    
    echo -e "\n${BLUE}---${NC}\n"
}

# Função para listar modelos
list_models() {
    echo -e "${YELLOW}📋 Modelos disponíveis:${NC}"
    curl -s "$OLLAMA_URL/api/tags" | jq -r '.models[].name'
    echo ""
}

# Função para chat
chat_ollama() {
    local messages="$1"
    local model="${2:-$MODEL}"
    
    echo -e "${YELLOW}💬 Chat:${NC}"
    echo -e "${GREEN}📡 Resposta:${NC}"
    
    curl -s -X POST "$OLLAMA_URL/api/chat" \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"$model\",
            \"messages\": $messages
        }" | jq -r '.message.content'
    
    echo -e "\n${BLUE}---${NC}\n"
}

# Verificar se o Ollama está rodando
check_ollama() {
    if ! curl -s "$OLLAMA_URL/api/tags" > /dev/null 2>&1; then
        echo -e "${RED}❌ Erro: Ollama não está rodando em $OLLAMA_URL${NC}"
        echo "Execute: docker-compose up -d ollama"
        exit 1
    fi
    echo -e "${GREEN}✅ Ollama está rodando!${NC}\n"
}

# Menu principal
show_menu() {
    echo -e "${BLUE}Escolha uma opção:${NC}"
    echo "1) Listar modelos disponíveis"
    echo "2) Query simples"
    echo "3) Chat com histórico"
    echo "4) Exemplos de prompts"
    echo "5) Sair"
    echo ""
}

# Exemplos de prompts
example_prompts() {
    echo -e "${BLUE}📚 Exemplos de prompts:${NC}"
    echo ""
    
    # Exemplo 1
    query_ollama "Explique o que é machine learning em 2 frases simples"
    
    # Exemplo 2
    query_ollama "Dê 3 dicas para aprender Python"
    
    # Exemplo 3
    query_ollama "Escreva um haiku sobre tecnologia"
    
    # Exemplo 4
    query_ollama "Explique o conceito de API REST de forma simples"
}

# Chat com histórico
example_chat() {
    echo -e "${BLUE}💬 Exemplo de chat com histórico:${NC}"
    
    local messages='[
        {"role": "user", "content": "Olá! Como você pode me ajudar?"},
        {"role": "assistant", "content": "Olá! Sou um assistente de IA e posso ajudar com várias tarefas."},
        {"role": "user", "content": "Pode me dar 3 dicas para aprender programação?"}
    ]'
    
    chat_ollama "$messages"
}

# Main
main() {
    check_ollama
    
    while true; do
        show_menu
        read -p "Digite sua escolha (1-5): " choice
        
        case $choice in
            1)
                list_models
                ;;
            2)
                read -p "Digite seu prompt: " prompt
                query_ollama "$prompt"
                ;;
            3)
                example_chat
                ;;
            4)
                example_prompts
                ;;
            5)
                echo -e "${GREEN}👋 Até logo!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opção inválida${NC}"
                ;;
        esac
        
        read -p "Pressione Enter para continuar..."
        clear
    done
}

# Executar se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi 