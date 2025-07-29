/**
 * Cliente JavaScript para API do Ollama
 * Exemplo prático de integração com IA local
 */

class OllamaClient {
    constructor(baseUrl = 'http://localhost:11434') {
        this.baseUrl = baseUrl;
    }

    /**
     * Lista todos os modelos disponíveis
     */
    async listModels() {
        try {
            const response = await fetch(`${this.baseUrl}/api/tags`);
            return await response.json();
        } catch (error) {
            console.error('Erro ao listar modelos:', error);
            throw error;
        }
    }

    /**
     * Gera resposta para um prompt
     */
    async generate(prompt, model = 'llama2', stream = false, options = {}) {
        try {
            const data = {
                model,
                prompt,
                stream,
                ...options
            };

            const response = await fetch(`${this.baseUrl}/api/generate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });

            return await response.json();
        } catch (error) {
            console.error('Erro ao gerar resposta:', error);
            throw error;
        }
    }

    /**
     * Chat com histórico de mensagens
     */
    async chat(messages, model = 'llama2') {
        try {
            const data = {
                model,
                messages
            };

            const response = await fetch(`${this.baseUrl}/api/chat`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });

            return await response.json();
        } catch (error) {
            console.error('Erro no chat:', error);
            throw error;
        }
    }

    /**
     * Baixa um modelo específico
     */
    async pullModel(modelName) {
        try {
            const response = await fetch(`${this.baseUrl}/api/pull`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ name: modelName })
            });

            return await response.json();
        } catch (error) {
            console.error('Erro ao baixar modelo:', error);
            throw error;
        }
    }
}

// Exemplo de uso
async function main() {
    const client = new OllamaClient();

    try {
        // 1. Listar modelos disponíveis
        console.log('📋 Modelos disponíveis:');
        const models = await client.listModels();
        models.models?.forEach(model => {
            console.log(`  - ${model.name}`);
        });

        // 2. Gerar resposta simples
        console.log('\n🤖 Gerando resposta...');
        const response = await client.generate(
            'Explique o que é machine learning em 2 frases simples',
            'llama2'
        );
        console.log(`Resposta: ${response.response || 'Erro na resposta'}`);

        // 3. Chat com histórico
        console.log('\n💬 Chat com histórico:');
        const messages = [
            { role: 'user', content: 'Olá! Como você pode me ajudar?' },
            { role: 'assistant', content: 'Olá! Sou um assistente de IA e posso ajudar com várias tarefas.' },
            { role: 'user', content: 'Pode me dar 3 dicas para aprender JavaScript?' }
        ];

        const chatResponse = await client.chat(messages, 'llama2');
        console.log(`Resposta do chat: ${chatResponse.message?.content || 'Erro'}`);

    } catch (error) {
        console.error('Erro na execução:', error);
    }
}

// Executar se for o arquivo principal
if (typeof require !== 'undefined' && require.main === module) {
    main();
}

// Exportar para uso em módulos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = OllamaClient;
} 