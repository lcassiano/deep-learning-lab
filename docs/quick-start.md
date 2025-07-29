# 🚀 Guia de Início Rápido

Este guia te ajudará a configurar e usar o AI Integration Lab em poucos minutos.

## 📋 Pré-requisitos

- Docker e Docker Compose instalados
- Python 3.8+ (para exemplos Python)
- Node.js (para exemplos JavaScript)
- Git

## ⚡ Configuração Rápida

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/ai-integration-lab.git
cd ai-integration-lab
```

### 2. Configure as variáveis de ambiente
```bash
cp env.example .env
# Edite o arquivo .env se necessário
```

### 3. Inicie o Ollama
```bash
docker-compose up -d ollama
```

### 4. Verifique se está funcionando
```bash
curl http://localhost:11434/api/tags
```

## 🧪 Primeiros Testes

### Teste via curl
```bash
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama2",
    "prompt": "Olá! Como você pode me ajudar?",
    "stream": false
  }'
```

### Teste via Python
```bash
pip install -r requirements.txt
python examples/python/ollama_client.py
```

### Teste via JavaScript
```bash
node examples/javascript/ollama_client.js
```

### Teste via Bash
```bash
chmod +x examples/bash/ollama_queries.sh
./examples/bash/ollama_queries.sh
```

## 📚 Próximos Passos

1. **Explore os exemplos**: Navegue pela pasta `examples/` para ver diferentes formas de integração
2. **Experimente diferentes modelos**: Use `docker exec -it ollama ollama list` para ver modelos disponíveis
3. **Crie seus próprios exemplos**: Use os templates fornecidos como base
4. **Contribua**: Adicione novos exemplos ou melhore os existentes

## 🔧 Configurações Avançadas

### Usando Redis para cache
```bash
docker-compose --profile cache up -d
```

### Usando Nginx como proxy
```bash
docker-compose --profile proxy up -d
```

### Baixando modelos específicos
```bash
docker exec -it ollama ollama pull llama2:7b
docker exec -it ollama ollama pull codellama:7b
```

## 🆘 Solução de Problemas

### Ollama não inicia
- Verifique se a porta 11434 está livre
- Execute `docker-compose logs ollama` para ver logs
- Verifique se Docker tem permissões adequadas

### Erro de conexão
- Verifique se o container está rodando: `docker ps`
- Teste a conectividade: `curl http://localhost:11434/api/tags`
- Reinicie o container: `docker-compose restart ollama`

### Modelo não encontrado
- Liste modelos disponíveis: `docker exec -it ollama ollama list`
- Baixe um modelo: `docker exec -it ollama ollama pull llama2`

## 📖 Recursos Adicionais

- [Documentação oficial do Ollama](https://ollama.ai/docs)
- [API Reference](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Exemplos de prompts](https://github.com/ollama/ollama/blob/main/docs/modelfile.md) 