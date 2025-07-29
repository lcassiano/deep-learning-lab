# 🤖 AI Integration Lab

Bem-vindo ao **AI Integration Lab**! Este repositório é uma coleção de exemplos práticos e tutoriais para integrar Inteligência Artificial em suas aplicações. Focamos em demonstrações hands-on usando ferramentas modernas como **Ollama**, **Docker**, e APIs REST.

## 🚀 Objetivo

Capacitar desenvolvedores e entusiastas a entender, implementar e integrar soluções de IA em aplicações reais, com foco em:
- Deploy de modelos locais com Ollama
- Integração via APIs REST
- Automação com Docker Compose
- Casos de uso práticos

## 📚 Conteúdo

Este repositório está organizado em exemplos práticos. Cada exemplo contém:

- 🐳 Configurações Docker Compose prontas para uso
- 📡 Exemplos de integração via API
- 🧪 Códigos de exemplo em Python/JavaScript
- 📖 Documentação detalhada
- 🗂 Referências e links úteis

### Exemplos disponíveis:

1. **🚀 Ollama com Docker Compose**
   - Deploy local do Ollama
   - Configuração de modelos
   - Primeiras queries via API

2. **🔗 Integração REST API**
   - Exemplos de clientes HTTP
   - Autenticação e rate limiting
   - Tratamento de respostas

3. **🤖 Chatbots e Assistantes**
   - Integração com aplicações web
   - Processamento de contexto
   - Geração de respostas inteligentes

4. **📊 Análise de Dados com IA**
   - Processamento de texto
   - Classificação de documentos
   - Extração de insights

5. **🔄 Automação e Workflows**
   - Integração com CI/CD
   - Processamento em lote
   - Monitoramento de performance

## 🛠 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Python 3.8+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

## 🚀 Primeiro Exemplo: Ollama com Docker Compose

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/ai-integration-lab.git
cd ai-integration-lab
```

### 2. Inicie o Ollama
```bash
docker-compose up -d ollama
```

### 3. Faça sua primeira query
```bash
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama2",
    "prompt": "Olá! Como você pode me ajudar hoje?",
    "stream": false
  }'
```

### 4. Exemplo em Python
```python
import requests
import json

def query_ollama(prompt, model="llama2"):
    url = "http://localhost:11434/api/generate"
    data = {
        "model": model,
        "prompt": prompt,
        "stream": False
    }
    
    response = requests.post(url, json=data)
    return response.json()

# Teste
response = query_ollama("Explique o que é machine learning em 2 frases")
print(response['response'])
```

## 📁 Estrutura do Projeto

```
ai-integration-lab/
├── docker-compose.yml          # Configuração do Ollama
├── examples/                   # Exemplos práticos
│   ├── python/                # Códigos Python
│   ├── javascript/            # Códigos JavaScript
│   └── bash/                  # Scripts bash
├── docs/                      # Documentação
└── README.md                  # Este arquivo
```

## 🔧 Configuração

### Docker Compose
O arquivo `docker-compose.yml` inclui:
- **Ollama**: Servidor local de modelos de IA
- **Redis** (opcional): Cache para respostas
- **Nginx** (opcional): Proxy reverso

### Variáveis de Ambiente
Crie um arquivo `.env`:
```env
OLLAMA_HOST=0.0.0.0
OLLAMA_PORT=11434
REDIS_URL=redis://redis:6379
```

## 📖 Documentação

- [Ollama API Reference](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Docker Compose Guide](https://docs.docker.com/compose/)
- [Python Requests](https://requests.readthedocs.io/)

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 🆘 Suporte

- 📧 Email: seu-email@exemplo.com
- 💬 Issues: [GitHub Issues](https://github.com/seu-usuario/ai-integration-lab/issues)
- 📚 Wiki: [Documentação completa](https://github.com/seu-usuario/ai-integration-lab/wiki)

---

⭐ Se este projeto te ajudou, considere dar uma estrela no repositório!
