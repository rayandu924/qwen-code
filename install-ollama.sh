#!/bin/bash

echo "============================================"
echo "     Qwen Code - Installation avec Ollama"
echo "============================================"
echo

# Vérifier si Node.js est installé
if ! command -v node &> /dev/null; then
    echo "❌ Node.js n'est pas installé !"
    echo "📥 Installez Node.js depuis https://nodejs.org"
    exit 1
fi

# Vérifier si Ollama est installé
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama n'est pas installé !"
    echo "📥 Installez Ollama depuis https://ollama.ai"
    exit 1
fi

echo "✅ Node.js détecté : $(node --version)"
echo "✅ Ollama détecté : $(ollama --version)"

echo
echo "📦 Installation des dépendances..."
npm install
if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de l'installation des dépendances"
    exit 1
fi

echo
echo "🔨 Construction du projet..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de la construction"
    exit 1
fi

echo
echo "🌍 Installation globale..."
npm install -g .
if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de l'installation globale"
    echo "⚠️  Essayez avec sudo : sudo npm install -g ."
    exit 1
fi

echo
echo "🎯 Configuration des variables d'environnement..."

# Ajouter les variables au .bashrc ou .zshrc
SHELL_RC=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

echo "# Qwen Code avec Ollama" >> $SHELL_RC
echo "export OPENAI_API_KEY=\"ollama\"" >> $SHELL_RC
echo "export OPENAI_BASE_URL=\"http://localhost:11434/v1\"" >> $SHELL_RC
echo "export OPENAI_MODEL=\"qwen3:1.7b\"" >> $SHELL_RC

echo
echo "📚 Téléchargement du modèle Qwen (peut prendre quelques minutes)..."
echo "Téléchargement de qwen3:1.7b..."
ollama pull qwen3:1.7b
if [ $? -ne 0 ]; then
    echo "⚠️  Erreur lors du téléchargement du modèle"
    echo "💡 Vous pouvez le télécharger manuellement avec : ollama pull qwen3:1.7b"
fi

echo
echo "============================================"
echo "✅ Installation terminée avec succès !"
echo "============================================"
echo
echo "🚀 Pour utiliser Qwen Code :"
echo
echo "1. Rechargez votre terminal : source $SHELL_RC"
echo "2. Démarrez Ollama : ollama serve"
echo "3. Naviguez vers votre projet : cd votre-projet"
echo "4. Lancez Qwen Code : qwen"
echo
echo "📋 Modèles disponibles :"
echo "  - qwen3:1.7b (léger, déjà téléchargé)"
echo "  - qwen2.5-coder:7b (plus performant, à télécharger)"
echo "  - deepseek-coder:6.7b (spécialisé code)"
echo
echo "Pour télécharger un modèle plus performant :"
echo "  ollama pull qwen2.5-coder:7b"
echo