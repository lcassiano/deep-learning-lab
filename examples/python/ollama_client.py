#!/usr/bin/env python3
"""
Cliente Python para API do Ollama
Exemplo prático de integração com IA local
"""

import requests
import json
import time
from typing import Dict, Any, Optional

class OllamaClient:
    def __init__(self, base_url: str = "http://localhost:11434"):
        self.base_url = base_url
        self.session = requests.Session()
    
    def list_models(self) -> Dict[str, Any]:
        """Lista todos os modelos disponíveis"""
        response = self.session.get(f"{self.base_url}/api/tags")
        return response.json()
    
    def generate(self, prompt: str, model: str = "llama2", 
                stream: bool = False, **kwargs) -> Dict[str, Any]:
        """Gera resposta para um prompt"""
        data = {
            "model": model,
            "prompt": prompt,
            "stream": stream,
            **kwargs
        }
        
        response = self.session.post(f"{self.base_url}/api/generate", json=data)
        return response.json()
    
    def chat(self, messages: list, model: str = "llama2") -> Dict[str, Any]:
        """Chat com histórico de mensagens"""
        data = {
            "model": model,
            "messages": messages
        }
        
        response = self.session.post(f"{self.base_url}/api/chat", json=data)
        return response.json()
    
    def pull_model(self, model_name: str) -> Dict[str, Any]:
        """Baixa um modelo específico"""
        data = {"name": model_name}
        response = self.session.post(f"{self.base_url}/api/pull", json=data)
        return response.json()

def main():
    """Exemplo de uso do cliente"""
    client = OllamaClient()
    
    # 1. Listar modelos disponíveis
    print("📋 Modelos disponíveis:")
    models = client.list_models()
    for model in models.get('models', []):
        print(f"  - {model['name']}")
    
    # 2. Gerar resposta simples
    print("\n🤖 Gerando resposta...")
    response = client.generate(
        prompt="Explique o que é machine learning em 2 frases simples",
        model="llama2"
    )
    print(f"Resposta: {response.get('response', 'Erro na resposta')}")
    
    # 3. Chat com histórico
    print("\n💬 Chat com histórico:")
    messages = [
        {"role": "user", "content": "Olá! Como você pode me ajudar?"},
        {"role": "assistant", "content": "Olá! Sou um assistente de IA e posso ajudar com várias tarefas."},
        {"role": "user", "content": "Pode me dar 3 dicas para aprender Python?"}
    ]
    
    chat_response = client.chat(messages, model="llama2")
    print(f"Resposta do chat: {chat_response.get('message', {}).get('content', 'Erro')}")

if __name__ == "__main__":
    main() 